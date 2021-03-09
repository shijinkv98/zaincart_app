import 'package:flutter/material.dart';
import 'package:zaincart_app/screen/home.dart';
import 'package:zaincart_app/screen/home_controller.dart';
import 'package:zaincart_app/screen/login_screen.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/utils/preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Preferences.getBool(PrefKey.loginStatus).then((isLogin) {
        if (isLogin) {
          Preferences.get(PrefKey.token).then((authToken) {
            APIService().updateHeader(authToken);
            APIService().getBearerToken(authToken).then((response) {
              if (response.statusCode == 200) {
                if (response.data["success"] == 1) {
                  var bearerToken = response.data['data']['accesstoken'];
                  print("BEARER TOKEN +++ $bearerToken");
                  APIService().updateBearerToken(bearerToken);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => Home()));
                } else {
                  kMoveToLogin(context);
                }
              }
            });
          });
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen()));
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double divHeight = MediaQuery.of(context).size.height;
    final double divWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Image.asset(
          Constants.splash,
          fit: BoxFit.cover,
          height: divHeight,
          width: divWidth,
        ),
      ),
    );
  }
}
