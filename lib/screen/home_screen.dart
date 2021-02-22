import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/home_bloc.dart';
import 'package:zaincart_app/screen/grocery_screen.dart';
import 'package:zaincart_app/screen/product_search_screen.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_account.dart';
import 'package:zaincart_app/widgets/zc_menu.dart';
import 'package:zaincart_app/widgets/zc_products_list.dart';
import 'package:zaincart_app/widgets/zc_search_field.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final double divHeight = MediaQuery.of(context).size.height;
    final double divWidth = MediaQuery.of(context).size.width;
    Provider.of<HomeBloc>(context, listen: false).getHomeData(context);
    Provider.of<HomeBloc>(context, listen: false).getRootCategories(context);
    return Scaffold(
      drawer: ZCMenu(),
      endDrawer: ZCAccount(),
      appBar: AppBar(
        title: Image.asset(
          Constants.zc_logo_notext,
          height: 180.0,
          fit: BoxFit.contain,
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
                    icon: Image.asset(Constants.ic_account),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ))
        ],
      ),
      body: Consumer<HomeBloc>(
          builder: (context, homeBloc, child) => ModalProgressHUD(
                inAsyncCall: homeBloc.isLoading,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                          height: 150.0,
                          width: divWidth,
                          child: Carousel(
                            dotBgColor: Colors.transparent,
                            dotSize: 5.0,
                            dotSpacing: 15.0,
                            images: [
                              NetworkImage(
                                  'https://www.thespruceeats.com/thmb/ZnWDXm0VjfY2wy25ocFqZccy5YY=/2164x1217/smart/filters:no_upscale()/freshvegetablesAlexRaths-4c1ea186a88e4fd7b95283eee614600c.jpg'),
                              NetworkImage(
                                  'https://d12man5gwydfvl.cloudfront.net/wp-content/uploads/2020/09/Fresh-vegetables-at-the-chiller-940x667.jpg'),
                              NetworkImage(
                                  'https://previews.123rf.com/images/serezniy/serezniy1110/serezniy111000508/10817587-fresh-vegetables-in-basket-on-wooden-table-on-green-background.jpg'),
                            ],
                          )),
                      Container(
                        height: 240.0,
                        decoration: BoxDecoration(
                            color: Constants.zc_orange,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(35),
                                bottomRight: Radius.circular(35))),
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: new ZCSearchField(
                                  hintText: "Search",
                                  items: homeBloc.homeData.searchCategory
                                      .map((e) => e.categoryName)
                                      .toList(),
                                  onChanged: (value) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ProductSearchScreen()));
                                  },
                                  onCategorySelected: (value) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ProductSearchScreen()));
                                  },
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            new ZCText(
                              text: "WHAT ARE YOU LOOKING FOR?",
                              color: Colors.white,
                              semiBold: true,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 120.0,
                              padding: EdgeInsets.only(left: 15.0, right: 15.0),
                              child: homeBloc.homeData.categoryList != null
                                  ? ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          homeBloc.homeData.categoryList.length,
                                      itemBuilder:
                                          (BuildContext ctxt, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15.0),
                                          child: InkWell(
                                            onTap: () => onCategoryTap(index),
                                            child: Column(children: [
                                              Container(
                                                  height: 80.0,
                                                  width: 80.0,
                                                  child: Image.network(
                                                    homeBloc
                                                        .homeData
                                                        .categoryList[index]
                                                        .image,
                                                    fit: BoxFit.cover,
                                                  )),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              ZCText(
                                                text: homeBloc
                                                    .homeData
                                                    .categoryList[index]
                                                    .categoryName,
                                                color: Colors.white,
                                                textAlign: TextAlign.center,
                                              )
                                            ]),
                                          ),
                                        );
                                      })
                                  : new Container(),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      homeBloc.homeData.newProduct != null
                          ? ZCProductsList(
                              title:
                                  homeBloc.homeData.categoryProducts.first.name,
                              productList: homeBloc
                                  .homeData.categoryProducts.first.items,
                            )
                          : new Container(),
                      SizedBox(
                        height: 10,
                      ),
                      homeBloc.homeData.newProduct != null
                          ? ZCProductsList(
                              title: "NEW PRODUCTS",
                              productList: homeBloc.homeData.newProduct,
                            )
                          : new Container(),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: new Container(
                          width: divWidth,
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(35),
                                bottomRight: Radius.circular(35),
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35),
                              )),
                          child: new Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  new ZCText(
                                    text: "REFER A FRIEND",
                                    bold: true,
                                    fontSize: 18.0,
                                    color: Constants.zc_orange,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Constants.zc_orange,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(35),
                                            bottomRight: Radius.circular(35),
                                            topLeft: Radius.circular(35),
                                            topRight: Radius.circular(35),
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0,
                                            right: 8.0,
                                            top: 5.0,
                                            bottom: 5.0),
                                        child: new ZCText(
                                          text: "Refer Now",
                                          semiBold: true,
                                          color: Colors.white,
                                          fontSize: kSmallFontSize,
                                        ),
                                      )),
                                ],
                              ),
                              Container(
                                height: 80.0,
                                width: 190.0,
                                child: Image.network(
                                  "https://thumbs.dreamstime.com/b/refer-friend-concept-social-media-refer-friend-concept-social-media-businessman-using-mobile-phone-app-to-refer-176615312.jpg",
                                  fit: BoxFit.contain,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      homeBloc.homeData.featuredProduct != null
                          ? ZCProductsList(
                              title:
                                  homeBloc.homeData.featuredProduct.first.name,
                              productList:
                                  homeBloc.homeData.featuredProduct.first.items,
                            )
                          : new Container(),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: new Container(
                          width: divWidth,
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(35),
                                bottomRight: Radius.circular(35),
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35),
                              )),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      Constants.ic_secure,
                                      height: 50.0,
                                      width: 50.0,
                                    ),
                                    SizedBox(height: 10.0),
                                    new ZCText(
                                      text: "100% Secure\nPayments",
                                      semiBold: true,
                                      color: Colors.black,
                                      fontSize: 13.0,
                                    ),
                                    new ZCText(
                                      text:
                                          "Lorem Ipsum place holder text will come here",
                                      semiBold: false,
                                      maxLines: 5,
                                      fontSize: 11.0,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      Constants.ic_delivery,
                                      height: 50.0,
                                      width: 50.0,
                                    ),
                                    SizedBox(height: 10.0),
                                    new ZCText(
                                      text: "Speed Delivery",
                                      semiBold: true,
                                      color: Colors.black,
                                      fontSize: 13.0,
                                    ),
                                    new ZCText(
                                      text:
                                          "Lorem Ipsum place holder text will come here",
                                      semiBold: false,
                                      maxLines: 5,
                                      fontSize: 11.0,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      Constants.ic_support,
                                      height: 50.0,
                                      width: 50.0,
                                    ),
                                    SizedBox(height: 10.0),
                                    new ZCText(
                                      text: "24x7 Support",
                                      semiBold: true,
                                      color: Colors.black,
                                      fontSize: 13.0,
                                    ),
                                    new ZCText(
                                      text:
                                          "Lorem Ipsum place holder text will come here",
                                      semiBold: false,
                                      maxLines: 5,
                                      fontSize: 11.0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
    );
  }

  openDrawer() {
    Scaffold.of(context).openDrawer();
  }

  onCategoryTap(int index) {
    if (index == 0) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => GroceryScreen()));
    }
  }
}
