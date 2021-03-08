import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/profile_bloc.dart';
import 'package:zaincart_app/screen/account/add_address_screen.dart';
import 'package:zaincart_app/screen/account/profile_screen.dart';
import 'package:zaincart_app/screen/change_password_screen.dart';
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
  @override
  void initState() {
    Provider.of<ProfileBloc>(context, listen: false).getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileBloc>(context, listen: false).getAddressList(context);
    Provider.of<ProfileBloc>(context, listen: false).getCountries(context);
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
        body: Consumer<ProfileBloc>(
          builder: (context, profileBloc, child) => profileBloc.isLoading
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
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ProfileScreen()));
                            },
                            child: ZCText(
                              text: "Edit",
                              color: Constants.zc_orange,
                            ),
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
                                text:
                                    "${profileBloc.firstName} ${profileBloc.lastName}",
                              ),
                              ZCText(
                                text: profileBloc.email,
                              ),
                              ZCText(
                                text: profileBloc.phone,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
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
                          itemCount: profileBloc.addressList.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Container(
                              color: index % 2 == 0
                                  ? Colors.white
                                  : Colors.grey[200],
                              padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  top: 20.0,
                                  bottom: 20.0),
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
                                          profileBloc.addressList[index]
                                                      .defaultshipping ==
                                                  1
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
                                                            address: profileBloc
                                                                    .addressList[
                                                                index],
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
                                            onTap: () =>
                                                profileBloc.deleteAddress(
                                                    context,
                                                    profileBloc
                                                        .addressList[index]
                                                        .addressId),
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
                                    text: profileBloc
                                            .addressList[index].firstname +
                                        " " +
                                        profileBloc.addressList[index].lastname,
                                  ),
                                  ZCText(
                                    text: profileBloc.addressList[index].city +
                                        ", " +
                                        profileBloc.addressList[index].street,
                                  ),
                                  ZCText(
                                    text: profileBloc.addressList[index].state +
                                        ", " +
                                        profileBloc.countryList
                                            .where((element) =>
                                                element.countryCode ==
                                                profileBloc.addressList[index]
                                                    .countryid)
                                            .first
                                            .countryName +
                                        ", " +
                                        profileBloc.addressList[index].postcode,
                                  ),
                                  ZCText(
                                    text: profileBloc
                                        .addressList[index].telephone,
                                  ),
                                  profileBloc.addressList[index]
                                              .defaultshipping !=
                                          1
                                      ? Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () =>
                                                profileBloc.defaultAddress(
                                                    context,
                                                    profileBloc
                                                        .addressList[index]
                                                        .addressId),
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
        ));
  }
}
