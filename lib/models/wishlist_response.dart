import 'package:zaincart_app/models/products_response.dart';

class WishlistResponse {
  int success;
  String error;
  WishlistData data;

  WishlistResponse({this.success, this.error, this.data});

  WishlistResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    data = json['data'] != null ? new WishlistData.fromJson(json['data']) : null;
  }
}

class WishlistData {
  int cartCount;
  int wishCount;
  List<Product> product;

  WishlistData({this.cartCount, this.wishCount, this.product});

  WishlistData.fromJson(Map<String, dynamic> json) {
    cartCount = json['cart_count'];
    wishCount = json['wish_count'];
    if (json['product'] != null) {
      product = new List<Product>();
      json['product'].forEach((v) {
        product.add(new Product.fromJson(v));
      });
    }
  }
}
