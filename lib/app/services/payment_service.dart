import 'package:dgul_ai/app/data/dto/responses/all_package_response.dart';
import 'package:dgul_ai/app/data/dto/responses/create_transaction_response.dart';
import 'package:dgul_ai/app/data/dto/responses/get_package_by_id_response.dart';
import 'package:dgul_ai/app/data/dto/responses/transaction_status_response.dart';
import 'package:dgul_ai/app/modules/auth/controllers/user_controller.dart';
import 'package:dgul_ai/constants.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class PaymentService extends GetConnect {
  Future<AllPackageResponse> fetchAllPackages() async {
    try {
      final response = await get('$apiBaseUrl/pakets', headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Get.find<UserController>().bearerToken}',
      });

      print("Response Paket: ${response.bodyString}");

      if (response.statusCode == 200) {
        return AllPackageResponse.fromJson(response.body);
      } else {
        throw Exception('Failed to load packages');
      }
    } catch (e) {
      throw Exception('Error fetching packages: $e');
    }
  }

  Future<GetPackageByIdResponse> fetchPackageById(int id) async {
    try {
      final response = await get('$apiBaseUrl/pakets/$id', headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return GetPackageByIdResponse.fromJson(response.body);
      } else {
        throw Exception('Failed to load package with id $id');
      }
    } catch (e) {
      throw Exception('Error fetching package by id: $e');
    }
  }

  Future<CreateTransactionResponse> createTransaction(
      int paketId, String? voucherCode) async {
    try {
      final response = await post(
        '$apiBaseUrl/payment/create',
        {
          'id_paket': paketId,
          if (voucherCode != null) 'voucher_code': voucherCode,
        },
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Get.find<UserController>().bearerToken}',
        },
      );

      Logger().d("Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return CreateTransactionResponse.fromJson(response.body);
      } else {
        throw Exception('Failed to create transaction');
      }
    } catch (e) {
      throw Exception('Error creating transaction: $e');
    }
  }

  Future<TransactionStatusResponse> checkTransactionStatus(
      String orderId) async {
    try {
      final response = await get(
        '$apiBaseUrl/payment/status?order_id=$orderId',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Get.find<UserController>().bearerToken}',
        },
      );

      Logger().d("Response: ${response.body}");

      if (response.statusCode == 200) {
        return TransactionStatusResponse.fromJson(response.body);
      } else {
        throw Exception('Failed to fetch transaction status');
      }
    } catch (e) {
      throw Exception('Error checking transaction status: $e');
    }
  }
}
