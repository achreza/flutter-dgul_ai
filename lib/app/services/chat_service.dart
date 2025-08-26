import 'package:dgul_ai/app/data/dto/responses/single_message_response.dart';
import 'package:dgul_ai/app/modules/auth/controllers/user_controller.dart';
import 'package:dgul_ai/constants.dart';
import 'package:get/get.dart';

class ChatService extends GetConnect {
  // Your chat service methods and properties go here

  Future<SingleMessageResponse> sendSingleMessage(String message) async {
    // Implement your message sending logic here
    try {
      final response = await post('${apiBaseUrl}/simple', headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${Get.find<UserController>().getBearerToken()}',
      }, {
        'message': message
      });

      if (response.status.hasError) {
        throw Exception('Failed to send message');
      }

      return SingleMessageResponse.fromJson(response.body);
    } catch (e) {
      print('Error sending message: $e');
      rethrow; // Rethrow the exception to be handled by the caller
    }
  }
}
