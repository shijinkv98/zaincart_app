class MyOrderDetailResponse {
  int success;
  String error;
  MyOrderDetail orderDetail;

  MyOrderDetailResponse({this.success, this.error, this.orderDetail});

  MyOrderDetailResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    orderDetail = json['data'] != null ? new MyOrderDetail.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.orderDetail != null) {
      data['data'] = this.orderDetail.toJson();
    }
    return data;
  }
}

class MyOrderDetail {
  int cartCount;
  int wishCount;
  String incrementId;
  int quantity;
  String discountAmount;
  String status;
  String totalAmount;
  String subTotal;
  String lastUpdatedDate;
  String orderDate;
  String paymentMethod;
  String shippingMethod;
  ShippingAddress shippingAddress;
  BillingAddress billingAddress;
  String shippingPrice;
  List<OrderProduct> products;

  MyOrderDetail(
      {this.cartCount,
      this.wishCount,
      this.incrementId,
      this.quantity,
      this.discountAmount,
      this.status,
      this.totalAmount,
      this.subTotal,
      this.lastUpdatedDate,
      this.orderDate,
      this.paymentMethod,
      this.shippingMethod,
      this.shippingAddress,
      this.billingAddress,
      this.shippingPrice,
      this.products});

  MyOrderDetail.fromJson(Map<String, dynamic> json) {
    cartCount = json['cart_count'];
    wishCount = json['wish_count'];
    incrementId = json['increment_id'];
    quantity = json['quantity'];
    discountAmount = json['discount_amount'];
    status = json['status'];
    totalAmount = json['Total_amount'];
    subTotal = json['Sub_total'];
    lastUpdatedDate = json['Last_updated_date'];
    orderDate = json['order_date'];
    paymentMethod = json['payment_method'];
    shippingMethod = json['shipping_method'];
    shippingAddress = json['shipping_address'] != null
        ? new ShippingAddress.fromJson(json['shipping_address'])
        : null;
    billingAddress = json['billing_address'] != null
        ? new BillingAddress.fromJson(json['billing_address'])
        : null;
    shippingPrice = json['shipping_price'];
    if (json['products'] != null) {
      products = new List<OrderProduct>();
      json['products'].forEach((v) {
        products.add(new OrderProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_count'] = this.cartCount;
    data['wish_count'] = this.wishCount;
    data['increment_id'] = this.incrementId;
    data['quantity'] = this.quantity;
    data['discount_amount'] = this.discountAmount;
    data['status'] = this.status;
    data['Total_amount'] = this.totalAmount;
    data['Sub_total'] = this.subTotal;
    data['Last_updated_date'] = this.lastUpdatedDate;
    data['order_date'] = this.orderDate;
    data['payment_method'] = this.paymentMethod;
    data['shipping_method'] = this.shippingMethod;
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress.toJson();
    }
    if (this.billingAddress != null) {
      data['billing_address'] = this.billingAddress.toJson();
    }
    data['shipping_price'] = this.shippingPrice;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShippingAddress {
  String name;
  String postcode;
  List<String> street;
  String city;
  String country;
  String telephone;

  ShippingAddress(
      {this.name,
      this.postcode,
      this.street,
      this.city,
      this.country,
      this.telephone});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    postcode = json['postcode'];
    street = json['street'].cast<String>();
    city = json['city'];
    country = json['country'];
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['postcode'] = this.postcode;
    data['street'] = this.street;
    data['city'] = this.city;
    data['country'] = this.country;
    data['telephone'] = this.telephone;
    return data;
  }
}

class BillingAddress {
  String name;
  String postcode;
  String company;
  List<String> street;
  String city;
  String country;
  String telephone;

  BillingAddress(
      {this.name,
      this.postcode,
      this.company,
      this.street,
      this.city,
      this.country,
      this.telephone});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    postcode = json['postcode'];
    company = json['company'];
    street = json['street'].cast<String>();
    city = json['city'];
    country = json['country'];
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['postcode'] = this.postcode;
    data['company'] = this.company;
    data['street'] = this.street;
    data['city'] = this.city;
    data['country'] = this.country;
    data['telephone'] = this.telephone;
    return data;
  }
}

class OrderProduct {
  String sku;
  String productId;
  String itemId;
  String name;
  double price;
  int qty;
  String image;

  OrderProduct(
      {this.sku,
      this.productId,
      this.itemId,
      this.name,
      this.price,
      this.qty,
      this.image});

  OrderProduct.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    productId = json['product_id'];
    itemId = json['item_id'];
    name = json['name'];
    price = json['price'].toDouble();
    qty = json['qty'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku'] = this.sku;
    data['product_id'] = this.productId;
    data['item_id'] = this.itemId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['qty'] = this.qty;
    data['image'] = this.image;
    return data;
  }
}