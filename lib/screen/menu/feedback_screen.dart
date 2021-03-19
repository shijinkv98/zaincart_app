import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/profile_bloc.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_button.dart';
import 'package:zaincart_app/widgets/zc_text.dart';
import 'package:zaincart_app/widgets/zc_textformfield.dart';

class FeedbackScreen extends StatefulWidget {
  final double rating;
  final String productId;

  FeedbackScreen({this.rating, this.productId});
  @override
  State<StatefulWidget> createState() {
    return _FeedbackScreenState();
  }
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  bool isLoading = false;
  bool _autoValidate = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: ZCAppBarTitle("REVIEW"),
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
        inAsyncCall: isLoading,
        child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: _autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    ZCText(
                      text: "SUGGESTIONS AND FEEDBACK",
                      fontSize: kFontSize,
                      semiBold: true,
                    ),
                    SizedBox(height: 30.0),
                    ZCTextFormField(
                      hintText: "Name",
                      controller: _nameController,
                      emptyValidator: true,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ZCTextFormField(
                      hintText: "Email",
                      controller: _emailController,
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
                    SizedBox(
                      height: 10.0,
                    ),
                    ZCTextFormField(
                      hintText: "Phone",
                      controller: _phoneController,
                      textInputType: TextInputType.phone,
                      emptyValidator: true,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ZCTextFormField(
                      hintText: "What's on your mind",
                      controller: _descriptionController,
                      emptyValidator: true,
                      maxLines: null,
                    ),
                    SizedBox(height: 30.0),
                    ZCButton(
                      title: "SUBMIT",
                      onPressed: () => _onSubmitTap(),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  _onSubmitTap() {
    setState(() {
      _autoValidate = true;
    });
    if (_formKey.currentState.validate()) {
      Provider.of<ProfileBloc>(context, listen: false).contactUs(
          context: context,
          email: _emailController.text,
          name: _nameController.text,
          phone: _phoneController.text,
          message: _descriptionController.text);
    }
  }
}
