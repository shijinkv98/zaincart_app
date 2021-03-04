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
  var priceRange = ValueNotifier(0.0);

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
      body: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: Consumer<HomeBloc>(
            builder: (context, homeBloc, child) => Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExpansionTile(
                      title: ZCText(
                        text: homeBloc.categories
                            .where((e) =>
                                e.categoryId == homeBloc.selectedCategoryId)
                            .first
                            .categoryName,
                        color: Constants.zc_orange,
                      ),
                      children: homeBloc.categories
                          .where((e) =>
                              e.categoryId == homeBloc.selectedCategoryId)
                          .first
                          .subcategory
                          .map((e) => InkWell(
                                onTap: () {
                                  homeBloc.selectedSubCategoryId = e.categoryId;
                                  homeBloc.getProductsByCategory(
                                      context: context,
                                      categoryId: e.categoryId,
                                      pageNo: "1");
                                  Navigator.of(context).pop();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40.0, top: 3.0, bottom: 3.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: ZCText(
                                      text: e.categoryName,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    ExpansionTile(
                      title: ZCText(
                        text: "Price",
                        semiBold: true,
                      ),
                      children: <Widget>[
                        ValueListenableBuilder(
                            valueListenable: priceRange,
                            builder: (context, range, child) => Column(
                                  children: [
                                    ZCText(text: "QAR: ${range.toInt().toString()}",),
                                    SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        valueIndicatorColor: Colors.blue,
                                        inactiveTrackColor:
                                            Constants.zc_font_light_grey,
                                        activeTrackColor: Constants.zc_orange,
                                        thumbColor: Constants.zc_orange,
                                        overlayColor: Color(0x29EB1555),
                                        thumbShape: RoundSliderThumbShape(
                                            enabledThumbRadius: 15.0),
                                        overlayShape: RoundSliderOverlayShape(
                                            overlayRadius: 20.0),
                                      ),
                                      child: Slider(
                                        value: range,
                                        onChanged: (price) {
                                          print(price);
                                          priceRange.value = price;
                                        },
                                        min: 0.0,
                                        max: 40.0,
                                        label: range.toString(),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ZCText(
                                          text: "QAR:00",
                                          fontSize: kSmallFontSize,
                                        ),
                                        ZCText(
                                          text: "QAR:40",
                                          fontSize: kSmallFontSize,
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    ExpansionTile(
                      title: ZCText(
                        text: "Category",
                        color: Constants.zc_orange,
                      ),
                      children: homeBloc.categories
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  e.image,
                                  fit: BoxFit.cover,
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ))),
      ),
    );
  }

  isFiltered() {
    if (priceRange.value > 0.0){
      
    }
  }
}
