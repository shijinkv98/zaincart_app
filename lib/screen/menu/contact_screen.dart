import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:zaincart_app/models/about_us_response.dart';
import 'package:zaincart_app/models/contact_details_response.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_account.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_menu.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class ContactDetailScreen extends StatefulWidget {
  @override
  ContactDetailScreenState createState() => ContactDetailScreenState();
}

class ContactDetailScreenState extends State<ContactDetailScreen> {
  var details = ValueNotifier(Details());

  @override
  void initState() {
    getContactUs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double divHeight = MediaQuery.of(context).size.height;
    final double divWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: ZCMenu(),
        endDrawer: ZCAccount(),
        appBar: AppBar(
          title: ZCAppBarTitle("CONTACT US"),
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
                      icon: Image.asset(Constants.ic_account),
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                    ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ValueListenableBuilder(
              valueListenable: details,
              builder: (context, detail, child) => SingleChildScrollView(
                    child: detail == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ZCText(
                                  text: details.value.address,
                                  fontSize: kFieldFontSize),
                              SizedBox(
                                height: 30.0,
                              ),
                              Row(
                                children: [
                                  ZCText(
                                      text: details.value.phone,
                                      fontSize: kFieldFontSize),
                                  ZCText(
                                    text: ", ",
                                  ),
                                  ZCText(
                                      text: details.value.mobile,
                                      fontSize: kFieldFontSize),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              ZCText(
                                text: details.value.mail,
                                fontSize: kFieldFontSize,
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              ZCText(
                                text: "Hours of Operation",
                                semiBold: true,
                                fontSize: kFieldFontSize,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              ZCText(
                                  text: details.value.workingtime,
                                  fontSize: kFieldFontSize),
                            ],
                          ),
                  )),
        ));
  }

  getContactUs() {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        APIService().getContactDetails().then((response) {
          if (response.statusCode == 200) {
            ContactDetailsResponse contactUsResponse =
                ContactDetailsResponse.fromJson(response.data);
            if (contactUsResponse.success == 1) {
              details.value = contactUsResponse.contactDetail.details;
            } else if (contactUsResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(contactUsResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Failed", context);
          }
        });
      }
    });
  }
}
