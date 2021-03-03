class ProductsResponse {
  int success;
  String error;
  HomeData data;

  ProductsResponse({this.success, this.error, this.data});

  ProductsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    data = json['data'] != null ? new HomeData.fromJson(json['data']) : null;
  }
}

class HomeData {
  int cartCount;
  int wishCount;
  List<SearchCategory> searchCategory;
  List<CategoryList> categoryList;
  List<Slider> slider;
  List<Product> newProduct;
  List<CategoryProducts> categoryProducts;
  List<CategoryProducts> featuredProduct;

  HomeData(
      {this.cartCount,
      this.wishCount,
      this.searchCategory,
      this.categoryList,
      this.slider,
      this.newProduct,
      this.categoryProducts,
      this.featuredProduct});

  HomeData.fromJson(Map<String, dynamic> json) {
    cartCount = json['cart_count'];
    wishCount = json['wish_count'];
    if (json['search_category'] != null) {
      searchCategory = new List<SearchCategory>();
      json['search_category'].forEach((v) {
        searchCategory.add(new SearchCategory.fromJson(v));
      });
    }
    if (json['category_list'] != null) {
      categoryList = new List<CategoryList>();
      json['category_list'].forEach((v) {
        categoryList.add(new CategoryList.fromJson(v));
      });
    }
    if (json['slider'] != null) {
      slider = new List<Slider>();
      json['slider'].forEach((v) {
        slider.add(new Slider.fromJson(v));
      });
    }
    if (json['new_product'] != null) {
      newProduct = new List<Product>();
      json['new_product'].forEach((v) {
        newProduct.add(new Product.fromJson(v));
      });
    }
    if (json['category_products'] != null) {
      categoryProducts = new List<CategoryProducts>();
      json['category_products'].forEach((v) {
        categoryProducts.add(new CategoryProducts.fromJson(v));
      });
    }
    if (json['featured_product'] != null) {
      featuredProduct = new List<CategoryProducts>();
      json['featured_product'].forEach((v) {
        featuredProduct.add(new CategoryProducts.fromJson(v));
      });
    }
  }
}

class SearchCategory {
  String categoryName;
  String categoryId;
  List<Subcategory> subcategory;

  SearchCategory({this.categoryName, this.categoryId, this.subcategory});

  SearchCategory.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    categoryId = json['category_id'];
    if (json['subcategory'] != null) {
      subcategory = new List<Subcategory>();
      json['subcategory'].forEach((v) {
        subcategory.add(new Subcategory.fromJson(v));
      });
    }
  }
}

class Subcategory {
  String categoryName;
  String categoryId;

  Subcategory({this.categoryName, this.categoryId});

  Subcategory.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['category_id'] = this.categoryId;
    return data;
  }
}

class CategoryList {
  String categoryName;
  int categoryId;
  String image;

  CategoryList({this.categoryName, this.categoryId, this.image});

  CategoryList.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    categoryId = json['category_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['category_id'] = this.categoryId;
    data['image'] = this.image;
    return data;
  }
}

class Slider {
  String entityType;
  String entityId;
  String link;
  String file;
  String label;
  String mediaType;

  Slider(
      {this.entityType,
      this.entityId,
      this.link,
      this.file,
      this.label,
      this.mediaType});

  Slider.fromJson(Map<String, dynamic> json) {
    entityType = json['entity_type'];
    entityId = json['entity_id'];
    link = json['link'];
    file = json['file'];
    label = json['label'];
    mediaType = json['media_type'];
  }
}

class Product {
  bool productWishlisted;
  String productId;
  String productSku;
  String productType;
  String productName;
  String productPrice;
  String productSpPrice;
  String productOffer;
  String productImage;
  int rating;

  Product(
      {this.productWishlisted,
      this.productId,
      this.productSku,
      this.productType,
      this.productName,
      this.productPrice,
      this.rating,
      this.productSpPrice,
      this.productOffer,
      this.productImage});

  Product.fromJson(Map<String, dynamic> json) {
    productWishlisted = json['product_wishlisted'];
    productId = json['product_id'];
    productSku = json['product_sku'];
    productType = json['product_type'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    rating = json['rating'];
    productSpPrice = json['product_sp_price'];
    productOffer = json['product_offer'];
    productImage = json['product_image'];
  }
}

class CategoryProducts {
  String name;
  List<Product> items;

  CategoryProducts({this.name, this.items});

  CategoryProducts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['item'] != null) {
      items = new List<Product>();
      json['item'].forEach((v) {
        items.add(new Product.fromJson(v));
      });
    }
  }
}
