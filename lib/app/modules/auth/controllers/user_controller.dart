import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class UserController extends GetxController {
  // Define your variables and methods here

  String bearerToken = '';
  String userId = '';
  String userName = '';
  String userEmail = '';
  String userProfilePicture = '';
  final RxBool isAuthenticated = false.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  void assignLoginData(
    String token,
    String id,
    String name,
    String email,
  ) {
    bearerToken = token;
    userId = id;
    userName = name;
    userEmail = email;

    isAuthenticated.value = true;
  }

  String getName() {
    return userName;
  }

  String getEmail() {
    return userEmail;
  }

  String getProfilePicture() {
    return userProfilePicture;
  }

  String getUserId() {
    return userId;
  }

  String getBearerToken() {
    return bearerToken;
  }

  void clearUserData() {
    bearerToken = '';
    userId = '';
    userName = '';
    userEmail = '';
    userProfilePicture = '';
    isAuthenticated.value = false;
  }
}
