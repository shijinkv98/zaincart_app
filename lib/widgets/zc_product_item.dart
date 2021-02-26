import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/home_bloc.dart';
import 'package:zaincart_app/blocs/mycart_bloc.dart';
import 'package:zaincart_app/models/products_response.dart';
import 'package:zaincart_app/screen/product_detail_screen.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class ZCProductItem extends StatelessWidget {
  ZCProductItem({this.product, this.isWishListed = false});
  final Product product;
  final bool isWishListed;
  var isFavorite = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      width: 180.0,
      height: 250.0,
      child: InkWell(
        onTap: () => _onItemTap(context: context, productId: product.productId),
        child: Container(
          padding: EdgeInsets.only(top: 5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: Column(
            children: [
              Container(
                height: 80,
                child: Stack(
                  children: [
                    product.productOffer != null
                        ? Positioned(
                            left: 10.0,
                            child: CircleAvatar(
                              backgroundColor: Constants.zc_orange_dark,
                              radius: 12,
                              child: ZCText(
                                text: product.productOffer,
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          )
                        : new Container(),
                    Positioned(
                      right: 10.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 10,
                        child: ValueListenableBuilder(
                            valueListenable: isFavorite,
                            builder: (context, isFav, child) => IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: isWishListed ||
                                          isFav ||
                                          product.productWishlisted
                                      ? Icon(
                                          Icons.favorite,
                                          color: Constants.zc_orange_dark,
                                        )
                                      : Icon(Icons.favorite_border_outlined),
                                  color: isWishListed ||
                                          isFav ||
                                          product.productWishlisted
                                      ? Constants.zc_orange_dark
                                      : Colors.grey,
                                  onPressed: () {
                                    print(
                                        "Add to faviorate button clicked.....");
                                    if (isFavorite.value == true) {
                                      isFavorite.value = false;
                                    } else {
                                      isFavorite.value = true;
                                    }
                                    isWishListed ||
                                            isFav ||
                                            product.productWishlisted
                                        ? Provider.of<HomeBloc>(context,
                                                listen: false)
                                            .wishListRemove(
                                                context, product.productId)
                                        : Provider.of<HomeBloc>(context,
                                                listen: false)
                                            .wishListAdd(
                                                context, product.productId);
                                  },
                                )),
                      ),
                    ),
                    Center(
                      child: Container(
                          height: 79.0,
                          width: 130.0,
                          margin: EdgeInsets.only(top: 10.0),
                          child: Image.network(
                            product.productImage,
                            fit: BoxFit.contain,
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                child: ZCText(
                  text: product.productName,
                  color: Constants.zc_orange,
                  textAlign: TextAlign.center,
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
              Expanded(
                child: SizedBox(
                  height: 5.0,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: Constants.zc_yellow,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                child: InkWell(
                  onTap: () {
                    Provider.of<MyCartBloc>(context, listen: false).addToCart(
                        context: context,
                        productSku: product.productSku,
                        productQty: 1.toString());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      Icon(
                        Icons.add,
                        color: Constants.zc_orange,
                        //size: 10.0,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
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
