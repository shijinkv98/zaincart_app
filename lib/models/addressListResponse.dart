import 'package:zaincart_app/models/address.dart';

class AddressListResponse {
  int success;
  String error;
  AddressData data;

  AddressListResponse({this.success, this.error, this.data});

  AddressListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    data = json['data'] != null ? new AddressData.fromJson(json['data']) : null;
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

class AddressData {
  List<Address> addressList;
  int cartCount;
  int wishCount;

  AddressData({this.addressList, this.cartCount, this.wishCount});

  AddressData.fromJson(Map<String, dynamic> json) {
    if (json['addres'] != null) {
      addressList = new List<Address>();
      json['addres'].forEach((v) {
        addressList.add(new Address.fromJson(v));
      });
    }
    cartCount = json['cart_count'];
    wishCount = json['wish_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addressList != null) {
      data['addres'] = this.addressList.map((v) => v.toJson()).toList();
    }
    data['cart_count'] = this.cartCount;
    data['wish_count'] = this.wishCount;
    return data;
  }
}

