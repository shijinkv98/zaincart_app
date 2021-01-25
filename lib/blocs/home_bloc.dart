import 'package:flutter/material.dart';
import 'package:zaincart_app/models/products_response.dart';
import 'package:zaincart_app/models/response.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';

class HomeBloc extends ChangeNotifier {
  HomeData _homeData = new HomeData();

  HomeData get homeData => _homeData;
  set homeData(HomeData data) {
    _homeData = data;
    notifyListeners();
  }

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
            if (loginResponse.success != 1) {
              AlertUtils.showToast(loginResponse.error, context);
            } else {
              ProductsResponse productsResponse =
                  ProductsResponse.fromJson(response.data);
              homeData = productsResponse.data;
              notifyListeners();
              print(productsResponse.data.newProduct.length);
            }
          } else {
            AlertUtils.showToast("Login Failed", context);
          }
        });
      }
    });
  }
}
