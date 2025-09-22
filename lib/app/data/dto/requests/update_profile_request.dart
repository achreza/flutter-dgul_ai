import 'package:get/get.dart';

class UpdateProfileRequest {
  String? name;
  String? email;
  String? phone;
  String? department;
  String? position;
  MultipartFile? profilePhoto; // Menggunakan tipe File untuk upload gambar

  UpdateProfileRequest({
    this.name,
    this.email,
    this.phone,
    this.department,
    this.position,
    this.profilePhoto,
  });

  // Mengubah data menjadi format Map, siap untuk dikirim sebagai body request
  Map<String, String> toMap() {
    final Map<String, String> data = <String, String>{};
    if (name != null) data['name'] = name!;
    if (email != null) data['email'] = email!;
    if (phone != null) data['phone'] = phone!;
    if (department != null) data['department'] = department!;
    if (position != null) data['position'] = position!;
    // File gambar akan ditangani secara terpisah sebagai multipart,
    // jadi tidak dimasukkan ke dalam map ini.
    return data;
  }
}
