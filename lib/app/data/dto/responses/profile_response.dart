class ProfileResponse {
  User? user;

  ProfileResponse({this.user});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? department;
  String? position;
  String? language;
  String? role;
  String? profilePhotoUrl;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.department,
      this.position,
      this.language,
      this.role,
      this.profilePhotoUrl,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    // Memberikan nilai default jika data dari JSON null
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    department = json['department'] ?? '';
    position = json['position'] ?? '';
    language = json['language'] ?? '';
    role = json['role'] ?? '';
    profilePhotoUrl = json['profile_photo_url'] ?? '';
    emailVerifiedAt = json['email_verified_at'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['department'] = department;
    data['position'] = position;
    data['language'] = language;
    data['role'] = role;
    data['profile_photo_url'] = profilePhotoUrl;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
