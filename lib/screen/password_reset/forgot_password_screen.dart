import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:zaincart_app/models/login_response.dart';
import 'package:zaincart_app/models/response.dart';
import 'package:zaincart_app/screen/password_reset/otp_screen.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_button.dart';
import 'package:zaincart_app/widgets/zc_logo.dart';
import 'package:zaincart_app/widgets/zc_text.dart';
import 'package:zaincart_app/widgets/zc_textformfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  double _edgePadding = 45.0;

  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  TextEditingController _usernameController = new TextEditingController();
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
                  FlatButton(
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Constants.zc_font_black,
                          size: 15.0,
                        ),
                        ZCText(text: "Back to login",)
                      ],
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
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
                                hintText: "Enter Your Email",
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
                            SizedBox(
                              height: 30.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: _edgePadding, right: _edgePadding),
                              child: new ZCButton(
                                title: "SEND",
                                onPressed: () => _sendTapped(),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              width: 250.0,
                              child: ZCText(
                                text:
                                    'Please enter you email address below to recieve OTP',
                                semiBold: false,
                                fontSize: kSmallFontSize,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                color: Constants.zc_font_grey,
                              ),
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

  void _sendTapped() {
    if (_formKey.currentState.validate()) {
      AppUtils.isConnectedToInternet(context).then((isConnected) {
        if (isConnected) {
          setState(() => _isLoading = true);
          APIService()
              .forgotPassword(_usernameController.text)
              .then((response) {
            setState(() => _isLoading = false);
            if (response.statusCode == 200) {
              LoginResponse _loginResponse =
                  LoginResponse.fromJson(response.data);
              if (_loginResponse.success == 1) {
                AlertUtils.showToast(_loginResponse.data.message, context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => OTPScreen()));
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
