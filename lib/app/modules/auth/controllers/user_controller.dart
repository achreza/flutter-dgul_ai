import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class UserController extends GetxController {
  // Define your variables and methods here

  String bearerToken = '';
  final String userId = '';
  final String userName = '';
  final String userEmail = '';
  final String userProfilePicture = '';
  final RxBool isAuthenticated = false.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
}
