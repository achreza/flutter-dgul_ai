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
  String? department;
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
    department = json['department'] ?? '';
    position = json['position'] ?? '';
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['department_id'] = this.departmentId;
    data['department'] = this.department;
    data['position'] = this.position;
    data['profile_photo'] = this.profilePhoto;
    return data;
  }
}
