import 'package:dgul_ai/app/data/dto/responses/login_response.dart';
import 'package:dgul_ai/app/data/dto/responses/login_response.dart' as lr;
import 'package:dgul_ai/app/modules/auth/controllers/user_controller.dart';
import 'package:dgul_ai/app/modules/chat/controllers/chat_controller.dart';
import 'package:dgul_ai/app/services/auth_service.dart';
import 'package:dgul_ai/app/services/user_service.dart';
import 'package:dgul_ai/app/utitls/rloaders.dart';
import 'package:dgul_ai/app/widgets/loading_popup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final RxBool isLoading = false.obs;
  final GetStorage _storage = GetStorage();

  final AuthService authService = AuthService();
  final UserService userService = UserService();

  final RxString selectedRole = 'Seafarer'.obs;
  final RxString selectedLanguage = 'Indonesia'.obs;
  var selectedLanguageCode = 'id_ID'.obs; // Menyimpan kode locale
  final _langKey = 'selectedLanguage'; // Key baru untuk bahasa

  @override
  void onInit() {
    super.onInit();
    _loadLanguage();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      autoLogin();
    });
  }

  void _loadLanguage() {
    String langCode = _storage.read(_langKey) ?? 'id_ID';
    selectedLanguageCode.value = langCode;
    var locale = langCode == 'id_ID'
        ? const Locale('id', 'ID')
        : const Locale('en', 'US');

    // Tunda pembaruan locale ke frame berikutnya untuk menghindari error build
    Future.delayed(Duration.zero, () {
      Get.updateLocale(locale);
    });
  }

  void changeLanguage(String langCode) {
    selectedLanguageCode.value = langCode;
    var locale = langCode == 'id_ID'
        ? const Locale('id', 'ID')
        : const Locale('en', 'US');
    Get.updateLocale(locale);
    _storage.write(_langKey, langCode);
  }

  void autoLogin() async {
    final token = _storage.read('accessToken');

    // Jika token ditemukan di storage
    if (token != null) {
      LoadingPopup.show(Get.context!);
      Logger().d("Auto Login with token: $token");
      final userData = _storage.read<Map<String, dynamic>>('userData');
      if (userData != null) {
        final user = lr.User.fromJson(userData);

        // Gunakan Get.find() untuk mengakses instance UserController yang sudah ada
        final userController = Get.find<UserController>();
        userController.assignLoginData(
          token,
          user.id!.toString(),
          user.name!,
          user.email!,
        );
        userController.assignProfileData(await userService.getProfileData());
        LoadingPopup.hide(Get.context!);

        Future.delayed(Duration.zero, () {
          Get.offAllNamed('/chat');
        });
      }
    }
  }

  Future<void> login() async {
    isLoading.value = true;
    LoadingPopup.show(Get.context!);
    final response = await authService.login(
      emailController.text,
      passwordController.text,
    );
    isLoading.value = false;
    LoadingPopup.hide(Get.context!);

    if (response.isOk) {
      final loginResponse = LoginResponse.fromJson(response.body);
      // --- SIMPAN DATA KE STORAGE ---
      _storage.write('accessToken', loginResponse.accessToken);
      _storage.write('userData',
          loginResponse.user!.toJson()); // Pastikan User model punya toJson()

      // Gunakan Get.find() untuk mengakses instance UserController
      final userController = Get.find<UserController>();

      userController.assignLoginData(
        loginResponse.accessToken!,
        loginResponse.user!.id!.toString(),
        loginResponse.user!.name!,
        loginResponse.user!.email!,
      );
      userController.assignProfileData(await userService.getProfileData());

      Get.offAllNamed('/chat');
      Get.put(ChatController());
    } else {
      // Handle login error
      RLoaders.showStatusDialog(
        context: Get.context!,
        status: DialogStatus.failed,
        title: 'Login Failed',
        message: response.body['message'] ?? 'Unknown error',
      );
    }
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    try {
      // 1. Memicu alur autentikasi Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Jika pengguna membatalkan login
      if (googleUser == null) {
        isLoading.value = false;
        return;
      }

      // 2. Mendapatkan detail autentikasi dari request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 3. Membuat kredensial baru untuk Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Masuk ke Firebase dengan kredensial tersebut
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Jika berhasil, Anda memiliki userCredential.user
      if (userCredential.user != null) {
        // --- PROSES SETELAH LOGIN BERHASIL ---
        // Di sini Anda bisa memanggil API backend Anda untuk mendaftarkan/login
        // pengguna ini di database Anda dan mendapatkan access token dari server Anda.
        // Untuk contoh ini, kita akan langsung menyimpan data dari Google
        // dan menganggapnya sebagai login yang berhasil.

        final user = userCredential.user!;
        final token = await user.getIdToken(); // Token Firebase

        // Simpan data ke GetStorage dan UserController
        _storage.write('bearerToken', token);
        _storage.write('userId', user.uid);
        _storage.write('userName', user.displayName ?? 'No Name');
        _storage.write('userEmail', user.email ?? 'No Email');

        Get.find<UserController>().assignLoginData(
          token ?? '',
          user.uid,
          user.displayName ?? 'No Name',
          user.email ?? 'No Email',
        );

        isLoading.value = false;
        Get.offAllNamed('/chat'); // Navigasi ke halaman chat
      }
    } catch (e) {
      isLoading.value = false;
      RLoaders.showStatusDialog(
        context: Get.context!,
        status: DialogStatus.failed,
        title: 'Google Sign-In Failed',
        message: e.toString(),
      );
    }
  }

  Future<void> register() async {
    try {
      isLoading.value = true;
      //validate inputs
      if (nameController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty) {
        isLoading.value = false;
        RLoaders.showStatusDialog(
          context: Get.context!,
          status: DialogStatus.failed,
          title: 'Registration Failed',
          message: 'Please fill all fields',
        );
        return;
      }
      LoadingPopup.show(Get.context!);
      final response = await authService.register(
        nameController.text,
        emailController.text,
        passwordController.text,
        selectedLanguage.value,
        selectedRole.value,
      );
      isLoading.value = false;
      LoadingPopup.hide(Get.context!);

      if (response.isOk) {
        // Handle successful registration
        final loginResponse = LoginResponse.fromJson(response.body);
        UserController().bearerToken = loginResponse.accessToken!;
        Get.back();
        RLoaders.showStatusDialog(
          context: Get.context!,
          status: DialogStatus.success,
          title: 'Registration Successful',
          message: 'Check your email for verification.',
        );
      } else {
        // Handle registration error
        RLoaders.showStatusDialog(
          context: Get.context!,
          status: DialogStatus.failed,
          title: 'Registration Failed',
          message: response.body['message'] ?? 'Unknown error',
        );
      }
    } catch (e) {
      RLoaders.showStatusDialog(
        context: Get.context!,
        status: DialogStatus.failed,
        title: 'Registration Failed',
        message: e.toString(),
      );
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    // final response = await authService.logout();
    isLoading.value = false;

    // if (response.isOk) {

    _storage.remove('accessToken');
    _storage.remove('userData');

    // Kosongkan data di UserController
    Get.find<UserController>().clearUserData();

    // Arahkan ke halaman login
    Get.offAllNamed('/auth');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }
}
