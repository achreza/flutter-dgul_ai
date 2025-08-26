class UpdateProfileResponse {
  String? message;
  User? user;

  UpdateProfileResponse({this.message, this.user});

  UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
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
  String? profilePhoto;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.departmentId,
      this.department,
      this.position,
      this.profilePhoto});

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
    profilePhoto = json['profile_photo'];
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
    data['profile_photo'] = this.profilePhoto;
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
