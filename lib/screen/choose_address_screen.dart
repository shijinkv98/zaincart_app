import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/profile_bloc.dart';
import 'package:zaincart_app/screen/account/add_address_screen.dart';
import 'package:zaincart_app/screen/place_order_screen.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_button.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class ChooseAddressScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChooseAddressScreenState();
  }
}

class _ChooseAddressScreenState extends State<ChooseAddressScreen> {
  var _shippingMethod = ValueNotifier("");
  var _paymentMethod = ValueNotifier("");

  @override
  void initState() {
    Provider.of<ProfileBloc>(context, listen: false).getCountries(context);
    Provider.of<ProfileBloc>(context, listen: false)
        .getCheckoutDetails(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileBloc>(context, listen: false).getAddressList(context);
    return Scaffold(
        appBar: AppBar(
          title: ZCAppBarTitle("CHOOSE ADDRESS"),
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
        body: Consumer<ProfileBloc>(
          builder: (context, profileBloc, child) => profileBloc.isLoading
              ? Center(child: new CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ZCText(
                          text: "Select a Billing Address",
                          bold: true,
                        ),
                        Column(
                          children: profileBloc.addressList
                              .map((address) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Constants.zc_orange)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: address.defaultshipping == 1
                                                ? Container(
                                                    height: 30.0,
                                                    width: 30.0,
                                                    color: Constants.zc_orange,
                                                    child: Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                : new Container(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ZCText(
                                                  color: Constants.zc_font_grey,
                                                  text: address.firstname +
                                                      " " +
                                                      address.lastname,
                                                ),
                                                ZCText(
                                                  color: Constants.zc_font_grey,
                                                  text: address.city +
                                                      ", " +
                                                      address.street,
                                                ),
                                                ZCText(
                                                  color: Constants.zc_font_grey,
                                                  text: address.state +
                                                      ", " +
                                                      profileBloc.countryList
                                                          .where((element) =>
                                                              element
                                                                  .countryCode ==
                                                              address.countryid)
                                                          .first
                                                          .countryName +
                                                      ", " +
                                                      address.postcode,
                                                ),
                                                ZCText(
                                                  color: Constants.zc_font_grey,
                                                  text: address.telephone,
                                                ),
                                                SizedBox(
                                                  height: 20.0,
                                                ),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    AddAddressScreen(
                                                                      address:
                                                                          address,
                                                                    )));
                                                      },
                                                      child: ZCText(
                                                        text:
                                                            "Edit This Address",
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    address.defaultshipping != 1
                                                        ? Row(
                                                            children: [
                                                              Container(
                                                                height: 15.0,
                                                                width: 1.0,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              SizedBox(
                                                                width: 5.0,
                                                              ),
                                                              Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: InkWell(
                                                                  onTap: () => profileBloc
                                                                      .defaultAddress(
                                                                          context,
                                                                          address
                                                                              .addressId),
                                                                  child: ZCText(
                                                                    text:
                                                                        "Set as Default",
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : new Container(),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                        FlatButton(
                          child: ZCText(
                            text: "+ADD NEW ADDRESS",
                            color: Constants.zc_orange,
                            semiBold: true,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    AddAddressScreen()));
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ZCText(
                              text: "Payment methods",
                              bold: true,
                            ),
                            ValueListenableBuilder(
                                valueListenable: _paymentMethod,
                                builder: (context, _radio, child) => Column(
                                      children: profileBloc
                                          .checkoutData.paymentMethod
                                          .map(
                                            (paymentMethod) => Row(
                                              children: [
                                                new Radio(
                                                  value: paymentMethod.value,
                                                  groupValue: _radio,
                                                  onChanged: (val) {
                                                    print(val);
                                                    _paymentMethod.value = val;
                                                  },
                                                ),
                                                new Text(
                                                  "${paymentMethod.label}",
                                                  style: new TextStyle(
                                                      fontSize: 16.0),
                                                ),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    ))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ZCText(
                              text: "Shipping methods",
                              bold: true,
                            ),
                            ValueListenableBuilder(
                                valueListenable: _shippingMethod,
                                builder: (context, _radio, child) => Column(
                                      children: profileBloc
                                          .checkoutData.shippingMethod
                                          .map(
                                            (shippingMethod) => Row(
                                              children: [
                                                new Radio(
                                                  value: shippingMethod.value,
                                                  groupValue: _radio,
                                                  onChanged: (val) {
                                                    print(val);
                                                    _shippingMethod.value = val;
                                                  },
                                                ),
                                                new Text(
                                                  "${shippingMethod.label} - ${shippingMethod.price}",
                                                  style: new TextStyle(
                                                      fontSize: 16.0),
                                                ),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    ))
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ZCButton(
                          title: "NEXT",
                          onPressed: () {
                            if (_paymentMethod.value.isEmpty) {
                              AlertUtils.showToast("Select Payment Method", context);
                            } else if (_shippingMethod.value.isEmpty) {
                              AlertUtils.showToast("Select Shipping Method", context);
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PlaceOrderScreen(
                                        paymentMethod: _paymentMethod.value,
                                        shippingMethod: _shippingMethod.value,
                                      )));
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
        ));
  }
}
