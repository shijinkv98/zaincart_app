import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/home_bloc.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class FilterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  bool isLoading = false;
  TextEditingController _reasonController = new TextEditingController();
  var priceRange = ValueNotifier(1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: ZCText(
          text: "FILTER",
          fontSize: 23.0,
          color: Colors.white,
          semiBold: true,
        )),
        backgroundColor: Constants.zc_orange,
        leading: Builder(
            builder: (BuildContext context) => Padding(
                  padding: EdgeInsets.only(left: 0.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )),
      ),
      body: SingleChildScrollView(
        child: Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: Consumer<HomeBloc>(
              builder: (context, homeBloc, child) => Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: homeBloc.filterValues
                            .map((filter) => filter.code != "price"
                                ? ExpansionTile(
                                    title: ZCText(
                                      text: filter.key,
                                      color: Constants.zc_orange,
                                    ),
                                    children: filter.values
                                        .map((value) => InkWell(
                                              onTap: () {
                                                homeBloc.selectedSubCategoryId =
                                                    value.value;
                                                homeBloc.getFilterProducts(
                                                    context: context,
                                                    categoryId: homeBloc
                                                        .selectedCategoryId,
                                                    filterVal: value.value,
                                                    key: filter.key);
                                                Navigator.of(context).pop();
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 40.0,
                                                    top: 3.0,
                                                    bottom: 3.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: ZCText(
                                                    text: value.label +
                                                        " (${value.count})",
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  )
                                : ExpansionTile(
                                    title: ZCText(
                                      text: "Price",
                                      color: Constants.zc_orange,
                                    ),
                                    children: <Widget>[
                                      ValueListenableBuilder(
                                          valueListenable: priceRange,
                                          builder: (context, range, child) =>
                                              Column(
                                                children: [
                                                  ZCText(
                                                    text:
                                                        "QAR: ${range.toStringAsFixed(2)}",
                                                  ),
                                                  SliderTheme(
                                                    data:
                                                        SliderTheme.of(context)
                                                            .copyWith(
                                                      valueIndicatorColor:
                                                          Colors.blue,
                                                      inactiveTrackColor:
                                                          Constants
                                                              .zc_font_light_grey,
                                                      activeTrackColor:
                                                          Constants.zc_orange,
                                                      thumbColor:
                                                          Constants.zc_orange,
                                                      overlayColor:
                                                          Color(0x29EB1555),
                                                      thumbShape:
                                                          RoundSliderThumbShape(
                                                              enabledThumbRadius:
                                                                  15.0),
                                                      overlayShape:
                                                          RoundSliderOverlayShape(
                                                              overlayRadius:
                                                                  20.0),
                                                    ),
                                                    child: Slider(
                                                      value: range,
                                                      onChanged: (price) {
                                                        print(price);
                                                        priceRange.value =
                                                            price;
                                                      },
                                                      onChangeEnd: (price) {
                                                        // homeBloc.selectedSubCategoryId =
                                                        //       value.value;
                                                        homeBloc.getFilterProducts(
                                                            context: context,
                                                            categoryId: homeBloc
                                                                .selectedCategoryId,
                                                            filterVal: price
                                                                .toStringAsFixed(2),
                                                            key: filter.key);
                                                      },
                                                      min: filter.minPrice
                                                          .toDouble(),
                                                      max: filter.maxPrice
                                                          .toDouble(),
                                                      label: range.toString(),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      ZCText(
                                                        text:
                                                            "QAR: ${filter.minPrice.toString()}",
                                                        fontSize:
                                                            kSmallFontSize,
                                                      ),
                                                      ZCText(
                                                        text:
                                                            "QAR: ${filter.maxPrice.toString()}",
                                                        fontSize:
                                                            kSmallFontSize,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )),
                                    ],
                                  ))
                            .toList(),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ZCText(
                          text: "Category",
                          color: Constants.zc_orange,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        height: 280.0,
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: homeBloc.homeData.categoryList != null
                            ? GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    homeBloc.homeData.categoryList.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return InkWell(
                                    onTap: () => onCategoryTap(
                                        homeBloc.homeData.categoryList[index]
                                            .categoryName,
                                        homeBloc.homeData.categoryList[index]
                                            .categoryId),
                                    child: Column(children: [
                                      Container(
                                          height: 100.0,
                                          width: 100.0,
                                          child: Image.network(
                                            homeBloc.homeData
                                                .categoryList[index].image,
                                            fit: BoxFit.cover,
                                          )),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      ZCText(
                                        text: homeBloc.homeData
                                            .categoryList[index].categoryName,
                                        color: Constants.zc_orange,
                                        textAlign: TextAlign.center,
                                      )
                                    ]),
                                  );
                                })
                            : new Container(),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }

  onCategoryTap(String name, int categoryId) {}

  isFiltered() {
    if (priceRange.value > 0.0) {}
  }
}
