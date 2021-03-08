import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:zaincart_app/models/about_us_response.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_account.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_menu.dart';

class PolicyScreen extends StatefulWidget {
  @override
  PolicyScreenState createState() => PolicyScreenState();
}

class PolicyScreenState extends State<PolicyScreen> {
  var aboutUsContent = ValueNotifier("");

  @override
  void initState() {
    getpolicy();
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
          title: ZCAppBarTitle("POLICIES"),
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
              valueListenable: aboutUsContent,
              builder: (context, content, child) => SingleChildScrollView(
                    child: content.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : HtmlWidget(
                            content,
                            customStylesBuilder: (element) {
                              if (element.classes.contains('w')) {
                                return {'color': 'red'};
                              }
                              return null;
                            },
                            textStyle: TextStyle(fontSize: 14),
                            webView: true,
                          ),
                  )),
        ));
  }

  getpolicy() {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        APIService().getPloicy().then((response) {
          if (response.statusCode == 200) {
            AboutUsResponse aboutUsResponse =
                AboutUsResponse.fromJson(response.data);
            if (aboutUsResponse.success == 0) {
              aboutUsContent.value = aboutUsResponse.data.details;
            } else if (aboutUsResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(aboutUsResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Failed", context);
          }
        });
      }
    });
  }
}
