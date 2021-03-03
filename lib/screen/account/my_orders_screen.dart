import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/home_bloc.dart';
import 'package:zaincart_app/models/my_order_response.dart';
import 'package:zaincart_app/screen/account/cancel_order_screen.dart';
import 'package:zaincart_app/screen/account/myorder_detail_screen.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_account.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_menu.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class MyOrdersScreen extends StatefulWidget {
  final bool isEnableBack;
  MyOrdersScreen({this.isEnableBack = false});
  @override
  State<StatefulWidget> createState() {
    return _MyOrdersScreenState();
  }
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeBloc>(context, listen: false).getMyOrders(context);
    return Scaffold(
      drawer: ZCMenu(),
      endDrawer: ZCAccount(),
      appBar: AppBar(
        title: ZCAppBarTitle("MY ORDER"),
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
      body: Consumer<HomeBloc>(
          builder: (context, homeBloc, child) => ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: homeBloc.myOrderList.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return orderWidget(homeBloc.myOrderList[index], index);
              })),
    );
  }

  orderWidget(OrderDetail orderDetail, int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => CancelOrderScreen(
                  orderId: orderDetail.orderId,
                )));
      },
      child: new Container(
        color: index % 2 == 0 ? Colors.white : Colors.grey[100],
        padding: EdgeInsets.only(left: 20.0, right: 16.0, bottom: 10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0, top: 10.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: ZCText(
                  text: "#${(index + 1).toString()}",
                  color: Constants.zc_font_light_grey,
                  bold: true,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ZCText(
                      text: "OrderId",
                      fontSize: kSmallFontSize,
                    ),
                    ZCText(
                      text: orderDetail.orderId,
                      semiBold: true,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ZCText(
                      text: "Quantity",
                      fontSize: kSmallFontSize,
                    ),
                    Row(
                      children: [
                        ZCText(
                          text: "${orderDetail.quantity}",
                          semiBold: true,
                        ),
                        ZCText(
                          text: " items",
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    ZCText(
                      text: "Status",
                      fontSize: kSmallFontSize,
                    ),
                    ZCText(
                      text: orderDetail.status,
                      semiBold: true,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ZCText(
                      text: "Total Amount",
                      fontSize: kSmallFontSize,
                    ),
                    ZCText(
                      text: "${orderDetail.totalAmount}",
                      semiBold: true,
                    ),
                  ],
                ),
                Container(
                  width: 40.0,
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Divider(
              thickness: 1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ZCText(
                  text: "Order Date: ${orderDetail.orderDate}",
                  fontSize: kSmallFontSize,
                ),
                InkWell(
                  child: ZCText(
                    text: "View Details",
                    color: Constants.zc_orange,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MyOrderDetialScreen(
                              orderId: orderDetail.orderId,
                            )));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
