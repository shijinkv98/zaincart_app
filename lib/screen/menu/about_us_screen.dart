import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_account.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_menu.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  AboutUsScreenState createState() => AboutUsScreenState();
}

class AboutUsScreenState extends State<AboutUsScreen> {
  var aboutUsContent = ValueNotifier("");

  @override
  void initState() {
    getAboutUs();
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
          title: ZCAppBarTitle("ABOUT"),
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
                    child: content.isNotEmpty
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : HtmlWidget(
                            content,
                            customStylesBuilder: (element) {
                              if (element.classes.contains('foo')) {
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

  getAboutUs() {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        APIService().getAboutUs().then((response) {
          if (response.statusCode == 200) {
            aboutUsContent.value = response.data;
          } else {
            AlertUtils.showToast("Failed", context);
          }
        });
      }
    });
  }
}
