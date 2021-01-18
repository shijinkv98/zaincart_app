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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
   
    return data;
  }
}

class Data {
  String customerId;
  String customerName;
  String customerEmail;
  String token;
  String message;

  Data(
      {this.customerId,
      this.customerName,
      this.customerEmail,
      this.token,
      this.message});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    data['customer_email'] = this.customerEmail;
    data['token'] = this.token;
    data['message'] = this.message;
    return data;
  }
}