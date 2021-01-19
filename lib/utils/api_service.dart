import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:zaincart_app/utils/api_client.dart';
import 'package:zaincart_app/utils/preferences.dart';

class APIService {
  static final APIService _singleton = new APIService._internal();

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

  updateHeader(String authToken) {
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.headers["token"] = authToken;
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
}
