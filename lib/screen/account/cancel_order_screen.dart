import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/home_bloc.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_button.dart';
import 'package:zaincart_app/widgets/zc_text.dart';
import 'package:zaincart_app/widgets/zc_textformfield.dart';

class CancelOrderScreen extends StatefulWidget {
  final String orderId;

  CancelOrderScreen({this.orderId});
  @override
  State<StatefulWidget> createState() {
    return _CancelOrderScreenState();
  }
}

class _CancelOrderScreenState extends State<CancelOrderScreen> {
  bool isLoading = false;
  TextEditingController _reasonController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ZCAppBarTitle("CANCEL ORDER"),
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
        child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                ZCText(
                  text: "Are you sure to cancel selected order?",
                  maxLines: 3,
                  fontSize: kHeadingFontSize,
                  semiBold: true,
                ),
                SizedBox(height: 30.0),
                ZCText(
                  text: "Order #${widget.orderId}",
                  fontSize: kHeadingFontSize,
                  semiBold: true,
                ),
                SizedBox(height: 40.0),
                ZCTextFormField(
                  hintText: "Any cancellation reason?",
                  controller: _reasonController,
                ),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: ZCButton(
                      title: "CANCEL",
                      onPressed: () {
                        Provider.of<HomeBloc>(context, listen: false)
                            .cancelOrder(context, widget.orderId);
                      },
                    )),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                        child: ZCButton(
                      title: "BACK",
                      color: Colors.white,
                      border: true,
                      titleColor: Constants.zc_font_grey,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
