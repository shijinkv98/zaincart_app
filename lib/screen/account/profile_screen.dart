import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/profile_bloc.dart';
import 'package:zaincart_app/models/address.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/utils/preferences.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_button.dart';
import 'package:zaincart_app/widgets/zc_textformfield.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _firstnameController = new TextEditingController();
  TextEditingController _lastnameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Address _address = new Address();
  bool isLoading = false;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ZCAppBarTitle("UPDATE PROFILE"),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  ZCTextFormField(
                    hintText: "Firstname",
                    controller: _firstnameController,
                    textInputAction: TextInputAction.next,
                    emptyValidator: true,
                    emptyValidatorMsg: "Should not be empty",
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ZCTextFormField(
                    hintText: "Lastname",
                    controller: _lastnameController,
                    textInputAction: TextInputAction.next,
                    emptyValidator: true,
                    emptyValidatorMsg: "Should not be empty",
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ZCTextFormField(
                    hintText: "Postcode",
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    emptyValidator: true,
                    emptyValidatorMsg: "Should not be empty",
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: new ZCButton(
                      title: "Update Profile",
                      onPressed: () => updateTapped(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  updateTapped(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      Provider.of<ProfileBloc>(context, listen: false).updateProfile(
          context: context,
          email: _emailController.text,
          firstName: _firstnameController.text,
          lastName: _lastnameController.text);
    }
  }

  getUser() async {
    _firstnameController.text = await Preferences.get(PrefKey.firstName);
    _lastnameController.text = await Preferences.get(PrefKey.lastName);
    _emailController.text = await Preferences.get(PrefKey.email);
  }
}
