import 'package:flutter/material.dart';
import 'package:zaincart_app/models/address.dart';
import 'package:zaincart_app/models/addressListResponse.dart';
import 'package:zaincart_app/models/response.dart';
import 'package:zaincart_app/screen/account/add_address_screen.dart';
import 'package:zaincart_app/screen/change_password_screen.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/utils/preferences.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class MyAddressScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAddressScreenState();
  }
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  var name;
  var email;
  var phone;
  List<Address> addressList = new List<Address>();
  bool isLoading = false;

  @override
  void initState() {
    getUserInfo();
    getAddressList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ZCAppBarTitle("MY ADDRESS"),
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
        actions: <Widget>[
          Builder(
              builder: (BuildContext context) => IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AddAddressScreen()));
                    },
                  ))
        ],
      ),
      body: isLoading
          ? Center(child: new CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ZCText(
                        text: "Contact",
                      ),
                      ZCText(
                        text: "Edit",
                        color: Constants.zc_orange,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Divider(
                    thickness: 1.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: [
                      Image.asset(
                        Constants.ic_account,
                        height: 100.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ZCText(
                            text: name,
                          ),
                          ZCText(
                            text: email,
                          ),
                          ZCText(
                            text: phone,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ChangePasswordScreen()));
                              },
                              child: ZCText(
                                text: "Change Password",
                                color: Constants.zc_orange,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: addressList.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Container(
                          color:
                              index % 2 == 0 ? Colors.white : Colors.grey[200],
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ZCText(
                                    text: "Shipping Address",
                                    semiBold: true,
                                  ),
                                  Row(
                                    children: [
                                      addressList[index].defaultshipping == 1
                                          ? Container(
                                              height: 5.0,
                                              width: 20.0,
                                              color: Colors.greenAccent,
                                            )
                                          : new Container(),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      AddAddressScreen(
                                                        address:
                                                            addressList[index],
                                                      )));
                                        },
                                        child: ZCText(
                                          text: "Edit",
                                          color: Constants.zc_font_grey,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      InkWell(
                                        onTap: () => deleteAddress(
                                            addressList[index].addressId),
                                        child: ZCText(
                                          text: "Delete",
                                          color: Constants.zc_font_grey,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Divider(
                                thickness: 1.0,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              ZCText(
                                text: addressList[index].firstname +
                                    addressList[index].lastname,
                              ),
                              ZCText(
                                text: addressList[index].street,
                              ),
                              ZCText(
                                text: addressList[index].telephone,
                              ),
                              addressList[index].defaultshipping != 1
                                  ? Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () => defaultAddress(
                                            addressList[index].addressId),
                                        child: ZCText(
                                          text: "Make it default",
                                          color: Constants.zc_font_grey,
                                        ),
                                      ),
                                    )
                                  : new Container(),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
    );
  }

  void getUserInfo() async {
    name = await Preferences.get(PrefKey.firstName);
    email = await Preferences.get(PrefKey.email);
    phone = await Preferences.get(PrefKey.mobileNumber);
    setState(() {});
  }

  getAddressList() {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        setState(() {
          isLoading = true;
        });
        APIService().addressList().then((response) {
          setState(() {
            isLoading = false;
          });
          if (response.statusCode == 200) {
            AddressListResponse addressResponse =
                AddressListResponse.fromJson(response.data);
            if (addressResponse.success == 1) {
              setState(() {
                addressList = addressResponse.data.addressList;
              });
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

  deleteAddress(String addressId) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        setState(() {
          isLoading = true;
        });
        APIService().deleteAddress(addressId).then((response) {
          setState(() {
            isLoading = false;
          });
          if (response.statusCode == 200) {
            Response addressResponse = Response.fromJson(response.data);
            if (addressResponse.success == 1) {
              AlertUtils.showToast("Deleted successfully", context);
              getAddressList();
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

  defaultAddress(String addressId) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        setState(() {
          isLoading = true;
        });
        APIService().setDefaultAddress(addressId).then((response) {
          setState(() {
            isLoading = false;
          });
          if (response.statusCode == 200) {
            Response addressResponse = Response.fromJson(response.data);
            if (addressResponse.success == 1) {
              AlertUtils.showToast(
                  "Default address added successfully", context);
              getAddressList();
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
