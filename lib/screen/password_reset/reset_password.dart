import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:zaincart_app/models/login_response.dart';
import 'package:zaincart_app/screen/login_screen.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_button.dart';
import 'package:zaincart_app/widgets/zc_logo.dart';
import 'package:zaincart_app/widgets/zc_text.dart';
import 'package:zaincart_app/widgets/zc_textformfield.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;

  ResetPasswordScreen({this.email, this.otp});
  @override
  ResetPasswordScreenState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  double _edgePadding = 45.0;

  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  TextEditingController _newPasswordController = new TextEditingController();
  TextEditingController _confirmpasswordController =
      new TextEditingController();
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
                              text: "FORGOT PASSWORD",
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
                                hintText: "New Password",
                                controller: _newPasswordController,
                                textInputAction: TextInputAction.next,
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
                            new SizedBox(
                              height: 20.0,
                            ),
                            new Container(
                              padding: EdgeInsets.only(
                                  left: _edgePadding, right: _edgePadding),
                              child: ZCTextFormField(
                                hintText: "Confirm Password",
                                controller: _confirmpasswordController,
                                obscureText: true,
                                validator: (text) {
                                  if (text.isEmpty) {
                                    return "Required";
                                  } else if (text.length < 6) {
                                    return "Please enter a valid password";
                                  } else if (_newPasswordController.text !=
                                      text) {
                                    return "Passwords are not matching";
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
                                title: "SUBMIT",
                                onPressed: () => _submitTapped(),
                              ),
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

  void _submitTapped() {
    if (_formKey.currentState.validate()) {
      AppUtils.isConnectedToInternet(context).then((isConnected) {
        if (isConnected) {
          setState(() => _isLoading = true);
          APIService()
              .resetPassword(
                  email: widget.email,
                  otp: widget.otp,
                  password: _confirmpasswordController.text)
              .then((response) {
            setState(() => _isLoading = false);
            if (response.statusCode == 200) {
              LoginResponse _loginResponse =
                  LoginResponse.fromJson(response.data);
              if (_loginResponse.success == 1) {
                AlertUtils.showToast(_loginResponse.data.message, context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()));
              } else {
                AlertUtils.showToast(_loginResponse.error, context);
              }
            } else {
              AlertUtils.showToast("Something went wrong", context);
            }
          });
        }
      });
    }
  }
}
