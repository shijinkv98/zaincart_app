import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:zaincart_app/models/response.dart';
import 'package:zaincart_app/models/signup_data.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/widgets/zc_button.dart';
import 'package:zaincart_app/widgets/zc_logo.dart';
import 'package:zaincart_app/widgets/zc_text.dart';
import 'package:zaincart_app/widgets/zc_textformfield.dart';

class SignUpScreen extends StatefulWidget {
  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  double _edgePadding = 45.0;
  int radioGroup = 0;
  bool _autovalidate = false;

  final _formKey = GlobalKey<FormState>();
  var _firstName_controller = new TextEditingController();
  var _lastName_controller = new TextEditingController();
  var _email_controller = new TextEditingController();
  var _phone_controller = new TextEditingController();
  var _password_controller = new TextEditingController();

  SignupData _signupData = new SignupData();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double divHeight = MediaQuery.of(context).size.height;
    final double divWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Container(
          constraints: BoxConstraints.expand(),
          color: Colors.orange[100],
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                new Container(
                  height: divHeight / 3,
                  child: Center(child: ZCLogo()),
                ),
                new Container(
                  height: divHeight - divHeight / 3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(32),
                          topLeft: Radius.circular(32))),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autovalidate
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: _edgePadding, right: _edgePadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new SizedBox(
                            height: 20.0,
                          ),
                          new ZCText(
                            text: "REGISTER",
                            semiBold: true,
                          ),
                          new SizedBox(
                            height: 20.0,
                          ),
                          new Container(
                            child: ZCTextFormField(
                              hintText: "First Name",
                              controller: _firstName_controller,
                              textInputType: TextInputType.text,
                              textCapitalization: TextCapitalization.sentences,
                              emptyValidator: true,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          new SizedBox(
                            height: 20.0,
                          ),
                          new Container(
                            child: ZCTextFormField(
                              hintText: "Last Name",
                              controller: _lastName_controller,
                              textCapitalization: TextCapitalization.sentences,
                              emptyValidator: true,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          new SizedBox(
                            height: 20.0,
                          ),
                          new Container(
                            child: ZCTextFormField(
                              hintText: "Phone",
                              controller: _phone_controller,
                              emptyValidator: true,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.phone,
                            ),
                          ),
                          new SizedBox(
                            height: 20.0,
                          ),
                          new Container(
                            child: ZCTextFormField(
                              hintText: "Email",
                              controller: _email_controller,
                              validator: (email) {
                                if (email.isEmpty) {
                                  return "Required";
                                } else if (!AppUtils.isValidEmail(email)) {
                                  return "Please enter a valid email address";
                                } else {
                                  return null;
                                }
                              },
                              textInputType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          new SizedBox(
                            height: 20.0,
                          ),
                          new Container(
                            child: ZCTextFormField(
                              hintText: "Password",
                              controller: _password_controller,
                              obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Required";
                                } else if (value.length < 6) {
                                  return "Please enter atleast 6 characters";
                                } else {
                                  return null;
                                }
                              },
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          new SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: _edgePadding, right: _edgePadding),
                            child: new ZCButton(
                              title: "CREATE",
                              onPressed: () => _signupTapped(),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new ZCText(
                                text: "Already have an account please",
                              ),
                              new FlatButton(
                                onPressed: () => _navigateToLogin(),
                                child: new ZCText(
                                  text: 'Sign in',
                                  underline: true,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    ));
  }

  _navigateToLogin() {
    Navigator.of(context).pop();
  }

  _signupTapped() {
    if (_formKey.currentState.validate()) {
      _signupData.firstname = _firstName_controller.text;
      _signupData.lastname = _lastName_controller.text;
      _signupData.email = _email_controller.text;
      _signupData.telephone = _phone_controller.text;
      _signupData.password = _password_controller.text;

      if (_validateFields()) {
        AppUtils.isConnectedToInternet(context).then((isConnected) {
          if (isConnected) {
            setState(() => _isLoading = true);
            APIService().signUpUser(_signupData).then((response) {
              setState(() => _isLoading = false);
              if (response.statusCode == 200) {
                Response _signupResponse = Response.fromJson(response.data);
                if (_signupResponse.success != 1) {
                  AlertUtils.showToast(_signupResponse.error, context);
                } else {
                  AlertUtils.showToast("Registration Successfull", context);
                }
              } else {
                AlertUtils.showToast("Registration Failed", context);
              }
            });
          }
        });
      }
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }

  bool _validateFields() {
    return true;
  }
}
