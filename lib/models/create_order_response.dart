class CreateOrderResponse {
  int success;
  String error;
  OrderData orderData;

  CreateOrderResponse({this.success, this.error, this.orderData});

  CreateOrderResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    orderData = json['data'] != null ? new OrderData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.orderData != null) {
      data['data'] = this.orderData.toJson();
    }
    return data;
  }
}

class OrderData {
  String orderId;
  String accessCode;
  String merchantId;
  String currency;
  String totalAmount;

  OrderData(
      {this.orderId,
      this.accessCode,
      this.merchantId,
      this.currency,
      this.totalAmount});

  OrderData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    accessCode = json['access_code'];
    merchantId = json['merchant_id'];
    currency = json['currency'];
    totalAmount = json['Total amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['access_code'] = this.accessCode;
    data['merchant_id'] = this.merchantId;
    data['currency'] = this.currency;
    data['Total amount'] = this.totalAmount;
    return data;
  }
}