import 'package:flutter/material.dart';
import 'package:zaincart_app/models/my_order_response.dart';
import 'package:zaincart_app/models/myorder_detail_response.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_account.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_menu.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class MyOrderDetialScreen extends StatefulWidget {
  final String orderId;
  MyOrderDetialScreen({this.orderId});
  @override
  State<StatefulWidget> createState() {
    return _MyOrderDetialScreenState();
  }
}

class _MyOrderDetialScreenState extends State<MyOrderDetialScreen> {
  bool isLoading = false;
  var orderDetail = ValueNotifier(MyOrderDetail());

  @override
  void initState() {
    getMyOrderDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        body: isLoading
            ? new Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                child: new Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ZCText(
                        text: "Order Id: ${widget.orderId} ",
                      ),
                    ),
                    Container(
                      height: 30.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ZCText(
                            text: "Product Name",
                          ),
                          ZCText(
                            text: "SKU",
                          ),
                          ZCText(
                            text: "Quantity",
                          ),
                          ZCText(
                            text: "Price",
                          ),
                          ZCText(
                            text: "SubTotal",
                          )
                        ],
                      ),
                    ),
                    orderDetail.value.products != null
                        ? ValueListenableBuilder(
                            valueListenable: orderDetail,
                            builder: (context, detail, child) => Expanded(
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: detail.products.length + 1,
                                      itemBuilder:
                                          (BuildContext ctxt, int index) {
                                        if (index ==
                                            orderDetail.value.products.length) {
                                          return bottomWidget();
                                        } else {
                                          return orderWidget(
                                              detail.products[index], index);
                                        }
                                      }),
                                ))
                        : new Container(),
                  ],
                ),
              ));
  }

  Widget orderWidget(OrderProduct product, int index) {
    return Container(
      color: index % 2 == 0 ? Colors.grey[100] : Colors.white,
      padding: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 80,
            child: ZCText(
              text: product.name,
              maxLines: 5,
            ),
          ),
          Container(
            width: 80.0,
            child: ZCText(
              text: product.sku,
              maxLines: 5,
            ),
          ),
          Container(
            width: 50.0,
            child: ZCText(
              text: product.qty.toString(),
            ),
          ),
          ZCText(
            text: product.price.toString(),
          ),
          ZCText(
            text: "${product.price * product.qty}",
          )
        ],
      ),
    );
  }

  bottomWidget() {
    return Column(
      
      children: [
        Container(
          color: Constants.zc_yellow,
          padding: EdgeInsets.all(10.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new Container(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ZCText(text: "SubTotal:"),
                  SizedBox(
                    height: 5.0,
                  ),
                  ZCText(text: "Shipping and Handling:"),
                  SizedBox(
                    height: 5.0,
                  ),
                  ZCText(
                    text: "GrandTotal:",
                    semiBold: true,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ZCText(text: orderDetail.value.subTotal),
                  SizedBox(
                    height: 5.0,
                  ),
                  ZCText(text: orderDetail.value.shippingPrice),
                  SizedBox(
                    height: 5.0,
                  ),
                  ZCText(
                    text: orderDetail.value.totalAmount,
                    semiBold: true,
                  )
                ],
              )
            ],
          ),
        ),
        new Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.grey[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ZCText(
                text: "Shipping Address",
                semiBold: true,
              ),
              Divider(thickness: 1.0,),
              ZCText(
                text: orderDetail.value.shippingAddress.name,
              ),
              ZCText(
                text: "${orderDetail.value.shippingAddress.city}, ${orderDetail.value.shippingAddress.street.first}",
              ),
              ZCText(
                text: "${orderDetail.value.shippingAddress.country}, ${orderDetail.value.shippingAddress.postcode}",
              ),
              ZCText(
                text: "${orderDetail.value.shippingAddress.country}, T: ${orderDetail.value.shippingAddress.telephone}",
              ),
            ],
          ),
        ),
        new Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ZCText(
                text: "Billing Address",
                semiBold: true,
              ),
              Divider(thickness: 1.0,),
              ZCText(
                text: orderDetail.value.shippingAddress.name,
              ),
              ZCText(
                text: "${orderDetail.value.billingAddress.city}, ${orderDetail.value.billingAddress.street.first}",
              ),
              ZCText(
                text: "${orderDetail.value.billingAddress.country}, ${orderDetail.value.billingAddress.postcode}",
              ),
              ZCText(
                text: "${orderDetail.value.billingAddress.country}, T: ${orderDetail.value.billingAddress.telephone}",
              ),
            ],
          ),
        ),
        new Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.grey[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ZCText(
                text: "Payment Method",
                semiBold: true,
              ),
              Divider(thickness: 1.0,),
              ZCText(
                text: orderDetail.value.paymentMethod,
              ),
            ],
          ),
        ),
        new Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ZCText(
                text: "Shipping Method",
                semiBold: true,
              ),
              Divider(thickness: 1.0,),
              ZCText(
                text: orderDetail.value.shippingMethod,
              ),
            ],
          ),
        )
      ],
    );
  }

  getMyOrderDetail() {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        setState(() {
          isLoading = true;
        });
        APIService().getOrderDetail(widget.orderId).then((response) {
          setState(() {
            isLoading = false;
          });
          if (response.statusCode == 200) {
            MyOrderDetailResponse orderDetailResponse =
                MyOrderDetailResponse.fromJson(response.data);
            if (orderDetailResponse.success == 1) {
              orderDetail.value = orderDetailResponse.orderDetail;
            } else if (orderDetailResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(orderDetailResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Failed", context);
          }
        });
      }
    });
  }
}
