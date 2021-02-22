import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/home_bloc.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_account.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_menu.dart';
import 'package:zaincart_app/widgets/zc_product_item.dart';
import 'package:zaincart_app/widgets/zc_search_field.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class ProductSearchScreen extends StatefulWidget {
  final bool isEnableBack;
  ProductSearchScreen({this.isEnableBack = false});
  @override
  State<StatefulWidget> createState() {
    return _ProductSearchScreenState();
  }
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeBloc>(context, listen: false).getWishlistItems(context);
    return Scaffold(
      drawer: ZCMenu(),
      endDrawer: ZCAccount(),
      appBar: AppBar(
        title: ZCAppBarTitle("SEARCH"),
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
          builder: (context, homeBloc, child) => Column(
                children: [
                  Container(
                    color: Colors.grey[200],
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 10.0),
                        child: new ZCSearchField(
                          hintText: "Search",
                          items: homeBloc.categories
                              .map((e) => e.categoryName)
                              .toList(),
                          onChanged: (value) {},
                          onCategorySelected: (category) {
                            var categoryId = homeBloc.categories
                                .where((element) =>
                                    element.categoryName == category)
                                .first
                                .categoryId;
                            homeBloc.getProductsByCategory(
                                context: context,
                                categoryId: categoryId,
                                pageNo: "1");
                          },
                        )),
                  ),
                  Expanded(
                    child: homeBloc.isLoading ? Center(child: CircularProgressIndicator()): GridView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: homeBloc.categoryProducts.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (BuildContext ctxt, int index) {
                          return ZCProductItem(
                            product: homeBloc.categoryProducts[index],
                          );
                        }),
                  ),
                ],
              )),
    );
  }
}
