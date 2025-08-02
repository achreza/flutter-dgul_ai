import 'dart:convert';
import 'dart:io';

import 'package:dgul_ai/app/data/models/chat_message_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mime/mime.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatController extends GetxController {
  var messages = <ChatMessage>[].obs;
  var isLoading = false.obs;

  // State untuk pratinjau gambar dan file
  var selectedImagePath = ''.obs;
  var selectedFilePath = ''.obs;
  var selectedFileName = ''.obs;

  var pilihanJurusan = ''.obs;

  final _historyKey = 'chatMessages';
  final _jurusanKey = 'pilihanJurusan';

  var isListening = false.obs;
  final SpeechToText _speechToText = SpeechToText();

  final textController = TextEditingController();
  final scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  final GetStorage _storage = GetStorage();

  final List<String> jurusan = ["Nautika", "Teknika", "Industri Pelayaran"];

  final String _apiKey = dotenv.env['GEMINI_API_KEY'] ?? 'NO_API_KEY';

  final String _fileApiUploadUrl =
      'https://generativelanguage.googleapis.com/upload/v1beta/files';
  final String _generateContentUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent';

  @override
  void onInit() {
    super.onInit();
    _loadChatHistory();
    _loadChatHistory();
    _initSpeech();
  }

  void _initSpeech() async {
    await _speechToText.initialize();
  }

  void toggleListening() async {
    if (isListening.value) {
      // Hentikan mendengarkan
      await _speechToText.stop();
      isListening.value = false;
    } else {
      // Mulai mendengarkan
      bool available = await _speechToText.initialize();
      if (available) {
        isListening.value = true;
        _speechToText.listen(
          onResult: (result) {
            textController.text = result.recognizedWords;
          },
        );
      }
    }
  }

  void clearChatHistory() {
    // Tampilkan dialog konfirmasi
    Get.defaultDialog(
        title: "Hapus Riwayat Chat",
        middleText: "Apakah Anda yakin ingin menghapus seluruh percakapan?",
        textConfirm: "Hapus",
        textCancel: "Batal",
        confirmTextColor: Colors.white,
        onConfirm: () {
          // Hapus dari state
          messages.clear();
          pilihanJurusan.value = '';

          // Hapus dari local storage
          _storage.remove(_historyKey);
          _storage.remove(_jurusanKey);

          // Tambahkan kembali pesan selamat datang
          _addWelcomeMessage();

          // Tutup dialog
          Get.back();
        });
  }

  void _loadChatHistory() {
    List? storedMessages = _storage.read<List>('chatMessages');
    if (storedMessages != null) {
      messages.value = storedMessages
          .map((e) => ChatMessage.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      // Jika riwayat kosong setelah dimuat, tambahkan pesan selamat datang
      if (messages.isEmpty) _addWelcomeMessage();
    } else {
      // Jika tidak ada riwayat sama sekali
      _addWelcomeMessage();
    }

    pilihanJurusan.value = _storage.read('pilihanJurusan') ?? '';
  }

  void _saveChatHistory() {
    _storage.write('chatMessages', messages.map((e) => e.toJson()).toList());
    _storage.write('pilihanJurusan', pilihanJurusan.value);
  }

  void _addWelcomeMessage() {
    messages.add(
      ChatMessage(
        text:
            "Halo! Saya adalah D'Gul AI, asisten maritim Anda. Silakan pilih bidang keahlian Anda untuk memulai.",
        sender: Sender.ai,
      ),
    );
  }

  // --- FUNGSI BARU UNTUK MEMILIH FILE ---
  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
    );
    if (result != null && result.files.single.path != null) {
      selectedFilePath.value = result.files.single.path!;
      selectedFileName.value = result.files.single.name;
      // Batalkan pilihan gambar jika ada
      selectedImagePath.value = '';
    }
  }

  void cancelFileSelection() {
    selectedFilePath.value = '';
    selectedFileName.value = '';
  }

  // ... (fungsi pickImage dan cancelImageSelection tetap sama) ...
  void pickImage(ImageSource source) async {
    final XFile? image =
        await _picker.pickImage(source: source, imageQuality: 85);
    if (image != null) {
      selectedImagePath.value = image.path;
      // Batalkan pilihan file jika ada
      cancelFileSelection();
    }
  }

  void cancelImageSelection() {
    selectedImagePath.value = '';
  }

  // ... (fungsi selectJurusan tetap sama) ...
  void selectJurusan(String jurusanPilihan) async {
    pilihanJurusan.value = jurusanPilihan;
    messages.add(ChatMessage(text: jurusanPilihan, sender: Sender.user));
    _scrollToBottom();
    isLoading.value = true;
    _saveChatHistory(); // Simpan pilihan jurusan

    try {
      final promptKonfirmasi =
          "Anda adalah D'Gul AI. Pengguna memilih bidang keahlian '$jurusanPilihan'. Beri respons singkat & ramah untuk mengkonfirmasi pilihan ini dan persilakan mereka bertanya.";
      final aiResponseData = await _callGeminiApi(history: [
        {
          'role': 'user',
          'parts': [
            {'text': promptKonfirmasi}
          ]
        }
      ], saveHistory: false);
      messages.add(ChatMessage(
          text: aiResponseData['text']!,
          sender: Sender.ai,
          tokenCount: aiResponseData['tokenCount']));
    } catch (e) {
      _showError(e.toString());
    } finally {
      isLoading.value = false;
      _scrollToBottom();
      _saveChatHistory();
    }
  }

  // --- FUNGSI BARU UNTUK UPLOAD FILE KE GOOGLE ---
  Future<Map<String, dynamic>> _uploadFileToGemini(String filePath) async {
    final file = File(filePath);
    final fileBytes = await file.readAsBytes();
    final mimeType = lookupMimeType(filePath) ?? 'application/octet-stream';

    final request =
        http.Request('POST', Uri.parse('$_fileApiUploadUrl?key=$_apiKey'));
    request.headers.addAll({
      'Content-Type': mimeType,
      'X-Goog-Upload-Protocol': 'raw',
    });
    request.bodyBytes = fileBytes;

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(responseBody);
      return {
        'uri': decodedResponse['file']['uri'],
        'mimeType': decodedResponse['file']['mimeType'],
      };
    } else {
      throw Exception(
          'Gagal meng-upload file: ${response.statusCode} - $responseBody');
    }
  }

  Future<void> sendMessage() async {
    final text = textController.text.trim();
    final imagePath = selectedImagePath.value;
    final filePath = selectedFilePath.value; // Dapatkan path file
    final fileName = selectedFileName.value; // Dapatkan nama file

    if (text.isEmpty && imagePath.isEmpty && filePath.isEmpty) return;
    if (_apiKey == 'NO_API_KEY') {
      _showError("API Key tidak ditemukan.");
      return;
    }

    isLoading.value = true;

    Map<String, dynamic>? fileData;
    if (filePath.isNotEmpty) {
      try {
        fileData = await _uploadFileToGemini(filePath);
      } catch (e) {
        _showError("Gagal memproses file: $e");
        isLoading.value = false;
        return;
      }
    }

    messages.add(ChatMessage(
      text: text,
      sender: Sender.user,
      imagePath: imagePath,
      fileName: fileName, // Simpan nama file ke pesan
    ));

    textController.clear();
    selectedImagePath.value = '';
    cancelFileSelection(); // Bersihkan pilihan file
    _scrollToBottom();
    _saveChatHistory();

    try {
      List<Map<String, dynamic>> history = [];
      // Loop untuk membangun riwayat
      for (var msg in messages) {
        if (msg.text.contains("Halo! Saya adalah D'Gul AI") ||
            msg.text.contains("Terjadi kesalahan")) continue;

        final role = msg.sender == Sender.user ? 'user' : 'model';
        List<Map<String, dynamic>> parts = [];

        // --- Logika Prompt Kontekstual ---
        String promptText = msg.text;
        if (role == 'user' &&
            msg.text.isNotEmpty &&
            pilihanJurusan.isNotEmpty) {
          promptText =
              "Anda adalah D'Gul AI, ahli maritim. Konteks: ${pilihanJurusan.value}. Jawab: '${msg.text}'";
        }

        // --- LOGIKA UNTUK MENYERTAKAN FILE DATA ATAU GAMBAR ---
        if (msg == messages.last) {
          // Hanya untuk pesan terakhir yang dikirim
          if (promptText.isNotEmpty) parts.add({'text': promptText});

          if (imagePath.isNotEmpty) {
            final bytes = await File(imagePath).readAsBytes();
            parts.add({
              'inline_data': {
                'mime_type': 'image/jpeg',
                'data': base64Encode(bytes)
              }
            });
          } else if (fileData != null) {
            // Sertakan file URI yang didapat dari upload
            parts.add({
              'file_data': {
                'mime_type': fileData['mimeType'],
                'file_uri': fileData['uri']
              }
            });
          }
        } else {
          if (msg.text.isNotEmpty) parts.add({'text': msg.text});
        }

        if (parts.isNotEmpty) {
          history.add({'role': role, 'parts': parts});
        }
      }

      final aiResponseData = await _callGeminiApi(history: history);

      messages.add(ChatMessage(
        text: aiResponseData['text']!,
        sender: Sender.ai,
        tokenCount: aiResponseData['tokenCount'],
      ));
    } catch (e) {
      _showError("Terjadi kesalahan: $e");
    } finally {
      isLoading.value = false;
      _scrollToBottom();
      _saveChatHistory();
    }
  }

  Future<Map<String, dynamic>> _callGeminiApi(
      {required List<Map<String, dynamic>> history,
      bool saveHistory = true}) async {
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'contents': history});
    final response = await http.post(
        Uri.parse('$_generateContentUrl?key=$_apiKey'),
        headers: headers,
        body: body);

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      String responseText = "Maaf, saya tidak bisa memberikan respons.";
      if (decodedResponse['candidates'] != null &&
          decodedResponse['candidates'].isNotEmpty) {
        responseText =
            decodedResponse['candidates'][0]['content']['parts'][0]['text'];
      }
      final tokenCount =
          decodedResponse['usageMetadata']?['totalTokenCount'] as int?;
      return {'text': responseText, 'tokenCount': tokenCount};
    } else {
      final errorResponse = jsonDecode(response.body);
      final errorMessage =
          errorResponse['error']?['message'] ?? 'Unknown API Error';
      throw Exception(
          'Gagal terhubung ke API: ${response.statusCode} - $errorMessage');
    }
  }

  void _showError(String message) {
    messages.add(
        ChatMessage(text: "Terjadi kesalahan: $message", sender: Sender.ai));
  }

  void _scrollToBottom() {
    // ... (Fungsi ini tetap sama)
  }

  @override
  void onClose() {
    super.onClose();
    textController.dispose();
    scrollController.dispose();
    _speechToText.stop();
  }
}
