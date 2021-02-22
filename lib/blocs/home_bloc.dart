import 'package:flutter/material.dart';
import 'package:zaincart_app/models/products_by_category_response.dart';
import 'package:zaincart_app/models/products_response.dart';
import 'package:zaincart_app/models/response.dart';
import 'package:zaincart_app/models/root_categories_response.dart';
import 'package:zaincart_app/models/wishlist_response.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';

class HomeBloc extends ChangeNotifier {
  HomeData _homeData = new HomeData();
  HomeData get homeData => _homeData;
  set homeData(HomeData data) {
    _homeData = data;
    notifyListeners();
  }

  List<Product> _wishlistItems = new List<Product>();
  List<Product> get wishlistItems => _wishlistItems;
  set wishlistdata(List<Product> data) {
    _wishlistItems = data;
    notifyListeners();
  }

  List<Category> categories = new List<Category>();
  List<Product> categoryProducts = new List<Product>();


  bool isLoading = false;

  getHomeData(BuildContext context) async {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService().getHomeData().then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            Response loginResponse = Response.fromJson(response.data);
            if (loginResponse.success == 1) {
              ProductsResponse productsResponse =
                  ProductsResponse.fromJson(response.data);
              homeData = productsResponse.data;
              notifyListeners();
            } else if (loginResponse.success == 3) {
              print("NEED TO LOGIN HERE......");
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(loginResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Login Failed", context);
          }
        });
      }
    });
  }

  getWishlistItems(BuildContext context) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService().getWishlist().then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            WishlistResponse wishlistResponse =
                WishlistResponse.fromJson(response.data);
            if (wishlistResponse.success == 0) {
              AlertUtils.showToast(wishlistResponse.error, context);
            } else if (wishlistResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              _wishlistItems = wishlistResponse.data.product;
              notifyListeners();
            }
          } else {
            AlertUtils.showToast("Something went wrong", context);
          }
        });
      }
    });
  }

  getRootCategories(BuildContext context) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService().getRootCategories().then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            RootCategoriesResponse rootCategoriesResponse =
                RootCategoriesResponse.fromJson(response.data);
            if (rootCategoriesResponse.success == 0) {
              AlertUtils.showToast(rootCategoriesResponse.error, context);
            } else if (rootCategoriesResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              categories = rootCategoriesResponse.category;
              notifyListeners();
            }
          } else {
            AlertUtils.showToast("Something went wrong", context);
          }
        });
      }
    });
  }

  getProductsByCategory({BuildContext context, String categoryId, String pageNo}) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService().getProductsByCategory(categoryId: categoryId, pageNo: pageNo).then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            ProductsByCategoryResponse categoryProductsResponse =
                ProductsByCategoryResponse.fromJson(response.data);
            if (categoryProductsResponse.success == 0) {
              AlertUtils.showToast(categoryProductsResponse.error, context);
            } else if (categoryProductsResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              categoryProducts = categoryProductsResponse.data.categoryProduct;
              notifyListeners();
            }
          } else {
            AlertUtils.showToast("Something went wrong", context);
          }
        });
      }
    });
  }
}
