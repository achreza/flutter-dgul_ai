import 'package:dgul_ai/app/modules/auth/controllers/user_controller.dart';
import 'package:dgul_ai/constants.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AuthService extends GetConnect {
  // Method to login a user
  Future<Response> login(String email, String password) async {
    Logger().i('Logging in with email: $email'
        ' and password: $password');

    final response = await post(
      '$apiBaseUrl/login',
      {
        'email': email,
        'password': password,
      },
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    return response;
  }

  // Method to register a new user
  Future<Response> register(String name, String email, String password) async {
    final response = await post('$apiBaseUrl/register', {
      'name': name,
      'email': email,
      'password': password,
    }, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });
    return response;
  }

  // Method to logout a user
  Future<Response> logout() async {
    final response = await get('$apiBaseUrl/logout');
    return response;
  }
}
