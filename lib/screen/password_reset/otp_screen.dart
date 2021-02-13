import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:zaincart_app/screen/password_reset/reset_password.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_button.dart';
import 'package:zaincart_app/widgets/zc_logo.dart';
import 'package:zaincart_app/widgets/zc_text.dart';
import 'package:zaincart_app/widgets/zc_textformfield.dart';

class OTPScreen extends StatefulWidget {
  @override
  OTPScreenState createState() => OTPScreenState();
}

class OTPScreenState extends State<OTPScreen> {
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
                                hintText: "Enter Email",
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
                                hintText: "Enter OTP",
                                controller: _passwordController,
                                obscureText: true,
                                validator: (text) {
                                  if (text.isEmpty) {
                                    return "Required";
                                  } else if (text.length < 6) {
                                    return "Please enter a valid otp";
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
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => ResetPasswordScreen()));
    }
  }
}
