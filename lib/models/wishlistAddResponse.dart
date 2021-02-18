 
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
  String message;
  int itemsCount;
  String cartCount;
  int wishCount;

  Data({this.message, this.itemsCount, this.cartCount, this.wishCount});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    itemsCount = json['items_count'];
    cartCount = json['cart_count'];
    wishCount = json['wish_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['items_count'] = this.itemsCount;
    data['cart_count'] = this.cartCount;
    data['wish_count'] = this.wishCount;
    return data;
  }
}