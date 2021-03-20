import 'package:zaincart_app/models/products_response.dart';

class ProductDetailResponse {
  int success;
  String error;
  ProductDetail productDetail;

  ProductDetailResponse({this.success, this.error, this.productDetail});

  ProductDetailResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    productDetail = json['data'] != null ? new ProductDetail.fromJson(json['data']) : null;
  }
}

class ProductDetail {
  int cartCount;
  int wishCount;
  List<Specifications> specifications;
  List<ProductOptions> productOptions;
  List<ChildProduct> childProduct;
  List<Product> relatedProduct;
  List<Null> reviews;
  bool productWishlisted;
  int rating;
  String productId;
  String productName;
  String productShortDescription;
  String productDescription;
  String productPrice;
  Null productSpPrice;
  Null productOffer;
  Null savings;
  String productSku;
  String productType;
  int stockQty;
  bool stockStatus;
  List<String> productImage;
  String productUrl;

  ProductDetail(
      {this.cartCount,
      this.wishCount,
      this.specifications,
      this.productOptions,
      this.childProduct,
      this.relatedProduct,
      this.reviews,
      this.productWishlisted,
      this.rating,
      this.productId,
      this.productName,
      this.productShortDescription,
      this.productDescription,
      this.productPrice,
      this.productSpPrice,
      this.productOffer,
      this.savings,
      this.productSku,
      this.productType,
      this.stockQty,
      this.stockStatus,
      this.productImage,
      this.productUrl});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    cartCount = json['cart_count'];
    wishCount = json['wish_count'];
    if (json['specifications'] != null) {
      specifications = new List<Specifications>();
      json['specifications'].forEach((v) {
        specifications.add(new Specifications.fromJson(v));
      });
    }
    if (json['product_options'] != null) {
      productOptions = new List<ProductOptions>();
      json['product_options'].forEach((v) {
        productOptions.add(new ProductOptions.fromJson(v));
      });
    }
    if (json['Child_product'] != null) {
      childProduct = new List<ChildProduct>();
      json['Child_product'].forEach((v) {
        childProduct.add(new ChildProduct.fromJson(v));
      });
    }
    if (json['related_product'] != null) {
      relatedProduct = new List<Product>();
      json['related_product'].forEach((v) {
        relatedProduct.add(new Product.fromJson(v));
      });
    }
    // if (json['reviews'] != null) {
    //   reviews = new List<Null>();
    //   json['reviews'].forEach((v) {
    //     reviews.add(new Null.fromJson(v));
    //   });
    // }
    productWishlisted = json['product_wishlisted'];
    rating = json['rating'];
    productId = json['product_id'];
    productName = json['product_name'];
    productShortDescription = json['product_short_description'];
    productDescription = json['product_description'];
    productPrice = json['product_price'];
    productSpPrice = json['product_sp_price'];
    productOffer = json['product_offer'];
    savings = json['savings'];
    productSku = json['product_sku'];
    productType = json['product_type'];
    stockQty = json['Stock_qty'];
    stockStatus = json['Stock_status'];
    productImage = json['product_image'].cast<String>();
    productUrl = json['product_url'];
  }
}

class Specifications {
  String label;
  String value;

  Specifications({this.label, this.value});

  Specifications.fromJson(Map<String, dynamic> json) {
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

class ProductOptions {
  int optionId;
  String label;
  List<String> optionData;
  List<Value> value;

  ProductOptions({this.optionId, this.label, this.optionData, this.value});

  ProductOptions.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    label = json['label'];
    optionData = json['option_data'].cast<String>();
    if (json['value'] != null) {
      value = new List<Value>();
      json['value'].forEach((v) {
        value.add(new Value.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_id'] = this.optionId;
    data['label'] = this.label;
    data['option_data'] = this.optionData;
    if (this.value != null) {
      data['value'] = this.value.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Value {
  String sku;
  String productId;
  String attributeCode;
  String valueIndex;
  String superAttributeLabel;
  String defaultTitle;
  String optionTitle;

  Value(
      {this.sku,
      this.productId,
      this.attributeCode,
      this.valueIndex,
      this.superAttributeLabel,
      this.defaultTitle,
      this.optionTitle});

  Value.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    productId = json['product_id'];
    attributeCode = json['attribute_code'];
    valueIndex = json['value_index'];
    superAttributeLabel = json['super_attribute_label'];
    defaultTitle = json['default_title'];
    optionTitle = json['option_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku'] = this.sku;
    data['product_id'] = this.productId;
    data['attribute_code'] = this.attributeCode;
    data['value_index'] = this.valueIndex;
    data['super_attribute_label'] = this.superAttributeLabel;
    data['default_title'] = this.defaultTitle;
    data['option_title'] = this.optionTitle;
    return data;
  }
}

class ChildProduct {
  int rating;
  String productId;
  String productName;
  String productStatus;
  String productShortDescription;
  String productDescription;
  String productSku;
  String productPrice;
  List<String> productImage;
  int stockQty;
  Null productSpPrice;
  Null savings;
  Null productOffer;

  ChildProduct(
      {this.rating,
      this.productId,
      this.productName,
      this.productStatus,
      this.productShortDescription,
      this.productDescription,
      this.productSku,
      this.productPrice,
      this.productImage,
      this.stockQty,
      this.productSpPrice,
      this.savings,
      this.productOffer});

  ChildProduct.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    productId = json['product_id'];
    productName = json['product_name'];
    productStatus = json['product_status'];
    productShortDescription = json['product_short_description'];
    productDescription = json['product_description'];
    productSku = json['product_sku'];
    productPrice = json['product_price'];
    productImage = json['product_image'].cast<String>();
    stockQty = json['Stock_qty'];
    productSpPrice = json['product_sp_price'];
    savings = json['savings'];
    productOffer = json['product_offer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_status'] = this.productStatus;
    data['product_short_description'] = this.productShortDescription;
    data['product_description'] = this.productDescription;
    data['product_sku'] = this.productSku;
    data['product_price'] = this.productPrice;
    data['product_image'] = this.productImage;
    data['Stock_qty'] = this.stockQty;
    data['product_sp_price'] = this.productSpPrice;
    data['savings'] = this.savings;
    data['product_offer'] = this.productOffer;
    return data;
  }
}