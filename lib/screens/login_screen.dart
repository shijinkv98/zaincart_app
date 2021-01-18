import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:zaincart_app/models/login_response.dart';
import 'package:zaincart_app/models/response.dart';
import 'package:zaincart_app/screens/home_controller.dart';
import 'package:zaincart_app/screens/register_screen.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/utils/preferences.dart';
import 'package:zaincart_app/widgets/zc_button.dart';
import 'package:zaincart_app/widgets/zc_logo.dart';
import 'package:zaincart_app/widgets/zc_text.dart';
import 'package:zaincart_app/widgets/zc_textformfield.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  double _edgePadding = 45.0;

  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final double divHeight = MediaQuery.of(context).size.height;
    final double divWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: _isLoading,
          child: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(color: Constants.zc_yellow),
              child: ListView(
                children: <Widget>[
                  new Container(
                    height: divHeight / 3,
                    child: Center(child: ZCLogo()),
                  ),
                  Container(
                    height: divHeight - divHeight / 3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(32),
                            topLeft: Radius.circular(32))),
                    child: Center(
                      child: Form(
                        key: _formKey,
                        autovalidate: _autovalidate,
                        child: Column(
                          children: <Widget>[
                            new SizedBox(
                              height: 50.0,
                            ),
                            new ZCText(
                              text: "LOGIN",
                              semiBold: true,
                              color: Constants.zc_font_black,
                            ),
                            new SizedBox(
                              height: 50.0,
                            ),
                            new Container(
                              padding: EdgeInsets.only(
                                  left: _edgePadding, right: _edgePadding),
                              child: ZCTextFormField(
                                hintText: "Email",
                                controller: _usernameController,
                                textInputType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: (email) {
                                  if (email.isEmpty) {
                                    return "Required";
                                  } else if (!AppUtils.isValidEmail(email)) {
                                    return "Please enter a valid email address";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            new SizedBox(
                              height: 20.0,
                            ),
                            new Container(
                              padding: EdgeInsets.only(
                                  left: _edgePadding, right: _edgePadding),
                              child: ZCTextFormField(
                                hintText: "Password",
                                controller: _passwordController,
                                obscureText: true,
                                validator: (text) {
                                  if (text.isEmpty) {
                                    return "Required";
                                  } else if (text.length < 6) {
                                    return "Please enter a valid password";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: _edgePadding, right: _edgePadding),
                              child: new ZCButton(
                                title: "LOGIN",
                                onPressed: () => _loginTapped(),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () => _forgotPasswordTapped(),
                                  child: new ZCText(
                                    text: 'Forgot Your Password?',
                                    semiBold: false,
                                    color: Constants.zc_font_black,
                                  ),
                                ),
                                new ZCText(
                                  text: " / ",
                                  color: Constants.zc_font_black,
                                  semiBold: false,
                                ),
                                new InkWell(
                                  onTap: () => _signUpTapped(),
                                  child: new ZCText(
                                    text: 'Create An Account',
                                    color: Constants.zc_font_black,
                                    semiBold: false,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ));
  }

  void _signUpTapped() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => SignUpScreen()));
  }

  void _forgotPasswordTapped() {}

  void _loginTapped() {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        setState(() {
          _isLoading = true;
        });
        APIService()
            .login(_usernameController.text.trim(), _passwordController.text)
            .then((response) {
          setState(() {
            _isLoading = false;
          });
          if (response.statusCode == 200) {
            LoginResponse loginResponse = LoginResponse.fromJson(response.data);
            if (loginResponse.success != 1) {
              AlertUtils.showToast(loginResponse.error, context);
            } else {
              //save user to prefs.
              APIService().updateHeader(loginResponse.data.token);
              Preferences.save(PrefKey.token, loginResponse.data.token);
              Preferences.save(PrefKey.id, loginResponse.data.customerId);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => HomeController()));
            }
          } else {
            AlertUtils.showToast("Login Failed", context);
          }
        });
      }
    });
  }
}
