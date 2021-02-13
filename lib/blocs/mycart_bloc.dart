import 'package:flutter/material.dart';
import 'package:zaincart_app/models/products_response.dart';
import 'package:zaincart_app/models/response.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';

class MyCartBloc extends ChangeNotifier {
  List<Product> myCartList;
  List<Product> get homeData => myCartList;
  set homeData(List<Product> data) {
    myCartList = data;
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
            Response loginResponse = Response.fromJson(response.data);
            if (loginResponse.success != 1) {
              AlertUtils.showToast(loginResponse.error, context);
            } else {
              ProductsResponse productsResponse =
                  ProductsResponse.fromJson(response.data);

              notifyListeners();
              print(productsResponse.data.newProduct.length);
            }
          } else {
            AlertUtils.showToast("Failed", context);
          }
        });
      }
    });
  }
}
