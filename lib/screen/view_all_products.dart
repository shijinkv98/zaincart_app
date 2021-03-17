import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/home_bloc.dart';
import 'package:zaincart_app/models/products_response.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_account.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_menu.dart';
import 'package:zaincart_app/widgets/zc_product_item.dart';

class ViewAllProductsScreen extends StatefulWidget {
  final List<Product> productList;
  final String title;
  ViewAllProductsScreen({this.productList, this.title});
  @override
  State<StatefulWidget> createState() {
    return _ViewAllProductsScreenState();
  }
}

class _ViewAllProductsScreenState extends State<ViewAllProductsScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeBloc>(context, listen: false).getWishlistItems(context);
    return Scaffold(
      drawer: ZCMenu(),
      endDrawer: ZCAccount(),
      appBar: AppBar(
        title: ZCAppBarTitle(widget.title),
        backgroundColor: Colors.white,
        leading: Builder(
            builder: (BuildContext context) => Padding(
                padding: EdgeInsets.only(left: 0.0),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Constants.zc_font_black,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ))),
        actions: <Widget>[
          Builder(
              builder: (BuildContext context) => IconButton(
                    icon: Image.asset(Constants.ic_account),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ))
        ],
      ),
      body: GridView.builder(
          gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: widget.productList.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return ZCProductItem(
              product: widget.productList[index],
            );
          }),
    );
  }
}
