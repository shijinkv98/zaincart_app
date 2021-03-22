import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/home_bloc.dart';
import 'package:zaincart_app/screen/filter_screen.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_account.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_category_item.dart';
import 'package:zaincart_app/widgets/zc_menu.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class CategoryScreen extends StatefulWidget {
  final title;
  CategoryScreen(this.title);
  @override
  State<StatefulWidget> createState() {
    return _CategoryScreenState();
  }
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isLoading = false;
  //var subCategory = ValueNotifier("");
  var _radioGroup = ValueNotifier("");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeBloc>(context, listen: false).getProductsByCategory(
        context: context,
        categoryId:
            Provider.of<HomeBloc>(context, listen: false).selectedCategoryId,
        pageNo: "1");
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
                  Container(
                    height: 35,
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: ListView.builder(
                              itemCount: homeBloc.categories
                                  .where((e) =>
                                      e.categoryId ==
                                      homeBloc.selectedCategoryId)
                                  .first
                                  .subcategory
                                  .length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return InkWell(
                                  onTap: () {
                                    homeBloc.selectedSubCategoryId = homeBloc
                                        .categories
                                        .where((e) =>
                                            e.categoryId ==
                                            homeBloc.selectedCategoryId)
                                        .first
                                        .subcategory[index]
                                        .categoryId;

                                    homeBloc.getProductsByCategory(
                                        context: context,
                                        categoryId:
                                            homeBloc.selectedSubCategoryId,
                                        pageNo: "1");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 10.0, top: 10.0),
                                    child: Column(
                                      children: [
                                        ZCText(
                                          text: homeBloc.categories
                                              .where((e) =>
                                                  e.categoryId ==
                                                  homeBloc.selectedCategoryId)
                                              .first
                                              .subcategory[index]
                                              .categoryName,
                                          color: Constants.zc_font_grey,
                                        ),
                                        homeBloc.selectedSubCategoryId ==
                                                homeBloc.categories
                                                    .where((e) =>
                                                        e.categoryId ==
                                                        homeBloc
                                                            .selectedCategoryId)
                                                    .first
                                                    .subcategory[index]
                                                    .categoryId
                                            ? Container(
                                                height: 5.0,
                                                color: Constants.zc_orange,
                                                width: homeBloc.categories
                                                        .where((e) =>
                                                            e.categoryId ==
                                                            homeBloc
                                                                .selectedCategoryId)
                                                        .first
                                                        .subcategory[index]
                                                        .categoryName
                                                        .length *
                                                    7.toDouble(),
                                              )
                                            : new Container()
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )),
                        InkWell(
                          onTap: () => _showSortPopup(context),
                          child: Container(
                            width: 40,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.sort,
                                  size: 8.0,
                                ),
                                ZCText(
                                  text: "Sort",
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    FilterScreen()));
                          },
                          child: Container(
                            width: 70,
                            child: Row(
                              children: [
                                Image.asset(
                                  Constants.ic_filter,
                                  height: 20.0,
                                  width: 20.0,
                                ),
                                ZCText(
                                  text: "FIlter",
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                  ),
                  Expanded(
                    child: homeBloc.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: homeBloc.categoryProducts.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return ZCCategoryItem(
                                product: homeBloc.categoryProducts[index],
                              );
                            }),
                  ),
                ],
              )),
    );
  }

  _showSortPopup(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Hello there",
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 200), //This is time
      barrierColor: Colors.black.withOpacity(0.6), // Add this property is color
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Material(
              color: Colors.transparent,
              child: new Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    height: 300.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Container()),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20.0, top: 50.0),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.close,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: ZCText(
                            text: "SORT BY",
                          ),
                        ),
                        ValueListenableBuilder(
                            valueListenable: _radioGroup,
                            builder: (context, radio, child) => new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        new Radio(
                                          value: "1",
                                          groupValue: radio,
                                          onChanged: (val) => _sortProduct(val),
                                        ),
                                        new Text(
                                          'Newest First',
                                          style: new TextStyle(fontSize: 16.0),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        new Radio(
                                          value: "asc",
                                          groupValue: radio,
                                          onChanged: (val) => _sortProduct(val),
                                        ),
                                        new Text(
                                          'Price - low to high',
                                          style: new TextStyle(fontSize: 16.0),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        new Radio(
                                          value: "desc",
                                          groupValue: radio,
                                          onChanged: (val) => _sortProduct(val),
                                        ),
                                        new Text(
                                          'Price - high to low',
                                          style: new TextStyle(fontSize: 16.0),
                                        )
                                      ],
                                    ),
                                  ],
                                ))
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  _sortProduct(String sortBy) {
    _radioGroup.value = sortBy;
    Provider.of<HomeBloc>(context, listen: false).getSortProducts(
        context: context,
        categoryId:
            Provider.of<HomeBloc>(context, listen: false).selectedCategoryId,
        pageNo: "1",
        newest: _radioGroup.value == "1" ? "1" : "0",
        priceVal: _radioGroup.value == "1" ? "asc" : _radioGroup.value);
  }
}
