import 'package:dgul_ai/app/data/dto/responses/profile_response.dart';
import 'package:dgul_ai/app/data/dto/responses/update_profile_response.dart';
import 'package:dgul_ai/app/modules/auth/controllers/user_controller.dart';
import 'package:dgul_ai/app/services/auth_service.dart';
import 'package:dgul_ai/constants.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../data/dto/requests/update_profile_request.dart';
import 'package:path/path.dart';

class UserService extends GetConnect {
  Future<UpdateProfileResponse> updateProfile(
      UpdateProfileRequest request) async {
    Logger().i(
        'Updating profile with data: ${request.toMap()}, Profile Photo: ${request.profilePhoto?.filename}');
    try {
      final form = FormData(request.toMap());

      if (request.profilePhoto != null) {
        form.files.add(MapEntry(
          'profile_photo',
          request.profilePhoto!,
        ));
      }

      var res = await post(
        '${apiBaseUrl}/profile',
        form,
        headers: {
          'Accept': 'application/json',
          'Authorization':
              'Bearer ${Get.find<UserController>().getBearerToken()}',
        },
      );
      Logger().i('Profile update response: ${res.body}');

      return UpdateProfileResponse.fromJson(res.body);
    } catch (e) {
      Logger().e('Error updating profile: $e');
      return UpdateProfileResponse();
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
}
