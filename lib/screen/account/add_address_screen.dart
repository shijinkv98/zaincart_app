import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:zaincart_app/models/address.dart';
import 'package:zaincart_app/models/response.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/utils/preferences.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_button.dart';
import 'package:zaincart_app/widgets/zc_textformfield.dart';

class AddAddressScreen extends StatefulWidget {
  final Address address;
  AddAddressScreen({this.address});
  @override
  State<StatefulWidget> createState() {
    return _AddAddressScreenState();
  }
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController _firstnameController = new TextEditingController();
  TextEditingController _lastnameController = new TextEditingController();
  TextEditingController _postcodeController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();
  TextEditingController _streetController = new TextEditingController();
  TextEditingController _telephoneController = new TextEditingController();
  TextEditingController _countryController = new TextEditingController();
  TextEditingController _stateController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Address _address = new Address();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.address != null) {
      _firstnameController.text = widget.address.firstname;
      _lastnameController.text = widget.address.lastname;
      _postcodeController.text = widget.address.postcode;
      _cityController.text = widget.address.city;
      _streetController.text = widget.address.street;
      _telephoneController.text = widget.address.telephone;
      _countryController.text = widget.address.countryId;
      _stateController.text = widget.address.state;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ZCAppBarTitle(widget.address != null ? "UPDATE" : "ADD ADDRESS"),
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
                    controller: _postcodeController,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    emptyValidator: true,
                    emptyValidatorMsg: "Should not be empty",
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ZCTextFormField(
                    hintText: "City",
                    controller: _cityController,
                    textInputAction: TextInputAction.next,
                    emptyValidator: true,
                    emptyValidatorMsg: "Should not be empty",
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ZCTextFormField(
                    hintText: "Street",
                    controller: _streetController,
                    textInputAction: TextInputAction.next,
                    emptyValidator: true,
                    emptyValidatorMsg: "Should not be empty",
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ZCTextFormField(
                    hintText: "Telephone",
                    controller: _telephoneController,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.phone,
                    emptyValidator: true,
                    emptyValidatorMsg: "Should not be empty",
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ZCTextFormField(
                    hintText: "Country Code",
                    controller: _countryController,
                    textInputAction: TextInputAction.next,
                    emptyValidator: true,
                    emptyValidatorMsg: "Should not be empty",
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ZCTextFormField(
                    hintText: "State",
                    controller: _stateController,
                    textInputAction: TextInputAction.next,
                    emptyValidator: true,
                    emptyValidatorMsg: "Should not be empty",
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: new ZCButton(
                      title: widget.address != null
                          ? "Update Address"
                          : "Add Address",
                      onPressed: () => addTapped(),
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

  addTapped() async {
    if (_formKey.currentState.validate()) {
      _address.addressId =
          widget.address != null ? widget.address.addressId : "";
      _address.firstname = _firstnameController.text;
      _address.lastname = _lastnameController.text;
      _address.postcode = _postcodeController.text;
      _address.city = _cityController.text;
      _address.street = _streetController.text;
      _address.telephone = _telephoneController.text;
      _address.countryId = _countryController.text;
      _address.countryid = _countryController.text;
      _address.state = _stateController.text;
      _address.customerId = await Preferences.get(PrefKey.id);
      _address.customertoken = await Preferences.get(PrefKey.token);
      _address.defaultbilling = 1;
      _address.defaultshipping = 1;
      _address.saveinaddressbook = "1";
      widget.address != null ? updateAddress() : addAddress();
    }
  }

  addAddress() {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        setState(() {
          isLoading = true;
        });
        APIService().addAddress(_address).then((response) {
          setState(() {
            isLoading = false;
          });
          if (response.statusCode == 200) {
            Response addressResponse = Response.fromJson(response.data);
            if (addressResponse.success == 1) {
              AlertUtils.showToast("Address successfully added", context);
              Navigator.of(context).pop();
            } else if (addressResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(addressResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Failed", context);
          }
        });
      }
    });
  }

  updateAddress() {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        setState(() {
          isLoading = true;
        });
        APIService().addressUpdate(_address).then((response) {
          setState(() {
            isLoading = false;
          });
          if (response.statusCode == 200) {
            Response addressResponse = Response.fromJson(response.data);
            if (addressResponse.success == 1) {
              AlertUtils.showToast("Address successfully updated", context);
              Navigator.of(context).pop();
            } else if (addressResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(addressResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Failed", context);
          }
        });
      }
    });
  }
}
