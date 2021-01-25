import 'package:flutter/material.dart';
import 'package:zaincart_app/models/products_response.dart';
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
      height: 230.0,
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        children: [
          new ZCText(
            text: title,
            color: Constants.zc_orange,
            semiBold: true,
          ),
          Container(
            child: Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productList.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return ZCProductItem(product: productList[index],);
                    })),
          ),
        ],
      ),
    );
  }

 
}
