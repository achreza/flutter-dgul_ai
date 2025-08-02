import 'package:dgul_ai/app/data/dto/responses/login_response.dart';
import 'package:dgul_ai/app/modules/auth/controllers/user_controller.dart';
import 'package:dgul_ai/app/services/auth_service.dart';
import 'package:dgul_ai/app/utitls/rloaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final RxBool isLoading = false.obs;

  final AuthService authService = AuthService();
  @override
  void onInit() {
    super.onInit();
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
      UserController().bearerToken = loginResponse.accessToken!;

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
      // Handle successful logout
      Get.snackbar('Logout Successful', 'You have been logged out.');
    } else {
      // Handle logout error
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
  }
}
