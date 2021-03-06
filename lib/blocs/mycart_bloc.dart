import 'package:flutter/material.dart';
import 'package:zaincart_app/models/cartlist_response.dart';
import 'package:zaincart_app/models/create_order_response.dart';
import 'package:zaincart_app/models/products_response.dart';
import 'package:zaincart_app/models/response.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/utils/preferences.dart';

class MyCartBloc extends ChangeNotifier {
  List<Product> myCartList;
  List<Product> get homeData => myCartList;
  set homeData(List<Product> data) {
    myCartList = data;
    notifyListeners();
  }

  MyCartResponse _cartResponse;
  MyCartResponse get cartResponse => _cartResponse;
  set cartResponseData(MyCartResponse data) {
    _cartResponse = data;
    notifyListeners();
  }

  OrderData orderData;

  double totalAmount = 0.0;

  bool isLoading = false;

  getMyCartList(BuildContext context) async {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        APIService().getMyCartItems().then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            MyCartResponse cartResponse =
                MyCartResponse.fromJson(response.data);
            if (cartResponse.success == 1) {
              cartResponseData = cartResponse;
              getTodtal();
            } else if (cartResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              cartResponseData = null;
              AlertUtils.showToast(cartResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Failed", context);
          }
        });
      }
    });
  }

  placeOrder(BuildContext context) async {
    AppUtils.isConnectedToInternet(context).then((isConnected) async {
      if (isConnected) {
        isLoading = true;
        notifyListeners();
        var orderDataInput = {
          "date": DateTime.now().toString(),
          "email": await Preferences.get(PrefKey.email),
          "payment_method": "cashondelivery",
          "currency_id": "QAR",
          "shipping_method": "flatrate_flatrate",
          "time": "12"
        };
        APIService()
            .placeOrder(
                shippingAdresss: _cartResponse.cartInfo.address.shippingAddress,
                billingAddress: _cartResponse.cartInfo.address.billingAddress,
                orderData: orderDataInput)
            .then((response) {
          isLoading = false;
          notifyListeners();
          if (response.statusCode == 200) {
            CreateOrderResponse orderResponse =
                CreateOrderResponse.fromJson(response.data);
            if (cartResponse.success == 1) {
              orderData = orderResponse.orderData;
              AlertUtils.showToast("Order Placed Successfully", context);
            } else if (cartResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(cartResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Failed", context);
          }
        });
      }
    });
  }

  addToCart({BuildContext context, String productSku, String productQty}) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        APIService()
            .addToCart(productSku: productSku, productQty: productQty)
            .then((response) {
          if (response.statusCode == 200) {
            ZCResponse wishlistResponse = ZCResponse.fromJson(response.data);
            if (wishlistResponse.success == 0) {
              AlertUtils.showToast(wishlistResponse.error, context);
            } else if (wishlistResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast("Added to Cart", context);
            }
          } else {
            AlertUtils.showToast("Something went wrong", context);
          }
        });
      }
    });
  }

  updateCartItem(
      {BuildContext context,
      String productQty,
      String cartItemId,
      String cartId}) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        APIService()
            .updateCartItem(
                productQty: productQty, cartItemId: cartItemId, cartId: cartId)
            .then((response) {
          if (response.statusCode == 200) {
            ZCResponse wishlistResponse = ZCResponse.fromJson(response.data);
            if (wishlistResponse.success == 0) {
              AlertUtils.showToast(wishlistResponse.error, context);
            } else if (wishlistResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast("Item successfully updated", context);
              getMyCartList(context);
            }
          } else {
            AlertUtils.showToast("Something went wrong", context);
          }
        });
      }
    });
  }

  removeFromCart({BuildContext context, String itemId, String cartId}) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        APIService().removeFromCart(itemId, cartId).then((response) {
          if (response.statusCode == 200) {
            ZCResponse wishlistResponse = ZCResponse.fromJson(response.data);
            if (wishlistResponse.success == 0) {
              AlertUtils.showToast(wishlistResponse.error, context);
            } else if (wishlistResponse.success == 3) {
              kMoveToLogin(context);
            } else if (wishlistResponse.success == 1) {
              getMyCartList(context);
            }
          } else {
            AlertUtils.showToast("Something went wrong", context);
          }
        });
      }
    });
  }

  getTodtal() {
    double total = 0.0;
    for (CartProduct product in cartResponse.data.product) {
      total = total +
          product.quantity * double.parse(product.productPrice.substring(3));
    }
    totalAmount = total;
    notifyListeners();
  }
}
