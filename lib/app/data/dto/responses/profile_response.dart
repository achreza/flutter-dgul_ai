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
  int? token;
  String? name;
  String? email;
  String? phone;
  String? department;
  String? position;
  String? language;
  String? role;
  int? isSubscription;
  String? subscriptionUntil;
  String? profilePhotoUrl;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.token,
      this.name,
      this.email,
      this.phone,
      this.department,
      this.position,
      this.language,
      this.role,
      this.isSubscription,
      this.subscriptionUntil,
      this.profilePhotoUrl,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    department = json['department'];
    position = json['position'];
    language = json['language'];
    role = json['role'];
    isSubscription = json['is_subscription'];
    subscriptionUntil = json['subscription_until'];
    profilePhotoUrl = json['profile_photo_url'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['department'] = this.department;
    data['position'] = this.position;
    data['language'] = this.language;
    data['role'] = this.role;
    data['is_subscription'] = this.isSubscription;
    data['subscription_until'] = this.subscriptionUntil;
    data['profile_photo_url'] = this.profilePhotoUrl;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
