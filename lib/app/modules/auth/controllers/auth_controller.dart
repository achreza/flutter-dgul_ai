import 'package:dgul_ai/app/data/dto/responses/login_response.dart';
import 'package:dgul_ai/app/modules/auth/controllers/user_controller.dart';
import 'package:dgul_ai/app/services/auth_service.dart';
import 'package:dgul_ai/app/utitls/rloaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final RxBool isLoading = false.obs;
  final GetStorage _storage = GetStorage();

  final AuthService authService = AuthService();
  @override
  void onInit() {
    super.onInit();
    autoLogin();
  }

  void autoLogin() async {
    final token = _storage.read('accessToken');

    // Jika token ditemukan di storage
    if (token != null) {
      final userData = _storage.read<Map<String, dynamic>>('userData');
      if (userData != null) {
        final user = User.fromJson(userData);

        // Gunakan Get.find() untuk mengakses instance UserController yang sudah ada
        final userController = Get.find<UserController>();
        userController.assignLoginData(
          token,
          user.id!.toString(),
          user.name!,
          user.email!,
        );

        Future.delayed(Duration.zero, () {
          Get.offAllNamed('/chat');
        });
      }
    }
  }

  Future<void> login() async {
    isLoading.value = true;
    final response = await authService.login(
      emailController.text,
      passwordController.text,
    );
    isLoading.value = false;

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

      Get.offAllNamed('/chat');
      RLoaders.showStatusDialog(
        context: Get.context!,
        status: DialogStatus.success,
        title: 'Login Successful',
        message: 'Welcome back!',
      );
    } else {
      // Handle login error
      RLoaders.showStatusDialog(
        context: Get.context!,
        status: DialogStatus.failed,
        title: 'Login Failed',
        message: response.statusText ?? 'Unknown error',
      );
    }
  }

  Future<void> register() async {
    isLoading.value = true;
    final response = await authService.register(
      nameController.text,
      emailController.text,
      passwordController.text,
    );
    isLoading.value = false;

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
        message: response.statusText ?? 'Unknown error',
      );
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    final response = await authService.logout();
    isLoading.value = false;

    if (response.isOk) {
      // --- HAPUS DATA DARI STORAGE ---
      _storage.remove('accessToken');
      _storage.remove('userData');

      // Kosongkan data di UserController
      Get.find<UserController>().clearUserData();

      // Arahkan ke halaman login
      Get.offAllNamed('/auth');
    } else {
      Get.snackbar('Logout Failed', response.statusText ?? 'Unknown error');
    }
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
