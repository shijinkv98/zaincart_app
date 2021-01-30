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
  String productOptions;
  String childProduct;
  bool productWishlisted;
  String productId;
  String productName;
  String productShortDescription;
  String productDescription;
  String productPrice;
  String productSpPrice;
  String productOffer;
  String savings;
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
      this.productWishlisted,
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
    productOptions = json['product_options'];
    childProduct = json['Child_product'];
    productWishlisted = json['product_wishlisted'];
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_count'] = this.cartCount;
    data['wish_count'] = this.wishCount;
    if (this.specifications != null) {
      data['specifications'] =
          this.specifications.map((v) => v.toJson()).toList();
    }
    data['product_options'] = this.productOptions;
    data['Child_product'] = this.childProduct;
    data['product_wishlisted'] = this.productWishlisted;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_short_description'] = this.productShortDescription;
    data['product_description'] = this.productDescription;
    data['product_price'] = this.productPrice;
    data['product_sp_price'] = this.productSpPrice;
    data['product_offer'] = this.productOffer;
    data['savings'] = this.savings;
    data['product_sku'] = this.productSku;
    data['product_type'] = this.productType;
    data['Stock_qty'] = this.stockQty;
    data['Stock_status'] = this.stockStatus;
    data['product_image'] = this.productImage;
    data['product_url'] = this.productUrl;
    return data;
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