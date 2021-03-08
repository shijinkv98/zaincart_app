import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/home_bloc.dart';
import 'package:zaincart_app/blocs/mycart_bloc.dart';
import 'package:zaincart_app/models/product_detail_response.dart';
import 'package:zaincart_app/models/product_review_response.dart';
import 'package:zaincart_app/screen/add_review_screen.dart';
import 'package:zaincart_app/utils/alert_utils.dart';
import 'package:zaincart_app/utils/api_service.dart';
import 'package:zaincart_app/utils/app_utils.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_account.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  ProductDetailScreen({this.productId});
  @override
  ProductDetailState createState() => ProductDetailState();
}

class ProductDetailState extends State<ProductDetailScreen> {
  bool isLoading = false;
  ProductDetail _productDetail;
  List<Review> reviewList = List<Review>();

  @override
  void initState() {
    getProductDetail(widget.productId);
    getProductReview(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double divHeight = MediaQuery.of(context).size.height;
    final double divWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      endDrawer: ZCAccount(),
      appBar: AppBar(
        title: ZCAppBarTitle(""),
        leading: Padding(
          padding: EdgeInsets.only(left: 0.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        actions: <Widget>[
          Builder(
              builder: (BuildContext context) => IconButton(
                    icon: Image.asset(Constants.ic_account),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ))
        ],
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: _productDetail != null
                  ? new Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                                height: 200.0,
                                width: divWidth,
                                child: _productDetail.productImage != null
                                    ? Carousel(
                                        dotBgColor: Colors.transparent,
                                        dotSize: 5.0,
                                        dotSpacing: 15.0,
                                        images: _productDetail.productImage
                                            .map((image) => NetworkImage(image))
                                            .toList(),
                                      )
                                    : new Container()),
                            _productDetail.productOffer != null
                                ? Positioned(
                                    left: 10.0,
                                    top: 10.0,
                                    child: CircleAvatar(
                                      backgroundColor: Constants.zc_orange_dark,
                                      radius: 18,
                                      child: ZCText(
                                        text: _productDetail.productOffer,
                                        color: Colors.white,
                                        fontSize: kSmallFontSize,
                                      ),
                                    ))
                                : new Container(),
                            Positioned(
                                right: 10.0,
                                top: 10.0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 18,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(Icons.favorite_border_outlined),
                                    color: Constants.zc_font_black,
                                    onPressed: () {
                                      print(
                                          "Add to faviorate button clicked.....");
                                      Provider.of<HomeBloc>(context,
                                              listen: false)
                                          .wishListAdd(context,
                                              _productDetail.productId);
                                    },
                                  ),
                                ))
                          ],
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new ZCText(
                                  text: _productDetail.productName,
                                  color: Constants.zc_orange_dark,
                                  semiBold: true,
                                  fontSize: kHeadingFontSize,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: [
                                    new ZCText(
                                      text: _productDetail.productPrice,
                                      color: Constants.zc_font_grey,
                                      semiBold: true,
                                      fontSize: kHeadingFontSize,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    new ZCText(
                                      text: _productDetail.productSpPrice,
                                      color: Constants.zc_font_light_grey,
                                      semiBold: true,
                                      fontSize: kHeadingFontSize,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                RatingBar.builder(
                                  initialRating:
                                      _productDetail.rating.toDouble(),
                                  minRating: 1,
                                  itemSize: 15.0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 1.0),
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
                                new ZCText(
                                  text: _productDetail.stockStatus
                                      ? "In stock"
                                      : "Out of stock",
                                  color: _productDetail.stockStatus
                                      ? Colors.green
                                      : Colors.red,
                                  semiBold: true,
                                  fontSize: kFontSize,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                new ZCText(
                                  text: "SKU: ${_productDetail.productSku}",
                                  color: Colors.black54,
                                  semiBold: true,
                                  fontSize: kFontSize,
                                ),
                                SizedBox(height: 10.0),
                                Container(
                                  width: 180,
                                  padding: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      child: InkWell(
                                        onTap: () {
                                          Provider.of<MyCartBloc>(context,
                                                  listen: false)
                                              .addToCart(
                                                  context: context,
                                                  productSku:
                                                      _productDetail.productSku,
                                                  productQty: 1.toString());
                                        },
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
                                            Icon(
                                              Icons.add,
                                              color: Constants.zc_orange,
                                              //size: 10.0,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                ZCText(
                                  text: "Share this app",
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                HtmlWidget(
                                  _productDetail.productDescription != null
                                      ? _productDetail.productDescription
                                      : "",
                                  textStyle: TextStyle(fontSize: kFontSize),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                HtmlWidget(
                                  _productDetail.productShortDescription != null
                                      ? _productDetail.productShortDescription
                                      : "",
                                  textStyle: TextStyle(fontSize: kFontSize),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                ZCText(
                                  text: "Your Rating",
                                  fontSize: kFontSize,
                                  color: Constants.zc_orange,
                                  semiBold: true,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                RatingBar.builder(
                                  initialRating: 0,
                                  minRating: 1,
                                  itemSize: 15.0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 1.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Constants.zc_orange,
                                    size: 15.0,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                AddReviewScreen(
                                                  rating: rating,
                                                  productId:
                                                      _productDetail.productId,
                                                )));
                                  },
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                ZCText(
                                  text: "Rating and Reviews",
                                  fontSize: kFontSize,
                                  color: Constants.zc_orange,
                                  semiBold: true,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Column(
                                  children: reviewList
                                      .map((review) => Container(
                                            padding: EdgeInsets.all(10.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    ZCText(
                                                      text: review.title,
                                                      semiBold: true,
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    RatingBar.builder(
                                                      initialRating: review
                                                          .rating
                                                          .toDouble(),
                                                      itemSize: 10.0,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: false,
                                                      itemCount: 5,
                                                      itemPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 1.0),
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                        Icons.star,
                                                        color:
                                                            Constants.zc_orange,
                                                        size: 10.0,
                                                      ),
                                                      onRatingUpdate:
                                                          (double value) {},
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5.0),
                                                Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: ZCText(
                                                      text: review.detail,
                                                    )),
                                                Divider(
                                                  thickness: 1.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    ZCText(
                                                      text: review.nickname,
                                                      color: Constants
                                                          .zc_font_light_grey,
                                                    ),
                                                    ZCText(
                                                      text: review
                                                          .createdDateTime,
                                                      color: Constants
                                                          .zc_font_light_grey,
                                                      fontSize: kSmallFontSize,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : Center(child: new CircularProgressIndicator()),
            ),
    );
  }

  getProductDetail(String productId) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        setState(() => isLoading = true);
        APIService().getPrductDetail(productId).then((response) {
          setState(() => isLoading = false);
          if (response.statusCode == 200) {
            ProductDetailResponse productDetailResponse =
                ProductDetailResponse.fromJson(response.data);
            if (productDetailResponse.success != 1) {
              AlertUtils.showToast(productDetailResponse.error, context);
            } else {
              setState(() {
                _productDetail = productDetailResponse.productDetail;
              });
            }
          } else {
            AlertUtils.showToast("Login Failed", context);
          }
        });
      }
    });
  }

  getProductReview(String productId) {
    AppUtils.isConnectedToInternet(context).then((isConnected) {
      if (isConnected) {
        setState(() => isLoading = true);
        APIService().getPrductReview(productId).then((response) {
          setState(() => isLoading = false);
          if (response.statusCode == 200) {
            ProductReviewResponse productReviewResponse =
                ProductReviewResponse.fromJson(response.data);
            if (productReviewResponse.success == 1) {
              setState(() {
                reviewList = productReviewResponse.reviewList;
              });
            } else if (productReviewResponse.success == 3) {
              kMoveToLogin(context);
            } else {
              AlertUtils.showToast(productReviewResponse.error, context);
            }
          } else {
            AlertUtils.showToast("Login Failed", context);
          }
        });
      }
    });
  }
}
