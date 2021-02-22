import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/home_bloc.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_account.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_category_item.dart';
import 'package:zaincart_app/widgets/zc_menu.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class GroceryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GroceryScreenState();
  }
}

class _GroceryScreenState extends State<GroceryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ZCMenu(),
      endDrawer: ZCAccount(),
      appBar: AppBar(
        title: ZCAppBarTitle("GROCERY"),
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
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ))
        ],
      ),
      body: Consumer<HomeBloc>(
          builder: (context, homeBloc, child) => ModalProgressHUD(
                inAsyncCall: homeBloc.isLoading,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: homeBloc.homeData.newProduct.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return ZCCategoryItem(
                        product: homeBloc.homeData.newProduct[index],
                      );
                    }),
              )),
    );
  }
}
