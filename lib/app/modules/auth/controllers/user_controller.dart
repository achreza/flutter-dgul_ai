import 'package:dgul_ai/app/data/dto/requests/update_profile_request.dart';
import 'package:dgul_ai/app/data/dto/responses/profile_response.dart';
import 'package:dgul_ai/app/data/dto/responses/update_profile_response.dart';
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
  ProfileResponse profileData = ProfileResponse();
  MultipartFile? profilePhoto;

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

  void assignProfileData(ProfileResponse profile) {
    profileData = profile;
  }

  void assignProfileDataAfterUpdate(UpdateProfileResponse profile) {
    profileData.user?.email = profile.user?.email;
    profileData.user?.phone = profile.user?.phone;
    profileData.user?.department = profile.user!.department;
    profileData.user?.position = profile.user?.position;
    userProfilePicture = profile.user?.profilePhoto.toString() ?? '';
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

  void updateProfile(ProfileResponse profile) {
    profileData = profile;
    UpdateProfileRequest req = UpdateProfileRequest(
      email: profile.user!.email,
      phone: profile.user!.phone,
      department: profile.user!.department,
      position: profile.user!.position,
      profilePhoto: profilePhoto,
    );
  }
}
