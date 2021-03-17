import 'package:flutter/material.dart';
import 'package:zaincart_app/models/products_response.dart';
import 'package:zaincart_app/screen/view_all_products.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_product_item.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class ZCProductsList extends StatelessWidget {
  ZCProductsList({this.title, this.productList});
  final List<Product> productList;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240.0,
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 15.0,
                  width: 24.0,
                  margin: EdgeInsets.only(right: 15.0),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      border: Border.all(color: Colors.transparent)),
                  child: Container(
                      child: Icon(
                    Icons.arrow_right_alt_outlined,
                    color: Colors.transparent,
                    size: 13.0,
                  )),
                ),
                new ZCText(
                  text: title,
                  color: Constants.zc_orange,
                  semiBold: true,
                ),
                InkWell(
                  child: Container(
                    height: 15.0,
                    width: 24.0,
                    margin: EdgeInsets.only(right: 15.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        border: Border.all(color: Constants.zc_orange)),
                    child: Container(
                        child: Icon(
                      Icons.arrow_right_alt_outlined,
                      color: Constants.zc_orange,
                      size: 13.0,
                    )),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ViewAllProductsScreen(
                              productList: productList,
                              title: title,
                            )));
                  },
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productList.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return ZCProductItem(
                      product: productList[index],
                    );
                  })),
        ],
      ),
    );
  }
}
