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
}
