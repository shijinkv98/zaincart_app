import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:zaincart_app/models/address.dart';
import 'package:zaincart_app/utils/api_client.dart';
import 'package:zaincart_app/utils/preferences.dart';

class APIService {
  static final APIService _singleton = new APIService._internal();
  String customerId;
  String token;

  factory APIService() {
    return _singleton;
  }

  APIService._internal() {
    _initilizeHeader();
  }

  Dio dio = new Dio();

  _initilizeHeader() {
    dio.options.headers["Content-Type"] = "application/json";
  }

  updateHeader(String authToken) async {
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.headers["token"] = authToken;
    dio.options.headers["Authorization"] = "authToken";
    customerId = await Preferences.get(PrefKey.id);
    token = await Preferences.get(PrefKey.token);
    print("TOKEN=== ${dio.options.headers["token"]}");
  }

  ///Signup user///
  Future<Response> signUpUser(dynamic signupData) async {
    print("URL:::" + APIClient.signup);
    var jsonBody = json.encode(signupData);
    print(jsonBody);
    Response response = await dio.post(APIClient.signup, data: jsonBody);
    print("RESPONSE:::" + response.data.toString());
    return response;
  }

  //login user///
  Future<Response> login(String email, String password) async {
    print("URL:::" + APIClient.login);
    Map<String, String> body = {"email": email, "password": password};
    var jsonBody = json.encode(body);
    print(jsonBody);
    Response response = await dio.post(APIClient.login, data: jsonBody);
    print("RESPONSE:::" + response.data.toString());
    return response;
  }

  //get home data///
  Future<Response> getHomeData() async {
    var id = await Preferences.get(PrefKey.id);
    print("URL:::" + APIClient.homeData(id));
    Response response = await dio.get(APIClient.homeData(id));
    print("RESPONSE:::" + response.data.toString());
    return response;
  }

  //get home data///
  Future<Response> getPrductDetail(String productId) async {
    var customerId = await Preferences.get(PrefKey.id);
    print("URL:::" +
        APIClient.productDetail(productId: productId, customerId: customerId));
    Response response = await dio.get(
        APIClient.productDetail(productId: productId, customerId: customerId));
    print("RESPONSE:::" + response.data.toString());
    return response;
  }

  //get wishlist data///
  Future<Response> getWishlist() async {
    print("URL:::" + APIClient.wishlist(customerId: customerId, token: token));
    Response response =
        await dio.get(APIClient.wishlist(customerId: customerId, token: token));
    print("RESPONSE:::" + response.data.toString());
    return response;
  }

  //get mycart data///
  Future<Response> getMyCartItems() async {
    var url = APIClient.mycartList;
    var queryParams = {
      "customer_id": "$customerId",
      "customertoken": "$token",
    };
    print("URL:::" + url);
    Response response = await dio.get(url, queryParameters: queryParams);
    print("RESPONSE:::" + response.data.toString());
    return response;
  }

  //wishlist add///
  Future<Response> wishlistAdd(String produtId) async {
    var url = APIClient.wishListAdd;
    var queryParams = {
      "customer_id": "$customerId",
      "customertoken": "$token",
      "Product_id": "$produtId"
    };
    print("URL:::" + url + "$queryParams");
    Response response = await dio.post(url, queryParameters: queryParams);
    print("RESPONSE:::" + response.data.toString());
    return response;
  }

  //cart add///
  Future<Response> addToCart({String productSku, String productQty}) async {
    var url = APIClient.addToCart;
    var queryParams = {
      "customer_id": "$customerId",
      "customertoken": "$token",
      "Product_sku": "$productSku",
      "Product_qty": "$productQty"
    };
    print("URL:::" + url + " $queryParams");
    Response response = await dio.post(url, queryParameters: queryParams);
    print("RESPONSE:::" + response.data.toString());
    return response;
  }

  //wishlist remove///
  Future<Response> wishlistRemove(String produtId) async {
    var url = APIClient.wishlistRemove;
    var queryParams = {
      "customer_id": "$customerId",
      "customertoken": "$token",
      "Product_id": "$produtId"
    };
    print("URL:::" + url + "$queryParams");
    Response response = await dio.post(url, queryParameters: queryParams);
    print("RESPONSE:::" + response.data.toString());
    return response;
  }

  //cart remove///
  Future<Response> removeFromCart(String itemId, String cartId) async {
    var url = APIClient.removeFromCart;
    var queryParams = {
      "customer_id": "$customerId",
      "customertoken": "$token",
      "itemid": "$itemId",
      "itemcartid": "$cartId"
    };
    print("URL:::" + url + "$queryParams");
    Response response = await dio.post(url, queryParameters: queryParams);
    print("RESPONSE:::" + response.data.toString());
    return response;
  }

  //address list///
  Future<Response> addressList() async {
    var url = APIClient.addressList;
    var queryParams = {
      "customer_id": "$customerId",
      "customertoken": "$token",
    };
    print("URL:::" + url + "$queryParams");
    Response response = await dio.get(url, queryParameters: queryParams);
    print("RESPONSE:::" + response.data.toString());
    return response;
  }

  //Add address///
  Future<Response> addAddress(dynamic address) async {
    var url = APIClient.addAddress;
    var jsonBody = json.encode(address);
    print("URL:::" + url + "$jsonBody");
    Response response = await dio.post(url, data: jsonBody);
    print("RESPONSE:::" + response.data.toString());
    return response;
  }

  //address update///
  Future<Response> addressUpdate(dynamic address) async {
    var url = APIClient.addressUpdate;
    var jsonBody = json.encode(address);
    print("URL:::" + url + "$jsonBody");
    Response response = await dio.post(url, data: jsonBody);
    print("RESPONSE:::" + response.data.toString());
    return response;
  }

  //address list///
  Future<Response> placeOrder(
      {dynamic shippingAdresss,
      dynamic billingAddress,
      dynamic orderData}) async {
    var url = APIClient.placeOrder;
    var queryParams = {
      "customerId": "$customerId",
      "customertoken": "$token",
      "promocode": "0",
      "discount": "0",
      "shippingaddress": json.encode(shippingAdresss),
      "billingaddress": json.encode(billingAddress),
      "OrderData": orderData
    };
    print("URL:::" + url + "$queryParams");
    Response response = await dio.post(url, queryParameters: queryParams);
    print("RESPONSE:::" + response.data.toString());
    return response;
  }
}
