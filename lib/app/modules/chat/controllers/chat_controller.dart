import 'dart:convert';
import 'dart:io';

import 'package:dgul_ai/app/data/dto/requests/update_profile_request.dart';
import 'package:dgul_ai/app/data/dto/responses/all_package_response.dart';
import 'package:dgul_ai/app/data/dto/responses/create_transaction_response.dart';
import 'package:dgul_ai/app/data/dto/responses/single_message_response.dart';
import 'package:dgul_ai/app/data/dto/responses/transaction_status_response.dart';
import 'package:dgul_ai/app/data/dto/responses/update_profile_response.dart';
import 'package:dgul_ai/app/data/models/chat_message_model.dart';
import 'package:dgul_ai/app/modules/auth/controllers/auth_controller.dart';
import 'package:dgul_ai/app/modules/auth/controllers/user_controller.dart';
import 'package:dgul_ai/app/modules/chat/views/web_view_page.dart';
import 'package:dgul_ai/app/services/chat_service.dart';
import 'package:dgul_ai/app/services/payment_service.dart';
import 'package:dgul_ai/app/services/user_service.dart';
import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/app/utitls/rloaders.dart';
import 'package:dgul_ai/app/widgets/loading_popup.dart';
import 'package:dgul_ai/app/widgets/subscription_promo_sheet.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:mime/mime.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatController extends GetxController {
  var messages = <ChatMessage>[].obs;
  var isLoading = false.obs;

  var selectedImagePath = ''.obs;
  var selectedFilePath = ''.obs;
  var selectedFileName = ''.obs;
  var selectedPhotoProfilePath = ''.obs;
  var selectedLanguage = 'id_ID'.obs; // Menyimpan kode locale
  var userController = Get.find<UserController>();
  var userService = UserService();
  var _chatService = ChatService();
  var paymentService = PaymentService();
  var isTextEmpty = true.obs;

  // --- STATE BARU UNTUK DROPDOWN ---
  var selectedWorkType = 'Seafarer'.obs;
  var selectedRole = 'Seafarer'.obs;
  RxInt selectedSuggestion = 0.obs;

  var isListening = false.obs;
  final SpeechToText _speechToText = SpeechToText();

  final textController = TextEditingController();
  final scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  final GetStorage _storage = GetStorage();
  final _historyKey = 'chatMessages';
  final _workTypeKey = 'selectedWorkType';
  final _langKey = 'selectedLanguage'; // Key baru untuk bahasa
  var allPackage = AllPackageResponse();

  //untuk update profile

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController positionController = TextEditingController();

  void addInitialProfileData() {
    emailController.text = userController.profileData.user?.email ?? '';
    phoneController.text = userController.profileData.user?.phone ?? '';
    departmentController.text =
        userController.profileData.user?.department ?? '';
    positionController.text = userController.profileData.user?.position ?? '';
    selectedWorkType.value = userController.profileData.user?.role == 'seafarer'
        ? 'Seafarer'
        : 'Maritime Worker';
    selectedRole.value = userController.profileData.user?.role == 'seafarer'
        ? 'Seafarer'
        : 'Maritime Worker';
  }

  // --- DAFTAR OPSI BARU UNTUK DROPDOWN ---
  final List<String> maritimeWorkTypes = [
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

  final List<String> seafarerWorkTypes = [
    "Deck Department",
    "Engine Department",
    "Catering Department",
  ];

  final List<String> suggestionPrompts = [
    "suggestion_1".tr,
    "suggestion_2".tr,
    "suggestion_3".tr,
  ];

  final List<String> subSuggestion1Prompts = [
    "sub_suggestion_1_1".tr,
    "sub_suggestion_1_2".tr,
    "sub_suggestion_1_3".tr,
  ];

  final List<String> subSuggestion2Prompts = [
    "sub_suggestion_2_1".tr,
    "sub_suggestion_2_2".tr,
    "sub_suggestion_2_3".tr,
  ];

  final List<String> subSuggestion3Prompts = [
    "sub_suggestion_3_1".tr,
    "sub_suggestion_3_2".tr,
    "sub_suggestion_3_3".tr,
  ];

  final List<String> fotoSuggestionPrompts = [
    "foto_suggestion_1".tr,
    "foto_suggestion_2".tr,
    "foto_suggestion_3".tr,
  ];

  final List<String> documentSuggestionPrompts = [
    "document_suggestion_1".tr,
    "document_suggestion_2".tr,
    "document_suggestion_3".tr,
  ];

  final String _apiKey = dotenv.env['GEMINI_API_KEY'] ?? 'NO_API_KEY';
  final String _fileApiUploadUrl =
      'https://generativelanguage.googleapis.com/upload/v1beta/files';
  final String _generateContentUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent';

  var selectedPlan = '1-Year'.obs;
  var isEditMode = false.obs;

  void uploadImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      update();
    }
  }

  void selectProfilePhoto() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90, // Kualitas gambar yang lebih tinggi untuk di-crop
    );

    // Jika pengguna memilih sebuah file
    if (pickedFile != null) {
      // 2. Lanjutkan ke proses cropping
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        // Opsi cropStyle: CropStyle.circle sangat cocok untuk foto profil

        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Profile Photo',
            toolbarColor: RColor().primaryBlueColor, // Ganti dengan warna Anda
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true, // Kunci rasio agar tetap persegi
            activeControlsWidgetColor: RColor().primaryYellowColor,
          ),
          IOSUiSettings(
            title: 'Crop Photo',
            aspectRatioLockEnabled: true,
            resetAspectRatioEnabled: false,
          ),
        ],
      );

      // 3. Jika pengguna menyelesaikan proses crop, perbarui path gambar
      if (croppedFile != null) {
        selectedPhotoProfilePath.value = croppedFile.path;
        // update(); // Tidak perlu jika menggunakan .obs
      }
    }
  }

  Future<void> refreshSubscriptionProfile() async {
    try {
      final userController = Get.find<UserController>();
      LoadingPopup.show(Get.overlayContext!);

      userController.assignProfileData(await userService.getProfileData());
      // Lakukan sesuatu dengan status

      LoadingPopup.hide(Get.overlayContext!);
      RLoaders.showStatusDialog(
          context: Get.overlayContext!,
          status: userController.profileData.user?.isSubscription == 1
              ? DialogStatus.success
              : DialogStatus.failed,
          title: 'Subscription Status',
          message:
              'Subscription status is ${userController.profileData.user?.isSubscription == 1 ? 'Active' : 'Inactive'}.');
    } catch (e) {
      LoadingPopup.hide(Get.overlayContext!);
      Logger().e("Error checking subscription status: $e");
    }
  }

  void updateProfile() async {
    try {
      if (isEditMode.value) {
        // Ambil data dari controller

        String? email = UserController().profileData.user?.email;
        String phone = phoneController.text;
        String department = departmentController.text;
        String position = positionController.text;

        MultipartFile? profilePhoto;
        UpdateProfileRequest? request;

        LoadingPopup.show(Get.overlayContext!);

        if (selectedPhotoProfilePath.value.isNotEmpty) {
          profilePhoto = MultipartFile(File(selectedPhotoProfilePath.value),
              filename: selectedPhotoProfilePath.value.split('/').last);
          request = UpdateProfileRequest(
            email: email,
            phone: phone,
            department: department,
            position: position,
            profilePhoto: profilePhoto,
          );
        } else {
          request = UpdateProfileRequest(
            email: email,
            phone: phone,
            department: department,
            position: position,
          );
        }

        Logger().i("Updating profile with data: $request");

        // Panggil service untuk update profile
        UpdateProfileResponse response =
            await userService.updateProfile(request);
        if (response != null) {
          userController.assignProfileDataAfterUpdate(response);
        }
        LoadingPopup.hide(Get.overlayContext!);
      }
    } catch (e) {
      Logger().e("Error updating profile: $e");
      LoadingPopup.hide(Get.overlayContext!);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadChatHistory();

    _initSpeech();
    _loadLanguage(); // Memuat preferensi bahasa
    textController.addListener(() {
      isTextEmpty.value = textController.text.isEmpty;
    });
  }

  @override
  void onReady() async {
    super.onReady();
    await getAllPackages();
    addInitialProfileData();
  }

  Future<void> getAllPackages() async {
    try {
      LoadingPopup.show(Get.overlayContext!);
      var packages = await paymentService.fetchAllPackages();
      allPackage = packages;
      LoadingPopup.hide(Get.overlayContext!);
      // SubscriptionPromoSheet.show();
    } catch (e) {
      LoadingPopup.hide(Get.overlayContext!);
      Logger().e("Error fetching packages: $e");
    }
  }

  void _initSpeech() async {
    await _speechToText.initialize();
  }

  void selectPlan(String plan) {
    selectedPlan.value = plan;
  }

  Future<void> createTransaction(int paketId, String? voucherCode) async {
    try {
      LoadingPopup.show(Get.overlayContext!);
      Logger().i('⏳ Memanggil PaymentService().createTransaction...');
      CreateTransactionResponse paymentCreateTransactionResponse =
          await paymentService.createTransaction(paketId, voucherCode);

      //save orders id to storage
      _storage.write('orderId', paymentCreateTransactionResponse.data!.orderId);
      Logger().i('✅ Transaction created successfully.');

      LoadingPopup.hide(Get.overlayContext!);
      Get.to(() => WebViewPage(
            url: paymentCreateTransactionResponse.data!.paymentUrl!,
          ));
    } catch (e) {
      LoadingPopup.hide(Get.overlayContext!);
      Logger().e("Error creating transaction: $e");
      Get.snackbar('Error', 'Failed to create transaction. Please try again.',
          snackPosition: SnackPosition.BOTTOM);
    }
    update();
  }

  Future<void> checkStatusSubscription() async {
    try {
      LoadingPopup.show(Get.overlayContext!);
      //check ordedr id from storage
      int? orderId = _storage.read('orderId');
      if (orderId == null) {
        throw Exception('Order ID not found in storage.');
      }
      Logger().i('⏳ Checking subscription status for order ID: $orderId');
      TransactionStatusResponse isSubscription =
          await paymentService.checkTransactionStatus(orderId.toString());
      if (isSubscription.data!.status == 'settlement') {
        // userController.profileData.user?.isSubscription = 1;
        userController.update();
        Logger().i('✅ Subscription active.');
        LoadingPopup.hide(Get.overlayContext!);
        RLoaders.showStatusDialog(
            context: Get.overlayContext!,
            status: DialogStatus.success,
            title: 'Subscription Status',
            message: 'Your subscription is active.');
      } else {
        // userController.profileData.user?.isSubscription = 0;
        userController.update();
        Logger().i('❌ No active subscription.');
        LoadingPopup.hide(Get.overlayContext!);
        RLoaders.showStatusDialog(
            context: Get.overlayContext!,
            status: DialogStatus.failed,
            title: 'Subscription Status',
            message: 'No active subscription found.');
      }
    } catch (e) {
      LoadingPopup.hide(Get.overlayContext!);
      Logger().e("Error checking subscription: $e");
      Get.snackbar('Error', 'Failed to check subscription. Please try again.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void toggleEditMode() {
    isEditMode.value = !isEditMode.value;
  }

  void _loadLanguage() {
    String langCode = _storage.read(_langKey) ?? 'id_ID';
    selectedLanguage.value = langCode;
    var locale = langCode == 'id_ID'
        ? const Locale('id', 'ID')
        : const Locale('en', 'US');

    // Tunda pembaruan locale ke frame berikutnya untuk menghindari error build
    Future.delayed(Duration.zero, () {
      Get.updateLocale(locale);
    });
  }

  void logout() {
    try {
      _storage.remove('accessToken');
      _storage.remove('userData');

      // Kosongkan data di UserController
      Get.find<UserController>().clearUserData();

      // Arahkan ke halaman login
      Get.offAllNamed('/auth');
      LoadingPopup.hide(Get.overlayContext!);
    } catch (e) {
      print("Error logging out: $e");
    }
  }

  void changeLanguage(String langCode) async {
    //show loading
    LoadingPopup.show(Get.overlayContext!);
    selectedLanguage.value = langCode;
    var locale = langCode == 'id_ID'
        ? const Locale('id', 'ID')
        : const Locale('en', 'US');
    Get.updateLocale(locale);
    _storage.write(_langKey, langCode);
    var language = langCode == 'id_ID' ? 'id' : 'en';
    await userService.updateLanguage(language);
    LoadingPopup.hide(Get.overlayContext!);
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
    sendMessageToDGULAPI();
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
      // Panggil fungsi crop setelah gambar dipilih
      _cropImage(image.path);
    }
  }

  Future<void> _cropImage(String filePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Potong Gambar',
            toolbarColor: RColor().primaryBlueColor, // Ganti dengan warna Anda
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Potong Gambar',
        ),
      ],
    );

    // Jika pengguna menyelesaikan proses crop, gunakan gambar yang baru
    if (croppedFile != null) {
      selectedImagePath.value = croppedFile.path;
      // Hapus pilihan file jika ada
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

  Future<void> sendMessageToDGULAPI() async {
    final text = textController.text.trim();
    final imagePath = selectedImagePath.value;
    final filePath = selectedFilePath.value;

    if (text.isEmpty) return;

    isLoading.value = true;
    Map<String, dynamic>? fileData;

    messages.add(ChatMessage(
      text: text,
      sender: Sender.user,
      imagePath: selectedImagePath.value,
      fileName: selectedFileName.value,
    ));

    textController.clear();
    _scrollToBottom();
    _saveChatHistory();

    if (imagePath.isNotEmpty) {
      try {
        Logger().d("Pesan user: $text");
        final SingleMessageResponse aiResponse =
            await _chatService.sendSingleMessageWithImage(
                text,
                MultipartFile(selectedImagePath.value,
                    filename: selectedImagePath.value.split('/').last));
        final responseText =
            aiResponse.message?.content ?? "Received an empty response.";

        messages.add(ChatMessage(
          text: responseText,
          sender: Sender.ai,
          tokenCount: aiResponse.metadata?.usage?.totalTokenCount,
        ));

        final int currentTokenInt = userController.profileData.user?.token ?? 0;

        final int tokenUsed = aiResponse.metadata?.usage?.totalTokenCount ?? 0;

        final int newTotalToken = currentTokenInt - tokenUsed;

        userController.profileData.user?.token = newTotalToken;
      } catch (e) {
        _showError("Gagal memproses file: $e");
        isLoading.value = false;
        return;
      } finally {
        isLoading.value = false;
        textController.clear();
        selectedImagePath.value = '';
        cancelFileSelection();
        _scrollToBottom();
        _saveChatHistory();
      }
    } else {
      try {
        Logger().d("Mengirim pesan tanpa file");
        final SingleMessageResponse aiResponse =
            await _chatService.sendSingleMessage(text);
        final responseText =
            aiResponse.message?.content ?? "Received an empty response.";

        messages.add(ChatMessage(
          text: responseText,
          sender: Sender.ai,
          tokenCount: aiResponse.metadata?.usage?.totalTokenCount,
        ));
      } catch (e) {
        _showError("$e");
        isLoading.value = false;
      } finally {
        isLoading.value = false;
        textController.clear();
        selectedImagePath.value = '';
        cancelFileSelection();
        _scrollToBottom();
        _saveChatHistory();
      }
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
