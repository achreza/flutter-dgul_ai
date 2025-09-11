import 'package:dgul_ai/app/data/dto/responses/single_message_response.dart';
import 'package:dgul_ai/app/modules/auth/controllers/user_controller.dart';
import 'package:dgul_ai/constants.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ChatService extends GetConnect {
  // Your chat service methods and properties go here

  @override
  void onInit() {
    httpClient.timeout = Duration(seconds: 30);
    super.onInit();
  }

  Future<SingleMessageResponse> sendSingleMessage(
      String message, String department) async {
    // Implement your message sending logic here
    try {
      final response = await post('${apiBaseUrl}/simple', headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${Get.find<UserController>().getBearerToken()}',
      }, {
        'message': message,
        'department': department,
      });

      Logger().i('Response from sendSingleMessage: ${response.body}');
      Logger().i('Status code: ${response.statusCode}');

      if (response.status.hasError) {
        throw '${response.body['message']}';
      }

      return SingleMessageResponse.fromJson(response.body);
    } catch (e) {
      Logger().e('Error sending message: $e');
      rethrow; // Rethrow the exception to be handled by the caller
    }
  }

  Future<SingleMessageResponse> sendSingleMessageWithImage(
      String message, MultipartFile filePath, String department) async {
    // Implement your message sending logic here
    try {
      final response = await post(
          '${apiBaseUrl}/simple',
          headers: {
            'Authorization':
                'Bearer ${Get.find<UserController>().getBearerToken()}',
          },
          FormData({
            'message': message,
            'image': filePath,
            'department': department,
          }));

      Logger().i('Response from sendSingleMessage: ${response.body}');
      Logger().i('Status code: ${response.statusCode}');

      if (response.status.hasError) {
        throw Exception('${response.body['message']}');
      }

      return SingleMessageResponse.fromJson(response.body);
    } catch (e) {
      rethrow; // Rethrow the exception to be handled by the caller
    }
  }
}
