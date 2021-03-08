import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/home_bloc.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_appbar_title.dart';
import 'package:zaincart_app/widgets/zc_button.dart';
import 'package:zaincart_app/widgets/zc_text.dart';
import 'package:zaincart_app/widgets/zc_textformfield.dart';

class AddReviewScreen extends StatefulWidget {
  final double rating;

  AddReviewScreen({this.rating});
  @override
  State<StatefulWidget> createState() {
    return _AddReviewScreenState();
  }
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  bool isLoading = false;
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ZCAppBarTitle("REVIEW"),
        backgroundColor: Colors.white,
        leading: Builder(
            builder: (BuildContext context) => Padding(
                  padding: EdgeInsets.only(left: 0.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Constants.zc_font_black,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0),
                  ZCText(
                    text: "Add your review",
                    fontSize: kTitleFontSize,
                    semiBold: true,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RatingBar.builder(
                    initialRating: widget.rating,
                    itemSize: 15.0,
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
                  SizedBox(height: 30.0),
                  SizedBox(height: 40.0),
                  ZCTextFormField(
                    hintText: "Title",
                    controller: _titleController,
                    
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ZCTextFormField(
                    hintText: "Description",
                    controller: _descriptionController,
                    maxLines: null,
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: ZCButton(
                        title: "SUBMIT",
                        onPressed: () {},
                      )),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                          child: ZCButton(
                        title: "BACK",
                        color: Colors.white,
                        border: true,
                        titleColor: Constants.zc_font_grey,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ))
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
