class RootCategoriesResponse {
  int success;
  String error;
  List<Category> category;

  RootCategoriesResponse({this.success, this.error, this.category});

  RootCategoriesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    if (json['data'] != null) {
      category = new List<Category>();
      json['data'].forEach((v) {
        category.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.category != null) {
      data['data'] = this.category.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String categoryName;
  String categoryId;
  String image;
  List<Subcategory> subcategory;

  Category({this.categoryName, this.categoryId, this.image, this.subcategory});

  Category.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    categoryId = json['category_id'];
    image = json['image'];
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
    data['image'] = this.image;
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategory {
  String categoryName;
  String categoryId;
  String image;
  int nextLevelStatus;

  Subcategory(
      {this.categoryName, this.categoryId, this.image, this.nextLevelStatus});

  Subcategory.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    categoryId = json['category_id'];
    image = json['image'];
    nextLevelStatus = json['next_level_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['category_id'] = this.categoryId;
    data['image'] = this.image;
    data['next_level_status'] = this.nextLevelStatus;
    return data;
  }
}