 
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

class HomeData {
  int cartCount;
  int wishCount;
  List<SearchCategory> searchCategory;
  List<CategoryList> categoryList;
  List<Slider> slider;
  List<NewProduct> newProduct;
  List<CategoryProducts> categoryProducts;

  HomeData(
      {this.cartCount,
      this.wishCount,
      this.searchCategory,
      this.categoryList,
      this.slider,
      this.newProduct,
      this.categoryProducts});

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
      newProduct = new List<NewProduct>();
      json['new_product'].forEach((v) {
        newProduct.add(new NewProduct.fromJson(v));
      });
    }
    if (json['category_products'] != null) {
      categoryProducts = new List<CategoryProducts>();
      json['category_products'].forEach((v) {
        categoryProducts.add(new CategoryProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_count'] = this.cartCount;
    data['wish_count'] = this.wishCount;
    if (this.searchCategory != null) {
      data['search_category'] =
          this.searchCategory.map((v) => v.toJson()).toList();
    }
    if (this.categoryList != null) {
      data['category_list'] = this.categoryList.map((v) => v.toJson()).toList();
    }
    if (this.slider != null) {
      data['slider'] = this.slider.map((v) => v.toJson()).toList();
    }
    if (this.newProduct != null) {
      data['new_product'] = this.newProduct.map((v) => v.toJson()).toList();
    }
    if (this.categoryProducts != null) {
      data['category_products'] =
          this.categoryProducts.map((v) => v.toJson()).toList();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['category_id'] = this.categoryId;
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory.map((v) => v.toJson()).toList();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entity_type'] = this.entityType;
    data['entity_id'] = this.entityId;
    data['link'] = this.link;
    data['file'] = this.file;
    data['label'] = this.label;
    data['media_type'] = this.mediaType;
    return data;
  }
}

class NewProduct {
  bool productWishlisted;
  String productId;
  String productSku;
  String productType;
  String productName;
  String productPrice;
  Null productSpPrice;
  Null productOffer;
  String productImage;

  NewProduct(
      {this.productWishlisted,
      this.productId,
      this.productSku,
      this.productType,
      this.productName,
      this.productPrice,
      this.productSpPrice,
      this.productOffer,
      this.productImage});

  NewProduct.fromJson(Map<String, dynamic> json) {
    productWishlisted = json['product_wishlisted'];
    productId = json['product_id'];
    productSku = json['product_sku'];
    productType = json['product_type'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    productSpPrice = json['product_sp_price'];
    productOffer = json['product_offer'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_wishlisted'] = this.productWishlisted;
    data['product_id'] = this.productId;
    data['product_sku'] = this.productSku;
    data['product_type'] = this.productType;
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['product_sp_price'] = this.productSpPrice;
    data['product_offer'] = this.productOffer;
    data['product_image'] = this.productImage;
    return data;
  }
}

class CategoryProducts {
  String name;
  List<Item> item;

  CategoryProducts({this.name, this.item});

  CategoryProducts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['item'] != null) {
      item = new List<Item>();
      json['item'].forEach((v) {
        item.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.item != null) {
      data['item'] = this.item.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  bool productWishlisted;
  String productId;
  String productSku;
  String productType;
  String productName;
  String productPrice;
  Null productSpPrice;
  Null productOffer;
  String productImage;

  Item(
      {this.productWishlisted,
      this.productId,
      this.productSku,
      this.productType,
      this.productName,
      this.productPrice,
      this.productSpPrice,
      this.productOffer,
      this.productImage});

  Item.fromJson(Map<String, dynamic> json) {
    productWishlisted = json['product_wishlisted'];
    productId = json['product_id'];
    productSku = json['product_sku'];
    productType = json['product_type'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    productSpPrice = json['product_sp_price'];
    productOffer = json['product_offer'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_wishlisted'] = this.productWishlisted;
    data['product_id'] = this.productId;
    data['product_sku'] = this.productSku;
    data['product_type'] = this.productType;
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['product_sp_price'] = this.productSpPrice;
    data['product_offer'] = this.productOffer;
    data['product_image'] = this.productImage;
    return data;
  }
}