class ProfileResponse {
  User? user;

  ProfileResponse({this.user});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? departmentId;
  Department? department;
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
      this.departmentId,
      this.department,
      this.position,
      this.language,
      this.role,
      this.profilePhotoUrl,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    departmentId = json['department_id'];
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
    position = json['position'];
    language = json['language'];
    role = json['role'];
    profilePhotoUrl = json['profile_photo_url'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['department_id'] = this.departmentId;
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    data['position'] = this.position;
    data['language'] = this.language;
    data['role'] = this.role;
    data['profile_photo_url'] = this.profilePhotoUrl;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Department {
  int? id;
  String? name;
  String? description;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  Department(
      {this.id,
      this.name,
      this.description,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
