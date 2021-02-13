import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zaincart_app/models/products_response.dart';
import 'package:zaincart_app/screen/product_detail_screen.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class ZCMyCartItem extends StatelessWidget {
  ZCMyCartItem({this.product});
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
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
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
                          height: 5.0,
                        ),
                        ZCText(
                          text: product.productPrice,
                          color: Constants.zc_font_black,
                          semiBold: true,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            new Container(
                              height: 20.0,
                              width: 30.0,
                              child: Center(
                                  child: FlatButton(
                                onPressed: () {
                                  itemCount.value = itemCount.value + 1;
                                },
                                child: ZCText(
                                  text: "+",
                                  color: Constants.zc_orange_dark,
                                  semiBold: true,
                                ),
                              )),
                              decoration: BoxDecoration(
                                  color: Constants.zc_yellow,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  )),
                            ),
                            new Container(
                              height: 20.0,
                              width: 30.0,
                              child: ValueListenableBuilder(
                                  valueListenable: itemCount,
                                  builder: (context, count, child) => Center(
                                          child: ZCText(
                                        text: count.toString(),
                                        fontSize: kSmallFontSize,
                                      ))),
                            ),
                            new Container(
                                height: 20.0,
                                width: 30.0,
                                child: Center(
                                    child: FlatButton(
                                  onPressed: () {
                                    itemCount.value = itemCount.value - 1;
                                  },
                                  child: ZCText(
                                    text: "-",
                                    color: Constants.zc_orange_dark,
                                    semiBold: true,
                                  ),
                                )),
                                decoration: BoxDecoration(
                                    color: Constants.zc_yellow,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ))),
                          ],
                        )
                      ]),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Constants.zc_orange_dark,
                        radius: 12,
                        child: ZCText(
                          text: "5%",
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
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
                                      } else {
                                        isFavorite.value = true;
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
