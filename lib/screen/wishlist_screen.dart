import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/home_bloc.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_account.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_menu.dart';
import 'package:zaincart_app/widgets/zc_product_item.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class WishlistScreen extends StatefulWidget {
  final bool isEnableBack;
  WishlistScreen({this.isEnableBack = false});
  @override
  State<StatefulWidget> createState() {
    return _WishlistScreenState();
  }
}

class _WishlistScreenState extends State<WishlistScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeBloc>(context, listen: false).getWishlistItems(context);
    return Scaffold(
      drawer: ZCMenu(),
      endDrawer: ZCAccount(),
      appBar: AppBar(
        title: ZCAppBarTitle("WISHLIST"),
        backgroundColor: Colors.white,
        leading: Builder(
            builder: (BuildContext context) => Padding(
                  padding: EdgeInsets.only(left: 0.0),
                  child: widget.isEnableBack ? IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Constants.zc_font_black,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ): IconButton(
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
          builder: (context, homeBloc, child) => GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: homeBloc.wishlistItems.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext ctxt, int index) {
                return ZCProductItem(
                  product: homeBloc.wishlistItems[index],
                  isWishListed: true,
                );
              })),
    );
  }
}
