import 'package:flutter/material.dart';
import 'package:zaincart_app/models/filtervalues_response.dart';
import 'package:zaincart_app/models/my_order_response.dart';
import 'package:zaincart_app/models/products_by_category_response.dart';
import 'package:zaincart_app/models/products_response.dart';
import 'package:zaincart_app/models/response.dart';
import 'package:zaincart_app/models/root_categories_response.dart';
import 'package:zaincart_app/models/wishlistAddResponse.dart';
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
  List<OrderDetail> myOrderList = new List<OrderDetail>();
  List<FilterData> filterValues = new List<FilterData>();
  String selectedCategoryId;
  String selectedSubCategoryId;

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

  getProductsByCategory(
      {BuildContext context, String categoryId, String pageNo}) {
    categoryProducts.clear();
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService()
            .getProductsByCategory(categoryId: categoryId, pageNo: pageNo)
            .then((response) {
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
              getFilterValues(context, categoryId);
              notifyListeners();
            }
          } else {
            AlertUtils.showToast("Something went wrong", context);
          }
        });
      }
    });
  }

  productSearch({BuildContext context, String searchKey}) {
    categoryProducts.clear();
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService().productSearch(searchKey).then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            WishlistResponse searchProductsResponse =
                WishlistResponse.fromJson(response.data);
            if (searchProductsResponse.success == 0) {
              AlertUtils.showToast(searchProductsResponse.error, context);
            } else if (searchProductsResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              categoryProducts = searchProductsResponse.data.product;
              notifyListeners();
            }
          } else {
            AlertUtils.showToast("Something went wrong", context);
          }
        });
      }
    });
  }

  wishListAdd(BuildContext context, String productId) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        APIService().wishlistAdd(productId).then((response) {
          if (response.statusCode == 200) {
            WishlistAddResponse wishlistResponse =
                WishlistAddResponse.fromJson(response.data);
            if (wishlistResponse.success == 0) {
              AlertUtils.showToast(wishlistResponse.error, context);
            } else if (wishlistResponse.success == 3) {
              kMoveToLogin(context);
            } else if (wishlistResponse.success == 1) {
              AlertUtils.showToast(wishlistResponse.data.message, context);
            }
          } else {
            AlertUtils.showToast("Login Failed", context);
          }
        });
      }
    });
  }

  wishListRemove(BuildContext context, String productId) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService().wishlistRemove(productId).then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            WishlistAddResponse wishlistResponse =
                WishlistAddResponse.fromJson(response.data);
            if (wishlistResponse.success == 0) {
              AlertUtils.showToast(wishlistResponse.error, context);
            } else if (wishlistResponse.success == 3) {
              kMoveToLogin(context);
            } else if (wishlistResponse.success == 1) {
              getWishlistItems(context);
              AlertUtils.showToast(wishlistResponse.data.message, context);
            }
          } else {
            AlertUtils.showToast("Login Failed", context);
          }
        });
      }
    });
  }

  getMyOrders(BuildContext context) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService().getMyOrderList().then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            MyOrderResponse myOrderResponse =
                MyOrderResponse.fromJson(response.data);
            if (myOrderResponse.success == 1) {
              myOrderList = myOrderResponse.data.orderlist;
              notifyListeners();
            } else if (myOrderResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(myOrderResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Something went wrong", context);
          }
        });
      }
    });
  }

  cancelOrder(BuildContext context, String orderId) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService().cancelOrder(orderId).then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            Response myOrderResponse = Response.fromJson(response.data);
            if (myOrderResponse.success == 1) {
              AlertUtils.showToast(
                  "Your order has been cancelled successfully.", context);
              Navigator.of(context).pop();
            } else if (myOrderResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(
                  "Sorry, We cant cancel your order right now.", context);
            }
          } else {
            AlertUtils.showToast("Something went wrong", context);
          }
        });
      }
    });
  }

  getFilterValues(BuildContext context, String categoryId) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        APIService().getFilterValues(categoryId).then((response) {
          if (response.statusCode == 200) {
            FilterValueResponse filterValueResponse =
                FilterValueResponse.fromJson(response.data);
            if (filterValueResponse.success == 0) {
              AlertUtils.showToast(filterValueResponse.error, context);
            } else if (filterValueResponse.success == 3) {
              kMoveToLogin(context);
            } else if (filterValueResponse.success == 1) {
              filterValues = filterValueResponse.filterValues;
              notifyListeners();
            }
          } else {
            AlertUtils.showToast("Login Failed", context);
          }
        });
      }
    });
  }

  getFilterProducts(
      {BuildContext context, String categoryId, String filterVal, String key}) {
    categoryProducts.clear();
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService()
            .getFilteredProducts(
                category: categoryId, values: filterVal, key: key)
            .then((response) {
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
              getFilterValues(context, categoryId);
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
