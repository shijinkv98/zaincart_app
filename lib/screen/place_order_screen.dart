import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/mycart_bloc.dart';
import 'package:zaincart_app/blocs/profile_bloc.dart';
import 'package:zaincart_app/screen/account/add_address_screen.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_button.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class PlaceOrderScreen extends StatefulWidget {
  final String shippingMethod;
  final String paymentMethod;
  PlaceOrderScreen({this.shippingMethod, this.paymentMethod});
  @override
  State<StatefulWidget> createState() {
    return _PlaceOrderScreenState();
  }
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  var check = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
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
              : Consumer<MyCartBloc>(
                  builder: (context, cartBloc, child) => ModalProgressHUD(
                        inAsyncCall: cartBloc.isLoading,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ZCText(
                                  text: "Select Shipping Address",
                                  bold: true,
                                ),
                                Row(
                                  children: [
                                    ValueListenableBuilder(
                                        valueListenable: check,
                                        builder: (context, ch, child) =>
                                            Checkbox(
                                              value: ch,
                                              onChanged: (val) {
                                                check.value = val;
                                              },
                                              checkColor: Colors.grey[200],
                                              activeColor: Colors.grey,
                                            )),
                                    ZCText(
                                      text:
                                          "My Billing and Shipping Address are same",
                                      fontSize: kSmallFontSize,
                                    )
                                  ],
                                ),
                                Column(
                                  children: profileBloc.addressList
                                      .map((address) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Constants.zc_orange)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child:
                                                        address.defaultshipping ==
                                                                1
                                                            ? Container(
                                                                height: 30.0,
                                                                width: 30.0,
                                                                color: Constants
                                                                    .zc_orange,
                                                                child: Icon(
                                                                  Icons.check,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )
                                                            : new Container(),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ZCText(
                                                          color: Constants
                                                              .zc_font_grey,
                                                          text: address
                                                                  .firstname +
                                                              " " +
                                                              address.lastname,
                                                        ),
                                                        ZCText(
                                                          color: Constants
                                                              .zc_font_grey,
                                                          text: address.city +
                                                              ", " +
                                                              address.street,
                                                        ),
                                                        ZCText(
                                                          color: Constants
                                                              .zc_font_grey,
                                                          text: address.state +
                                                              ", " +
                                                              profileBloc
                                                                  .countryList
                                                                  .where((element) =>
                                                                      element
                                                                          .countryCode ==
                                                                      address
                                                                          .countryid)
                                                                  .first
                                                                  .countryName +
                                                              ", " +
                                                              address.postcode,
                                                        ),
                                                        ZCText(
                                                          color: Constants
                                                              .zc_font_grey,
                                                          text:
                                                              address.telephone,
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
                                                                              address: address,
                                                                            )));
                                                              },
                                                              child: ZCText(
                                                                text:
                                                                    "Edit This Address",
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5.0,
                                                            ),
                                                            address.defaultshipping !=
                                                                    1
                                                                ? Row(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            15.0,
                                                                        width:
                                                                            1.0,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5.0,
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        child:
                                                                            InkWell(
                                                                          onTap: () => profileBloc.defaultAddress(
                                                                              context,
                                                                              address.addressId),
                                                                          child:
                                                                              ZCText(
                                                                            text:
                                                                                "Set as Default",
                                                                            color:
                                                                                Colors.black,
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
                                SizedBox(
                                  height: 20.0,
                                ),
                                ZCButton(
                                  title: "PLACE ORDER",
                                  onPressed: () {
                                    cartBloc.placeOrder(
                                        context: context,
                                        paymentMethod: widget.paymentMethod,
                                        shippingMethod: widget.shippingMethod);
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
        ));
  }
}
