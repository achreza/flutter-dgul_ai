import 'package:dgul_ai/app/data/dto/responses/all_package_response.dart';
import 'package:dgul_ai/app/data/dto/responses/get_package_by_id_response.dart';
import 'package:dgul_ai/constants.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class PaymentService extends GetConnect {
  Future<AllPackageResponse> fetchAllPackages() async {
    try {
      final response = await get('$apiBaseUrl/pakets', headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });

      Logger().d("Response: ${response.body}");

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
}
