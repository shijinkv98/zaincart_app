import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  AboutUsScreenState createState() => AboutUsScreenState();
}

class AboutUsScreenState extends State<AboutUsScreen> {
  double _edgePadding = 45.0;

  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _otpController = new TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final double divHeight = MediaQuery.of(context).size.height;
    final double divWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: _isLoading,
          child: Container(),
        ));
  }
}
