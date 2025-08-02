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

  var selectedImagePath = ''.obs;
  var selectedFilePath = ''.obs;
  var selectedFileName = ''.obs;
  var selectedLanguage = 'Indonesia'.obs;

  // --- STATE BARU UNTUK DROPDOWN ---
  var selectedWorkType = 'Maritime Worker'.obs;

  var isListening = false.obs;
  final SpeechToText _speechToText = SpeechToText();

  final textController = TextEditingController();
  final scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  final GetStorage _storage = GetStorage();
  final _historyKey = 'chatMessages';
  final _workTypeKey = 'selectedWorkType';

  // --- DAFTAR OPSI BARU UNTUK DROPDOWN ---
  final List<String> maritimeWorkTypes = [
    "Maritime Worker",
    "Perusahaan Pelayaran",
    "Perusahaan Fasilitas Pelabuhan & Terminal",
    "Perusahaan Keagenan Kapal",
    "Perusahaan Galangan Kapal",
    "Perusahaan Pemilik Muatan",
    "Pemerintah dan Regulator",
    "Diklat Kepelautan",
    "Diklat Kelautan & Perikanan",
    "Biro Klasifikasi",
    "Perusahaan Shipchandler",
    "Perusahaan Perbaikan dan Perawatan kapal",
    "Asosiasi / Organisasi Industri Maritim",
    "Masyarakat Maritim",
  ];

  final List<String> suggestionPrompts = [
    "Information and Communication",
    "Education and Career Development",
    "Inspiration and Motivation",
  ];

  final String _apiKey = dotenv.env['GEMINI_API_KEY'] ?? 'NO_API_KEY';
  final String _fileApiUploadUrl =
      'https://generativelanguage.googleapis.com/upload/v1beta/files';
  final String _generateContentUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent';

  @override
  void onInit() {
    super.onInit();
    _loadChatHistory();
    _initSpeech();
  }

  void _initSpeech() async {
    await _speechToText.initialize();
  }

  void toggleListening() async {
    if (isListening.value) {
      await _speechToText.stop();
      isListening.value = false;
    } else {
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

  void _loadChatHistory() {
    List? storedMessages = _storage.read<List>(_historyKey);
    if (storedMessages != null && storedMessages.isNotEmpty) {
      messages.value = storedMessages
          .map((e) => ChatMessage.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } else {
      _addWelcomeMessage();
    }
    selectedWorkType.value = _storage.read(_workTypeKey) ?? 'Maritime Worker';
  }

  void _saveChatHistory() {
    _storage.write(_historyKey, messages.map((e) => e.toJson()).toList());
    _storage.write(_workTypeKey, selectedWorkType.value);
  }

  void _addWelcomeMessage() {
    messages.clear();
    messages.add(
      ChatMessage(
        text: "Ahooy, D'Gul!",
        sender: Sender.ai,
      ),
    );
  }

  void clearChatHistory() {
    Get.defaultDialog(
        title: "Hapus Riwayat Chat",
        middleText: "Apakah Anda yakin ingin menghapus seluruh percakapan?",
        textConfirm: "Hapus",
        textCancel: "Batal",
        confirmTextColor: Colors.white,
        onConfirm: () {
          _storage.remove(_historyKey);
          _addWelcomeMessage();
          Get.back();
        });
  }

  // --- FUNGSI BARU UNTUK MENGUBAH TIPE PEKERJAAN ---
  void selectWorkType(String workType) {
    selectedWorkType.value = workType;
    _saveChatHistory(); // Simpan pilihan baru
    // Anda bisa menambahkan pesan konfirmasi di chat jika mau
    // messages.add(ChatMessage(text: "Konteks diubah menjadi: $workType", sender: Sender.ai));
  }

  void sendSuggestion(String suggestionText) {
    textController.text = suggestionText;
    sendMessage();
  }

  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
    );
    if (result != null && result.files.single.path != null) {
      selectedFilePath.value = result.files.single.path!;
      selectedFileName.value = result.files.single.name;
      selectedImagePath.value = '';
    }
  }

  void cancelFileSelection() {
    selectedFilePath.value = '';
    selectedFileName.value = '';
  }

  void pickImage(ImageSource source) async {
    final XFile? image =
        await _picker.pickImage(source: source, imageQuality: 85);
    if (image != null) {
      selectedImagePath.value = image.path;
      cancelFileSelection();
    }
  }

  void cancelImageSelection() {
    selectedImagePath.value = '';
  }

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
    final filePath = selectedFilePath.value;
    final fileName = selectedFileName.value;

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
      fileName: fileName,
    ));
    textController.clear();
    selectedImagePath.value = '';
    cancelFileSelection();
    _scrollToBottom();
    _saveChatHistory();

    try {
      List<Map<String, dynamic>> history = [];
      for (var msg in messages) {
        if (msg.text.contains("Ahooy, D'Gul!") ||
            msg.text.contains("Terjadi kesalahan")) continue;
        final role = msg.sender == Sender.user ? 'user' : 'model';
        List<Map<String, dynamic>> parts = [];
        String promptText = msg.text;
        if (role == 'user' && msg.text.isNotEmpty) {
          promptText =
              "Anda adalah D'Gul AI, seorang ahli maritim. Dalam konteks sebagai '${selectedWorkType.value}', jawab pertanyaan berikut: '${msg.text}'";
          parts.add({'text': promptText});
        } else if (msg.text.isNotEmpty) {
          parts.add({'text': msg.text});
        }
        if (msg == messages.last) {
          if (imagePath.isNotEmpty) {
            final bytes = await File(imagePath).readAsBytes();
            parts.add({
              'inline_data': {
                'mime_type': 'image/jpeg',
                'data': base64Encode(bytes)
              }
            });
          } else if (fileData != null) {
            parts.add({
              'file_data': {
                'mime_type': fileData['mimeType'],
                'file_uri': fileData['uri']
              }
            });
          }
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
      {required List<Map<String, dynamic>> history}) async {
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
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    textController.dispose();
    scrollController.dispose();
    _speechToText.stop();
  }
}
