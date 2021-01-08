import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:zaincart_app/screens/home_controller.dart';
import 'package:zaincart_app/screens/register_screen.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_button.dart';
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
        body: ProgressHUD(
          child: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(color: Constants.zc_orange),
              child: ListView(
                children: <Widget>[
                  new Container(
                    height: divHeight / 3,
                    child: Center(
                        child: ZCText(
                      text: "ZainCart",
                      fontSize: 30.0,
                    )),
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
                            ),
                            new SizedBox(
                              height: 50.0,
                            ),
                            new Container(
                              padding: EdgeInsets.only(
                                  left: _edgePadding, right: _edgePadding),
                              child: ZCTextFormField(
                                hintText: "Email Address",
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
                              height: 30.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () => _forgotPasswordTapped(),
                                  child: new ZCText(
                                    text: 'Forgot Your Password?',
                                    semiBold: false,
                                    color: Constants.vmd_button_text_grey,
                                  ),
                                ),
                                new ZCText(
                                  text: " / ",
                                ),
                                new InkWell(
                                  onTap: () => _signUpTapped(),
                                  child: new ZCText(
                                    text: 'Create An Account',
                                    color: Constants.vmd_button_text_grey,
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
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomeController()));
  }
}
