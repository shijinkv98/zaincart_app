import 'package:zaincart_app/models/products_response.dart';

class ProductsByCategoryResponse {
  int success;
  String error;
  CategoryData data;
  MetaInfo metaInfo;

  ProductsByCategoryResponse(
      {this.success, this.error, this.data, this.metaInfo});

  ProductsByCategoryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    data = json['data'] != null ? new CategoryData.fromJson(json['data']) : null;
    metaInfo = json['meta_info'] != null
        ? new MetaInfo.fromJson(json['meta_info'])
        : null;
  }
}

class CategoryData {
  int cartCount;
  int wishCount;
  List<Product> categoryProduct;

  CategoryData({this.cartCount, this.wishCount, this.categoryProduct});

  CategoryData.fromJson(Map<String, dynamic> json) {
    cartCount = json['cart_count'];
    wishCount = json['wish_count'];
    if (json['category_product'] != null) {
      categoryProduct = new List<Product>();
      json['category_product'].forEach((v) {
        categoryProduct.add(new Product.fromJson(v));
      });
    }
  }
}

class MetaInfo {
  int totalPage;
  int totalCount;

  MetaInfo({this.totalPage, this.totalCount});

  MetaInfo.fromJson(Map<String, dynamic> json) {
    totalPage = json['total_page'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_page'] = this.totalPage;
    data['total_count'] = this.totalCount;
    return data;
  }
}