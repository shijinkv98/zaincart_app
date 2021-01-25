import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/home_bloc.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_product_item.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class MyCartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyCartScreenState();
  }
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ZCText(text:"MY CART", fontSize: 23.0, color: Constants.zc_orange_dark, semiBold: true,),
        backgroundColor: Colors.white,
        leading: Builder(
            builder: (BuildContext context) => Padding(
                  padding: EdgeInsets.only(left: 0.0),
                  child: IconButton(
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
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ))
        ],
      ),
      body: Consumer<HomeBloc>(
          builder: (context, homeBloc, child) =>ModalProgressHUD(
            inAsyncCall: homeBloc.isLoading,
                      child: GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 14,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext ctxt, int index) {
              return ZCProductItem(product: homeBloc.homeData.newProduct[index],);
            }),
          )),
    );
  }
}
