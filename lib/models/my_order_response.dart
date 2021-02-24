class MyOrderResponse {
  int success;
  String error;
  Data data;

  MyOrderResponse({this.success, this.error, this.data});

  MyOrderResponse.fromJson(Map<String, dynamic> json) {
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
  int cartCount;
  int wishCount;
  List<OrderDetail> orderlist;

  Data({this.cartCount, this.wishCount, this.orderlist});

  Data.fromJson(Map<String, dynamic> json) {
    cartCount = json['cart_count'];
    wishCount = json['wish_count'];
    if (json['orderlist'] != null) {
      orderlist = new List<OrderDetail>();
      json['orderlist'].forEach((v) {
        orderlist.add(new OrderDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_count'] = this.cartCount;
    data['wish_count'] = this.wishCount;
    if (this.orderlist != null) {
      data['orderlist'] = this.orderlist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetail {
  String orderId;
  int quantity;
  String status;
  String totalAmount;
  String lastUpdatedDate;
  String orderDate;

  OrderDetail(
      {this.orderId,
      this.quantity,
      this.status,
      this.totalAmount,
      this.lastUpdatedDate,
      this.orderDate});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    quantity = json['quantity'];
    status = json['status'];
    totalAmount = json['Total_amount'];
    lastUpdatedDate = json['Last_updated_date'];
    orderDate = json['order_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['quantity'] = this.quantity;
    data['status'] = this.status;
    data['Total_amount'] = this.totalAmount;
    data['Last_updated_date'] = this.lastUpdatedDate;
    data['order_date'] = this.orderDate;
    return data;
  }
}