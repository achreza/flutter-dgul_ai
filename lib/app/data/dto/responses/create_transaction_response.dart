class CreateTransactionResponse {
  bool? success;
  Data? data;

  CreateTransactionResponse({this.success, this.data});

  CreateTransactionResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? orderId;
  String? paymentUrl;

  Data({this.orderId, this.paymentUrl});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    paymentUrl = json['payment_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['payment_url'] = this.paymentUrl;
    return data;
  }
}
