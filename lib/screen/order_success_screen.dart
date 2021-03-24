import 'package:flutter/material.dart';
import 'package:zaincart_app/screen/account/myorder_detail_screen.dart';
import 'package:zaincart_app/screen/home.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_button.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class OrderSuccessScreen extends StatelessWidget {
  final String orderId;
  OrderSuccessScreen(this.orderId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Container(
                height: 70.0,
                width: 70.0,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 30.0,
                ),
                decoration: BoxDecoration(
                    color: Constants.zc_orange,
                    borderRadius: BorderRadius.all(Radius.circular(70))),
              ),
              SizedBox(
                height: 40.0,
              ),
              ZCText(text: "Your order number is"),
              SizedBox(
                height: 10.0,
              ),
              ZCText(
                text: orderId,
                semiBold: true,
              ),
              SizedBox(
                height: 20.0,
              ),
              ZCText(
                text:
                    "We'll email you an order confirmation with details and tracking info",
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.0,
              ),
              InkWell(
                child: ZCText(
                  text: "View Order Details",
                  color: Colors.blue,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyOrderDetialScreen(
                            orderId: orderId,
                          )));
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              ZCButton(
                title: "CONTINUE SHOPPING",
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => Home()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
