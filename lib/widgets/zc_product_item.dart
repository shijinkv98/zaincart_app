import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/home_bloc.dart';
import 'package:zaincart_app/blocs/mycart_bloc.dart';
import 'package:zaincart_app/models/products_response.dart';
import 'package:zaincart_app/models/response.dart';
import 'package:zaincart_app/models/wishlistAddResponse.dart';
import 'package:zaincart_app/models/wishlist_response.dart';
import 'package:zaincart_app/screen/product_detail_screen.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class ZCProductItem extends StatelessWidget {
  ZCProductItem({this.product, this.isWishListed = false});
  final Product product;
  final bool isWishListed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onItemTap(context: context, productId: product.productId),
      child: new Padding(
        padding: const EdgeInsets.all(8.0),
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
          child: Stack(
            children: [
              Container(
                width: 180,
              ),
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
                      ))
                  : new Container(),
              Positioned(
                  right: 10.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 10,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: isWishListed
                          ? Icon(
                              Icons.favorite,
                              color: Constants.zc_orange_dark,
                            )
                          : Icon(Icons.favorite_border_outlined),
                      color:
                          isWishListed ? Constants.zc_orange_dark : Colors.grey,
                      onPressed: () {
                        print("Add to faviorate button clicked.....");
                        isWishListed
                            ? _wishListRemove(context, product.productId)
                            : _wishListAdd(context, product.productId);
                      },
                    ),
                  )),
              Column(
                children: [
                  Center(
                      child: Container(
                          height: 79.0,
                          width: 130.0,
                          margin: EdgeInsets.only(top: 10.0),
                          child: Image.network(
                            product.productImage,
                            fit: BoxFit.contain,
                          ))),
                  Center(
                    child: Container(
                      width: 180,
                      child: ZCText(
                        text: product.productName,
                        color: Constants.zc_orange,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Center(
                    child: RatingBar.builder(
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
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Center(
                    child: ZCText(
                      text: product.productPrice,
                      color: Constants.zc_font_black,
                      semiBold: true,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    width: 180,
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: Constants.zc_yellow,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0.0, right: 0.0),
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
                            InkWell(
                              child: Icon(
                                Icons.add,
                                color: Constants.zc_orange,
                                //size: 10.0,
                              ),
                              onTap: () {
                                print("Add to Cart.....");
                                Provider.of<MyCartBloc>(context, listen: false)
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
                ],
              ),
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

  _wishListAdd(BuildContext context, String productId) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        APIService().wishlistAdd(productId).then((response) {
          if (response.statusCode == 200) {
            WishlistAddResponse wishlistResponse =
                WishlistAddResponse.fromJson(response.data);
            if (wishlistResponse.success == 0) {
              AlertUtils.showToast(wishlistResponse.error, context);
            } else if (wishlistResponse.success == 3) {
              kMoveToLogin(context);
            } else if (wishlistResponse.success == 1) {
              Provider.of<HomeBloc>(context, listen: false)
                  .getWishlistItems(context);
              AlertUtils.showToast(wishlistResponse.data.message, context);
            }
          } else {
            AlertUtils.showToast("Login Failed", context);
          }
        });
      }
    });
  }

  _wishListRemove(BuildContext context, String productId) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        APIService().wishlistRemove(productId).then((response) {
          if (response.statusCode == 200) {
            WishlistAddResponse wishlistResponse =
                WishlistAddResponse.fromJson(response.data);
            if (wishlistResponse.success == 0) {
              AlertUtils.showToast(wishlistResponse.error, context);
            } else if (wishlistResponse.success == 3) {
              kMoveToLogin(context);
            } else if (wishlistResponse.success == 1) {
              Provider.of<HomeBloc>(context, listen: false)
                  .getWishlistItems(context);
              AlertUtils.showToast(wishlistResponse.data.message, context);
            }
          } else {
            AlertUtils.showToast("Login Failed", context);
          }
        });
      }
    });
  }
}
