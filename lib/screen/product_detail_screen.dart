import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
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
import 'package:zaincart_app/widgets/zc_products_list.dart';
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
  var isFavorite = ValueNotifier(false);

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
                            ValueListenableBuilder(
                                valueListenable: isFavorite,
                                builder: (context, isFav, child) => Positioned(
                                    right: 10.0,
                                    top: 10.0,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 18,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: isFav
                                            ? Icon(
                                                Icons.favorite,
                                                color: Constants.zc_orange_dark,
                                              )
                                            : Icon(
                                                Icons.favorite_border_outlined),
                                        color: isFav
                                            ? Constants.zc_orange_dark
                                            : Colors.grey,
                                        onPressed: () {
                                          isFav
                                              ? isFavorite.value = false
                                              : isFavorite.value = true;
                                          isFav
                                              ? Provider.of<HomeBloc>(context,
                                                      listen: false)
                                                  .wishListRemove(context,
                                                      _productDetail.productId)
                                              : Provider.of<HomeBloc>(context,
                                                      listen: false)
                                                  .wishListAdd(context,
                                                      _productDetail.productId);
                                        },
                                      ),
                                    )))
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _showBottomSheet(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          new ZCText(
                                            text: "Varients",
                                            color: Colors.black54,
                                            semiBold: true,
                                            fontSize: kFontSize,
                                          ),
                                          _productDetail.specifications != null
                                              ? new Container()
                                              : Icon(Icons
                                                  .keyboard_arrow_down_outlined)
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    _productDetail.specifications != null
                                        ? InkWell(
                                            onTap: () =>
                                                _showBottomSheet(context),
                                            child: Container(
                                              child: Column(
                                                children: _productDetail
                                                    .specifications
                                                    .map((spec) => Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                ZCText(
                                                                  text: spec
                                                                      .label,
                                                                ),
                                                                ZCText(
                                                                  text: " : ",
                                                                ),
                                                                ZCText(
                                                                  text: spec
                                                                      .value,
                                                                ),
                                                                Expanded(
                                                                    child:
                                                                        new Container()),
                                                                Icon(Icons
                                                                    .keyboard_arrow_down_outlined)
                                                              ],
                                                            ),
                                                            Divider(
                                                              thickness: 1.0,
                                                            )
                                                          ],
                                                        ))
                                                    .toList(),
                                              ),
                                            ),
                                          )
                                        : new Container()
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Container(
                                      width: 130,
                                      padding: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          color: Constants.zc_orange,
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
                                                      productSku: _productDetail
                                                          .productSku,
                                                      productQty: 1.toString());
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  Constants.ic_cart_white,
                                                  height: 23.0,
                                                  width: 23.0,
                                                ),
                                                SizedBox(
                                                  width: 5.0,
                                                ),
                                                ZCText(
                                                  text: "Add to Cart",
                                                  fontSize: kSmallFontSize,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Provider.of<MyCartBloc>(context,
                                                listen: false)
                                            .buyNowProduct(
                                                context: context,
                                                productSku:
                                                    _productDetail.productSku,
                                                productQty: 1.toString());
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 30.0,
                                        padding: EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Constants.zc_font_grey),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20),
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0, right: 5.0),
                                            child: ZCText(
                                              text: "Buy Now",
                                              fontSize: kSmallFontSize,
                                              color: Constants.zc_font_grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                InkWell(
                                  onTap: () =>
                                      shareProduct(_productDetail.productUrl),
                                  child: Row(
                                    children: [
                                      ZCText(
                                        text: "Share",
                                        color: Colors.grey,
                                      ),
                                      Icon(
                                        Icons.share,
                                        color: Constants.zc_font_light_grey,
                                        size: 15.0,
                                      ),
                                    ],
                                  ),
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
                                      .map((review) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Container(
                                              color: Colors.grey[100],
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
                                                        itemPadding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    1.0),
                                                        itemBuilder:
                                                            (context, _) =>
                                                                Icon(
                                                          Icons.star,
                                                          color: Constants
                                                              .zc_orange,
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
                                                        fontSize:
                                                            kSmallFontSize,
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                _productDetail.relatedProduct.isNotEmpty
                                    ? ZCProductsList(
                                        title: "RELATED PRODUCTS",
                                        productList:
                                            _productDetail.relatedProduct,
                                      )
                                    : new Container()
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

  getProductDetail(
    String productId,
  ) {
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
              isFavorite.value = _productDetail.productWishlisted;
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
                reviewList = productReviewResponse.reviewData.list;
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

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          child: _productDetail.productOptions != null
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15.0),
                          child: ZCText(
                            text: "CHANGE VARIENTS",
                            color: Constants.zc_font_grey,
                          ),
                        ),
                        Expanded(child: Container()),
                        Container(
                          width: 1.0,
                          height: 45.0,
                          color: Constants.zc_font_light_grey,
                        ),
                        Container(
                          padding: EdgeInsets.all(15.0),
                          child: ZCText(
                            text: "CANCEL",
                            semiBold: true,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(15.0),
                          color: Constants.zc_orange,
                          child: ZCText(
                            text: "APPLY",
                            color: Colors.white,
                            semiBold: true,
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 1.0,
                      color: Constants.zc_font_light_grey,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Column(
                      children: _productDetail.productOptions
                          .map((option) => Column(children: [
                                ZCText(
                                  text: option.label + " : ",
                                  semiBold: true,
                                ),
                                Container(
                                  height: 40.0,
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    direction: Axis.vertical,
                                    children: option.value
                                        .map((opItem) => InkWell(
                                              onTap: () {
                                                var pId = _productDetail
                                                    .childProduct
                                                    .where((child) =>
                                                        child.productSku ==
                                                        opItem.sku)
                                                    .first
                                                    .productId;
                                                getProductDetail(pId);
                                                Navigator.of(context).pop();
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        height: 20.0,
                                                        width: 20.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Constants
                                                                  .zc_font_grey),
                                                          color: opItem.sku ==
                                                                  _productDetail
                                                                      .productSku
                                                              ? Constants
                                                                  .zc_orange
                                                              : Colors.white,
                                                        ),
                                                        child: opItem.sku ==
                                                                _productDetail
                                                                    .productSku
                                                            ? Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .white,
                                                                size: 17.0,
                                                              )
                                                            : new Container()),
                                                    SizedBox(width: 5.0),
                                                    ZCText(
                                                      text: opItem.optionTitle,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                )
                              ]))
                          .toList(),
                    )
                  ],
                )
              : Center(
                  child: ZCText(
                  text: "No Product options",
                )),
        );
      },
    );
  }

  shareProduct(String url) {
    final RenderBox renderBox = context.findRenderObject();
    Share.share(_productDetail.productUrl,
        sharePositionOrigin:
            renderBox.localToGlobal(Offset.zero) & renderBox.size);
  }
}
