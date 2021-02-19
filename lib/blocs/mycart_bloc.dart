import 'package:flutter/material.dart';
import 'package:zaincart_app/models/cartlist_response.dart';
import 'package:zaincart_app/models/products_response.dart';
import 'package:zaincart_app/models/response.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';

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
}
