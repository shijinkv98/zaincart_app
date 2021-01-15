import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:zaincart_app/utils/api_client.dart';

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
    dio.options.headers["X-Auth-Key"] = authToken;
    print("TOKEN=== ${dio.options.headers["X-Auth-Key"]}");
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

}
