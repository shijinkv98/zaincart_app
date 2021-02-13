import 'package:flutter/material.dart';
import 'package:zaincart_app/screen/home_controller.dart';
import 'package:zaincart_app/screen/login_screen.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/preferences.dart';
import 'package:zaincart_app/widgets/zc_logo.dart';

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
          });
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => HomeController()));
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
    return Scaffold(
      body: Center(
        child: Container(
          child: ZCLogo(),
        ),
      ),
    );
  }
}
