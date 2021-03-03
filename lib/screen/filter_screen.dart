import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/home_bloc.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_button.dart';
import 'package:zaincart_app/widgets/zc_text.dart';
import 'package:zaincart_app/widgets/zc_textformfield.dart';

class FilterScreen extends StatefulWidget {
  final String orderId;

  FilterScreen({this.orderId});
  @override
  State<StatefulWidget> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  bool isLoading = false;
  TextEditingController _reasonController = new TextEditingController();

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
      body: Consumer<HomeBloc>(
          builder: (context, homeBloc, child) => Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpansionTile(
                title: ZCText(
                  text:"Grocery",
                  color: Constants.zc_orange,
                  
                ),
                children: <Widget>[
                  ZCText(text: "Pulses(4)",),
                  ZCText(text: "Rice&Flour(7)",),
                  ZCText(text: "DryFruits & Nuts(5)",),
                  ZCText(text: "Salt & Sugar(2)",),

                ],
              ),
              ExpansionTile(
                title: ZCText(
                  text:"Price",
                  semiBold: true,
                  
                ),
                children: <Widget>[
                 
                ],
              ),
SizedBox(height: 30.0,),
              ExpansionTile(
                title: ZCText(
                  text:"Category",
                  color: Constants.zc_orange,
                  
                ),
                children: <Widget>[
                  

                ],
              ),
            ],
          ))),
    );
  }
}
