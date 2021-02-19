class LoginResponse {
  int success;
  String error;
  Data data;

  LoginResponse({this.success, this.error, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String customerId;
  String customerName;
  String customerEmail;
  String token;
  String phone;
  String message;

  Data(
      {this.customerId,
      this.customerName,
      this.customerEmail,
      this.token,
      this.phone,
      this.message});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    token = json['token'];
    phone = json['phone'];
    message = json['message'];
  }
}
