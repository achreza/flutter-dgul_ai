import 'package:dgul_ai/app/data/dto/responses/profile_response.dart';
import 'package:dgul_ai/app/modules/auth/controllers/user_controller.dart';
import 'package:dgul_ai/constants.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AuthService extends GetConnect {
  // Method to login a user
  Future<Response> login(String email, String password) async {
    try {
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
    } catch (e) {
      Logger().e('Error logging in: $e');
      return Response(
        statusCode: 500,
        statusText: 'Error logging in',
      );
    }
  }

  Future<ProfileResponse> getProfileData() async {
    try {
      final response = await get('$apiBaseUrl/profile', headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${Get.find<UserController>().getBearerToken()}',
      });

      if (response.isOk) {
        return ProfileResponse.fromJson(response.body);
      } else {
        Logger().e('Error fetching profile data: ${response.statusText}');
        return ProfileResponse();
      }
    } catch (e) {
      Logger().e('Error fetching profile data: $e');
      return ProfileResponse();
    }
  }

  // Method to register a new user
  Future<Response> register(String name, String email, String password,
      String language, String role) async {
    try {
      String langCode = language == 'Indonesia' ? 'id' : 'en';
      final response = await post('$apiBaseUrl/register', {
        'name': name,
        'email': email,
        'password': password,
        'language': langCode,
        'role': role,
      }, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });
      Logger().i('Response from register: ${response.body}');
      return response;
    } catch (e) {
      Logger().e('Error registering user: $e');
      return Response(
        statusCode: 500,
        statusText: 'Error registering user',
      );
    }
  }

  // Method to logout a user
  Future<Response> logout() async {
    try {
      final response = await post('$apiBaseUrl/logout', {}, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${Get.find<UserController>().getBearerToken()}',
      });
      return response;
    } catch (e) {
      Logger().e('Error logging out: $e');
      return Response(
        statusCode: 500,
        statusText: 'Error logging out',
      );
    }
  }
}
