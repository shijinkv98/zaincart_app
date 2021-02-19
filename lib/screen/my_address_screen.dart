import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:zaincart_app/models/address.dart';
import 'package:zaincart_app/models/addressListResponse.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/utils/preferences.dart';
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
        title: ZCText(
          text: "MY ADDRESS",
          fontSize: 23.0,
          color: Constants.zc_orange_dark,
          semiBold: true,
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
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
            Divider(
              thickness: 1.0,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 100.0,
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
                  ],
                )
              ],
            ),
            Divider(
              thickness: 1.0,
            ),
            Expanded(
                        child: ListView.builder(
                  itemCount: addressList.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ZCText(
                              text: "Shipping Address",
                              semiBold: true,
                            ),
                            ZCText(
                              text: "Edit",
                              color: Constants.zc_orange,
                            )
                          ],
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
                        Divider(
                          thickness: 1.0,
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
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
}
