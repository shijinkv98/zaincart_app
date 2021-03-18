class CheckoutDetailsResponse {
  int success;
  String error;
  CheckoutData checkoutData;

  CheckoutDetailsResponse({this.success, this.error, this.checkoutData});

  CheckoutDetailsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    checkoutData = json['data'] != null ? new CheckoutData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.checkoutData != null) {
      data['data'] = this.checkoutData.toJson();
    }
    return data;
  }
}

class CheckoutData {
  List<PaymentMethod> paymentMethod;
  List<ShippingMethod> shippingMethod;

  CheckoutData({this.paymentMethod, this.shippingMethod});

  CheckoutData.fromJson(Map<String, dynamic> json) {
    if (json['payment_method'] != null) {
      paymentMethod = new List<PaymentMethod>();
      json['payment_method'].forEach((v) {
        paymentMethod.add(new PaymentMethod.fromJson(v));
      });
    }
    if (json['shipping_method'] != null) {
      shippingMethod = new List<ShippingMethod>();
      json['shipping_method'].forEach((v) {
        shippingMethod.add(new ShippingMethod.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentMethod != null) {
      data['payment_method'] =
          this.paymentMethod.map((v) => v.toJson()).toList();
    }
    if (this.shippingMethod != null) {
      data['shipping_method'] =
          this.shippingMethod.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentMethod {
  String label;
  String value;

  PaymentMethod({this.label, this.value});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}

class ShippingMethod {
  String label;
  String value;
  String price;

  ShippingMethod({this.label, this.value, this.price});

  ShippingMethod.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    data['price'] = this.price;
    return data;
  }
}