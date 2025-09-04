class AllPackageResponse {
  List<Pakets>? pakets;

  AllPackageResponse({this.pakets});

  AllPackageResponse.fromJson(Map<String, dynamic> json) {
    if (json['pakets'] != null) {
      pakets = <Pakets>[];
      json['pakets'].forEach((v) {
        pakets!.add(new Pakets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pakets != null) {
      data['pakets'] = this.pakets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pakets {
  int? id;
  String? name;
  String? price;
  String? duration;
  String? description;

  Pakets({this.id, this.name, this.price, this.duration, this.description});

  Pakets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    duration = json['duration'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['duration'] = this.duration;
    data['description'] = this.description;
    return data;
  }
}
