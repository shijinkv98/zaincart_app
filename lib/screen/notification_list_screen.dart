import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/profile_bloc.dart';
import 'package:zaincart_app/models/contact_details_response.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_account.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_menu.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class NotificationListScreen extends StatefulWidget {
  @override
  NotificationListScreenState createState() => NotificationListScreenState();
}

class NotificationListScreenState extends State<NotificationListScreen> {
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
    Provider.of<ProfileBloc>(context, listen: false)
        .getNotificationList(context);
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: ZCMenu(),
        endDrawer: ZCAccount(),
        appBar: AppBar(
          title: ZCAppBarTitle("NOTIFICATIONS"),
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
        body: Consumer<ProfileBloc>(
            builder: (context, profileBloc, child) => Padding(
                  padding: EdgeInsets.all(0.0),
                  child: ListView.builder(
                      itemCount: profileBloc.notificationList.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Container(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    profileBloc.notificationList[index].image,
                                    height: 80.0,
                                    width: 80.0,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ZCText(
                                        text: profileBloc
                                            .notificationList[index].title,
                                        semiBold: true,
                                        maxLines: 2,
                                        fontSize: kFontSize,
                                      ),
                                      HtmlWidget(
                                        profileBloc.notificationList[index].content,
                                        textStyle: TextStyle(
                                            fontSize: kFontSize,
                                            color: Constants.zc_font_grey),
                                        webView: true,
                                      ), 
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 90.0),
                                child: ZCText(
                                      text: profileBloc
                                          .notificationList[index].createdAt,
                                      color: Constants.zc_font_grey,
                                      fontSize: 10.0,
                                    ),
                              )
                            ],
                          ),
                        );
                      }),
                )));
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
