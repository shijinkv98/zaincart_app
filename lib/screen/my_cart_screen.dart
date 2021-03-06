import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/mycart_bloc.dart';
import 'package:zaincart_app/screen/choose_address_screen.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_account.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_menu.dart';
import 'package:zaincart_app/widgets/zc_mycart_item.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class MyCartScreen extends StatefulWidget {
  final bool enableBack;

  MyCartScreen({this.enableBack = false});
  @override
  State<StatefulWidget> createState() {
    return _MyCartScreenState();
  }
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<MyCartBloc>(context, listen: false).getMyCartList(context);
    return Scaffold(
      drawer: ZCMenu(),
      endDrawer: ZCAccount(),
      appBar: AppBar(
        title: ZCAppBarTitle("MY CART"),
        backgroundColor: Colors.white,
        leading: Builder(
            builder: (BuildContext context) => Padding(
                  padding: EdgeInsets.only(left: 0.0),
                  child: widget.enableBack
                      ? IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Constants.zc_font_black,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Constants.zc_font_black,
                          ),
                          onPressed: () => Scaffold.of(context).openDrawer(),
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
      body: Consumer<MyCartBloc>(
          builder: (context, cartBloc, child) => ModalProgressHUD(
                inAsyncCall: cartBloc.isLoading,
                child: Column(
                  children: [
                    Expanded(
                      child: cartBloc.cartResponse != null
                          ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  cartBloc.cartResponse.data.product.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return ZCMyCartItem(
                                  cartProduct:
                                      cartBloc.cartResponse.data.product[index],
                                  cartId: cartBloc.cartResponse.cartInfo.cartId,
                                );
                              })
                          : new Container(),
                    ),
                    cartBloc.cartResponse != null
                        ? new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: new Container(
                                  height: 40.0,
                                  color: Constants.zc_yellow,
                                  child: Center(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ZCText(
                                        text: "Total",
                                        color: Constants.zc_orange_dark,
                                        fontSize: 11.0,
                                      ),
                                      ZCText(
                                        text: cartBloc.cartResponse.cartInfo
                                            .cartTotalAmount,
                                        semiBold: true,
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ChooseAddressScreen()));
                                  },
                                  child: new Container(
                                    height: 40.0,
                                    color: Constants.zc_orange_dark,
                                    child: Center(
                                        child: ZCText(
                                      text: "Place Order",
                                      semiBold: true,
                                      color: Colors.white,
                                    )),
                                  ),
                                ),
                              )
                            ],
                          )
                        : new Container()
                  ],
                ),
              )),
    );
  }
}
