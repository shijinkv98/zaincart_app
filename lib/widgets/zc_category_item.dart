import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/home_bloc.dart';
import 'package:zaincart_app/blocs/mycart_bloc.dart';
import 'package:zaincart_app/models/products_response.dart';
import 'package:zaincart_app/screen/product_detail_screen.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class ZCCategoryItem extends StatelessWidget {
  ZCCategoryItem({this.product});
  final Product product;
  var itemCount = ValueNotifier(0);
  var isFavorite = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onItemTap(context: context, productId: product.productId),
      child: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 90.0,
                      width: 130.0,
                      child: Image.network(
                        product.productImage,
                        fit: BoxFit.contain,
                      )),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 230.0,
                          child: ZCText(
                            text: product.productName,
                            color: Constants.zc_orange,
                            semiBold: true,
                            maxLines: 3,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          itemSize: 10.0,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Constants.zc_orange,
                            size: 15.0,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ZCText(
                          text: product.productPrice,
                          color: Constants.zc_font_black,
                          semiBold: true,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: 200,
                          padding: EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              color: Constants.zc_yellow,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 0.0, right: 0.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    Constants.ic_add_to_cart,
                                    height: 23.0,
                                    width: 23.0,
                                  ),
                                  ZCText(
                                    text: "Add to Cart",
                                    fontSize: kSmallFontSize,
                                  ),
                                  ZCText(
                                    text: "|",
                                    fontSize: kFontSize,
                                    color: Colors.white,
                                  ),
                                  InkWell(
                                    child: Icon(
                                      Icons.add,
                                      color: Constants.zc_orange,
                                      //size: 10.0,
                                    ),
                                    onTap: () {
                                      print("Add to cart button clicked.....");
                                      Provider.of<MyCartBloc>(context,
                                              listen: false)
                                          .addToCart(
                                              context: context,
                                              productSku: product.productSku,
                                              productQty: 1.toString());
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ]),
                  Row(
                    children: [
                      product.productOffer != null
                          ? CircleAvatar(
                              backgroundColor: Constants.zc_orange_dark,
                              radius: 12,
                              child: ZCText(
                                text: product.productOffer,
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            )
                          : new Container(),
                      SizedBox(
                        width: 3.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 10,
                          child: ValueListenableBuilder(
                              valueListenable: isFavorite,
                              builder: (context, isFav, child) => IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: isFav
                                        ? Icon(
                                            Icons.favorite,
                                            color: Constants.zc_orange_dark,
                                          )
                                        : Icon(Icons.favorite_border_outlined),
                                    color: Colors.grey,
                                    onPressed: () {
                                      if (isFavorite.value == true) {
                                        isFavorite.value = false;
                                        Provider.of<HomeBloc>(context,
                                                listen: false)
                                            .wishListRemove(
                                                context, product.productId);
                                      } else {
                                        isFavorite.value = true;
                                        Provider.of<HomeBloc>(context,
                                                listen: false)
                                            .wishListAdd(
                                                context, product.productId);
                                      }
                                      print(
                                          "Add to faviorate button clicked.....");
                                    },
                                  )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Divider(
              thickness: 1.0,
            )
          ],
        ),
      ),
    );
  }

  _onItemTap({BuildContext context, String productId}) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ProductDetailScreen(
              productId: productId,
            )));
  }
}
