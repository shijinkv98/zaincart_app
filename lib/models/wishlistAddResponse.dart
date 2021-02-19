 
class WishlistAddResponse {
  int success;
  String error;
  Data data;

  WishlistAddResponse({this.success, this.error, this.data});

  WishlistAddResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String message;
  // int itemsCount;
  // String cartCount;
  // int wishCount;

  Data({this.message});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    // itemsCount = json['items_count'];
    // cartCount = json['cart_count'];
    // wishCount = json['wish_count'];
  }
}