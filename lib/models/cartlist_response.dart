class MyCartResponse {
  int success;
  String error;
  CartData data;
  CartInfo cartInfo;

  MyCartResponse({this.success, this.error, this.data, this.cartInfo});

  MyCartResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    data = json['data'] != null ? new CartData.fromJson(json['data']) : null;
    cartInfo = json['meta_info'] != null
        ? new CartInfo.fromJson(json['meta_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.cartInfo != null) {
      data['meta_info'] = this.cartInfo.toJson();
    }
    return data;
  }
}

class CartData {
  List<CartProduct> product;
  int cartCount;
  int wishCount;

  CartData({this.product, this.cartCount, this.wishCount});

  CartData.fromJson(Map<String, dynamic> json) {
    if (json['product'] != null) {
      product = new List<CartProduct>();
      json['product'].forEach((v) {
        product.add(new CartProduct.fromJson(v));
      });
    }
    cartCount = json['cart_count'];
    wishCount = json['wish_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product.map((v) => v.toJson()).toList();
    }
    data['cart_count'] = this.cartCount;
    data['wish_count'] = this.wishCount;
    return data;
  }
}

class CartProduct {
  String productId;
  String productType;
  String sku;
  String cartItemId;
  String produtName;
  int quantity;
  String productPrice;
  Null preOrderStatus;
  String image;

  CartProduct(
      {this.productId,
      this.productType,
      this.sku,
      this.cartItemId,
      this.produtName,
      this.quantity,
      this.productPrice,
      this.preOrderStatus,
      this.image});

  CartProduct.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productType = json['product_type'];
    sku = json['sku'];
    cartItemId = json['cart_item_id'];
    produtName = json['produt_name'];
    quantity = json['quantity'];
    productPrice = json['product_price'];
    preOrderStatus = json['pre_order_status'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_type'] = this.productType;
    data['sku'] = this.sku;
    data['cart_item_id'] = this.cartItemId;
    data['produt_name'] = this.produtName;
    data['quantity'] = this.quantity;
    data['product_price'] = this.productPrice;
    data['pre_order_status'] = this.preOrderStatus;
    data['image'] = this.image;
    return data;
  }
}

class CartInfo {
  CartAddress address;
  String cartTotalAmount;
  String actualAmount;
  String discount;
  String cartId;
  String cartQty;

  CartInfo(
      {this.address,
      this.cartTotalAmount,
      this.actualAmount,
      this.discount,
      this.cartId,
      this.cartQty});

  CartInfo.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? new CartAddress.fromJson(json['address']) : null;
    cartTotalAmount = json['cart_total_amount'];
    actualAmount = json['actual_amount'];
    discount = json['discount'];
    cartId = json['cart_id'];
    cartQty = json['cart_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['cart_total_amount'] = this.cartTotalAmount;
    data['actual_amount'] = this.actualAmount;
    data['discount'] = this.discount;
    data['cart_id'] = this.cartId;
    data['cart_qty'] = this.cartQty;
    return data;
  }
}

class CartAddress {
  BillingAddress billingAddress;
  ShippingAddress shippingAddress;

  CartAddress({this.billingAddress, this.shippingAddress});

  CartAddress.fromJson(Map<String, dynamic> json) {
    billingAddress = json['Billing address'] != null
        ? new BillingAddress.fromJson(json['Billing address'])
        : null;
    shippingAddress = json['Shipping address'] != null
        ? new ShippingAddress.fromJson(json['Shipping address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.billingAddress != null) {
      data['Billing address'] = this.billingAddress.toJson();
    }
    if (this.shippingAddress != null) {
      data['Shipping address'] = this.shippingAddress.toJson();
    }
    return data;
  }
}

class BillingAddress {
  String addressId;
  String city;
  String state;
  int stateid;
  Null company;
  String countryId;
  String country;
  String firstname;
  String lastname;
  List<String> street;
  String postcode;
  String telephone;

  BillingAddress(
      {this.addressId,
      this.city,
      this.state,
      this.stateid,
      this.company,
      this.countryId,
      this.country,
      this.firstname,
      this.lastname,
      this.street,
      this.postcode,
      this.telephone});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    city = json['city'];
    state = json['state'];
    stateid = json['stateid'];
    company = json['company'];
    countryId = json['country_id'];
    country = json['country'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    street = json['street'].cast<String>();
    postcode = json['postcode'];
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['city'] = this.city;
    data['state'] = this.state;
    data['stateid'] = this.stateid;
    data['company'] = this.company;
    data['country_id'] = this.countryId;
    data['country'] = this.country;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['street'] = this.street;
    data['postcode'] = this.postcode;
    data['telephone'] = this.telephone;
    return data;
  }
}

class ShippingAddress {
  String addressId;
  String city;
  String state;
  int stateid;
  Null company;
  String countryId;
  String firstname;
  String lastname;
  List<String> street;
  String postcode;
  String telephone;

  ShippingAddress(
      {this.addressId,
      this.city,
      this.state,
      this.stateid,
      this.company,
      this.countryId,
      this.firstname,
      this.lastname,
      this.street,
      this.postcode,
      this.telephone});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    city = json['city'];
    state = json['state'];
    stateid = json['stateid'];
    company = json['company'];
    countryId = json['country_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    street = json['street'].cast<String>();
    postcode = json['postcode'];
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['city'] = this.city;
    data['state'] = this.state;
    data['stateid'] = this.stateid;
    data['company'] = this.company;
    data['country_id'] = this.countryId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['street'] = this.street;
    data['postcode'] = this.postcode;
    data['telephone'] = this.telephone;
    return data;
  }
}
