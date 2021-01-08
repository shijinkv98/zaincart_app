import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150.0,
                color: Colors.green,
              ),
              Container(
                height: 220.0,
                decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(35),
                            bottomRight: Radius.circular(35))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Container(
                        height: 35.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10,),
                    new ZCText(text: "WHAT ARE YOU LOOKING FOR?", color: Colors.white, semiBold: true,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
