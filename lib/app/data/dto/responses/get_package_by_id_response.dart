class GetPackageByIdResponse {
  Paket? paket;

  GetPackageByIdResponse({this.paket});

  GetPackageByIdResponse.fromJson(Map<String, dynamic> json) {
    paket = json['paket'] != null ? new Paket.fromJson(json['paket']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paket != null) {
      data['paket'] = this.paket!.toJson();
    }
    return data;
  }
}

class Paket {
  int? id;
  String? name;
  String? price;
  String? duration;
  String? description;
  String? createdAt;
  String? updatedAt;

  Paket(
      {this.id,
      this.name,
      this.price,
      this.duration,
      this.description,
      this.createdAt,
      this.updatedAt});

  Paket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    duration = json['duration'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['duration'] = this.duration;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
