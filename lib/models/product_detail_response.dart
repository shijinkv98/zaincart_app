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
  String specifications;
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
    specifications = json['specifications'];
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
}

