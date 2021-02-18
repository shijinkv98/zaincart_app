import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/home_bloc.dart';
import 'package:zaincart_app/models/products_response.dart';
import 'package:zaincart_app/models/wishlist_response.dart';
import 'package:zaincart_app/screen/login_screen.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_account.dart';
import 'package:zaincart_app/widgets/zc_menu.dart';
import 'package:zaincart_app/widgets/zc_product_item.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class WishlistScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WishlistScreenState();
  }
}

class _WishlistScreenState extends State<WishlistScreen> {
  bool isLoading = false;
  List<Product> _wishlistItems = new List<Product>();

  @override
  void initState() {
    getWishlistItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ZCMenu(),
      endDrawer: ZCAccount(),
      appBar: AppBar(
        title: ZCText(
          text: "WISHLIST",
          fontSize: 23.0,
          color: Constants.zc_orange_dark,
          semiBold: true,
        ),
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
      body: GridView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _wishlistItems.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext ctxt, int index) {
            return ZCProductItem(
              product: _wishlistItems[index],
              isWishListed: true,
            );
          }),
    );
  }

  getWishlistItems() {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        setState(() => isLoading = true);
        APIService().getWishlist().then((response) {
          setState(() => isLoading = false);
          if (response.statusCode == 200) {
            WishlistResponse wishlistResponse =
                WishlistResponse.fromJson(response.data);
            if (wishlistResponse.success == 0) {
              AlertUtils.showToast(wishlistResponse.error, context);
            } else if (wishlistResponse.success == 3) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen()));
            } else {
              setState(() {
                _wishlistItems = wishlistResponse.data.product;
              });
            }
          } else {
            AlertUtils.showToast("Login Failed", context);
          }
        });
      }
    });
  }
}
