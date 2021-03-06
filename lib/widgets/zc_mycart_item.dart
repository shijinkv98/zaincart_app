import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/home_bloc.dart';
import 'package:zaincart_app/blocs/mycart_bloc.dart';
import 'package:zaincart_app/models/cartlist_response.dart';
import 'package:zaincart_app/screen/product_detail_screen.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_network_image.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class ZCMyCartItem extends StatelessWidget {
  ZCMyCartItem({this.cartProduct, this.cartId});
  final CartProduct cartProduct;
  final String cartId;
  var itemCount = ValueNotifier(0);

  var isFavorite = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          _onItemTap(context: context, productId: cartProduct.productId),
      child: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 90.0,
                      width: 130.0,
                      child: ZCNetworkImage(
                        cartProduct.image,
                        fit: BoxFit.contain,
                      )),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 215.0,
                          child: ZCText(
                            text: cartProduct.produtName,
                            color: Constants.zc_orange,
                            semiBold: true,
                            maxLines: 2,
                            fontSize: 16.0,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        RatingBar.builder(
                          initialRating: cartProduct.rating.toDouble(),
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
                          text: cartProduct.productPrice,
                          color: Constants.zc_font_black,
                          semiBold: true,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            new Container(
                              height: 30.0,
                              width: 35.0,
                              child: Center(
                                  child: FlatButton(
                                onPressed: () {
                                  if (cartProduct.quantity > 0) {
                                    _onQuantityUpdate(context,
                                        cartProduct.quantity - 1, cartProduct);
                                  }
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
                                    bottomLeft: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  )),
                            ),
                            new Container(
                              height: 30.0,
                              width: 35.0,
                              child: ValueListenableBuilder(
                                  valueListenable: itemCount,
                                  builder: (context, count, child) => Center(
                                          child: ZCText(
                                        text: (cartProduct.quantity).toString(),
                                        fontSize: kSmallFontSize,
                                      ))),
                            ),
                            new Container(
                                height: 30.0,
                                width: 35.0,
                                child: Center(
                                    child: FlatButton(
                                  onPressed: () {
                                    _onQuantityUpdate(context,
                                        cartProduct.quantity + 1, cartProduct);
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
                                      bottomRight: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ))),
                          ],
                        ),
                      ]),
                  Row(
                    children: [
                      // product.productOffer != null
                      //     ? CircleAvatar(
                      //         backgroundColor: Constants.zc_orange_dark,
                      //         radius: 12,
                      //         child: ZCText(
                      //           text: cartProduct.productOffer,
                      //           color: Colors.white,
                      //           fontSize: 10,
                      //         ),
                      //       )
                      //     : new Container(),
                      // SizedBox(
                      //   width: 3.0,
                      // ),
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
                                                context, cartProduct.productId);
                                      } else {
                                        isFavorite.value = true;
                                        Provider.of<HomeBloc>(context,
                                                listen: false)
                                            .wishListAdd(
                                                context, cartProduct.productId);
                                      }
                                      print(
                                          "Add to faviorate button clicked.....");
                                    },
                                  )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            new Container(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  print(
                      "remove from cart list ${cartProduct.cartItemId} - ${cartId}");
                  Provider.of<MyCartBloc>(context, listen: false)
                      .removeFromCart(
                          context: context,
                          itemId: cartProduct.cartItemId,
                          cartId: cartId);
                },
                child: Container(
                  color: Colors.grey[200],
                  width: 65.0,
                  margin: EdgeInsets.only(top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.close,
                        size: kSmallFontSize,
                      ),
                      ZCText(
                        text: "Remove",
                        fontSize: kSmallFontSize,
                      ),
                    ],
                  ),
                ),
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

  _onQuantityUpdate(BuildContext context, int qty, CartProduct product) {
    Provider.of<MyCartBloc>(context, listen: false).updateCartItem(
        context: context,
        productQty: qty.toString(),
        cartItemId: product.cartItemId,
        cartId: cartId);
  }
}
