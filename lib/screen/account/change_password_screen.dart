import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:zaincart_app/models/login_response.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/utils/preferences.dart';
import 'package:zaincart_app/widgets/zc_button.dart';
import 'package:zaincart_app/widgets/zc_text.dart';
import 'package:zaincart_app/widgets/zc_textformfield.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String email;
  final String otp;

  ChangePasswordScreen({this.email, this.otp});
  @override
  ChangePasswordScreenState createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  double _edgePadding = 45.0;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _currentPasswordController =
      new TextEditingController();
  TextEditingController _newPasswordController = new TextEditingController();
  TextEditingController _confirmpasswordController =
      new TextEditingController();
  bool _isLoading = false;
  String _currentPassword;

  @override
  void initState() {
    Preferences.get(PrefKey.password).then((value) {
      _currentPassword = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double divHeight = MediaQuery.of(context).size.height;
    final double divWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          //title: ZCAppBarTitle("CHANGE PASSWORD"),
          backgroundColor: Colors.white,
          leading: Builder(
              builder: (BuildContext context) => Padding(
                    padding: EdgeInsets.only(left: 0.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Constants.zc_font_black,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )),
        ),
        body: ModalProgressHUD(
          inAsyncCall: _isLoading,
          child: Center(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: <Widget>[
                  new SizedBox(
                    height: 50.0,
                  ),
                  new ZCText(
                    text: "CHANGE PASSWORD",
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
                      hintText: "Current Password",
                      controller: _currentPasswordController,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      validator: (text) {
                        if (text.isEmpty) {
                          return "Required";
                        } else if (text.length < 6) {
                          return "Please enter a valid password";
                        } else if (text != _currentPassword) {
                          return "Please enter your current password";
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
                      hintText: "New Password",
                      controller: _newPasswordController,
                      showRevealIcon: true,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      validator: (text) {
                        if (text.isEmpty) {
                          return "Required";
                        } else if (text.length < 6) {
                          return "Please enter a valid password";
                        } else if (text == _currentPassword) {
                          return "Please enter a different password";
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
                      showRevealIcon: true,
                      obscureText: true,
                      validator: (text) {
                        if (text.isEmpty) {
                          return "Required";
                        } else if (text.length < 6) {
                          return "Please enter a valid password";
                        } else if (_newPasswordController.text != text) {
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
        ));
  }

  void _submitTapped() {
    if (_formKey.currentState.validate()) {
      AppUtils.isConnectedToInternet(context).then((isConnected) {
        if (isConnected) {
          setState(() => _isLoading = true);
          APIService()
              .changePassword(
                  currentPassword: _currentPasswordController.text,
                  password: _confirmpasswordController.text)
              .then((response) {
            setState(() => _isLoading = false);
            if (response.statusCode == 200) {
              LoginResponse _loginResponse =
                  LoginResponse.fromJson(response.data);
              if (_loginResponse.success == 1) {
                AlertUtils.showToast(_loginResponse.data.message, context);
                Navigator.of(context).pop();
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
