import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/home_bloc.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_account.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_menu.dart';
import 'package:zaincart_app/widgets/zc_product_item.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class CategoryScreen extends StatefulWidget {
  final String selectedCategory;
  CategoryScreen({this.selectedCategory});
  @override
  State<StatefulWidget> createState() {
    return _CategoryScreenState();
  }
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isLoading = false;
  var selectedCategory = ValueNotifier("Category");

  @override
  void initState() {
    selectedCategory.value = widget.selectedCategory;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ZCMenu(),
      endDrawer: ZCAccount(),
      appBar: AppBar(
        title: ZCAppBarTitle("CATEGORY"),
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
          builder: (context, homeBloc, child) => Column(
                children: [
                  // Container(
                  //   color: Colors.grey[200],
                  //   child: Padding(
                  //       padding: const EdgeInsets.only(
                  //           left: 10.0, right: 10.0, bottom: 10.0),
                  //       child: ValueListenableBuilder(
                  //           valueListenable: selectedCategory,
                  //           builder: (context, selected, child) =>
                  //               Container())),
                  // ),

                  Container(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: 10,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: ZCText(
                                    text: "kulup",
                                    fontSize: kHeadingFontSize,
                                    semiBold: true,
                                    color: Constants.zc_orange,
                                  ),
                                );
                              }),
                        ),
                        Container(
                          width: 50,
                          child: ZCText(
                            text: "FIlter",
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: homeBloc.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : GridView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: homeBloc.categoryProducts.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
