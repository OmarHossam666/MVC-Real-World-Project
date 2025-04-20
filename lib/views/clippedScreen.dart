import 'dart:developer';
import 'dart:io';

import 'package:america/constants.dart';
import 'package:america/models/Coupon.dart';
import 'package:america/utils/app_ui.dart';
import 'package:america/widgets/counter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:america/AppTheme.dart';
import 'package:america/AppThemeNotifier.dart';
import 'package:america/api/api_util.dart';
import 'package:america/services/AppLocalizations.dart';

import '../controllers/AuthController.dart';
import '../controllers/CouponController.dart';
import '../models/MyResponse.dart';
import '../services/navigator_utils.dart';
import 'login_screen.dart';

class ClippedScreen extends StatefulWidget {
  final ClippedCoupons coupon;
  final Function() onFinish;

  const ClippedScreen(
      {super.key, required this.coupon, required this.onFinish});
  @override
  _ClippedScreenState createState() => _ClippedScreenState();
}

class _ClippedScreenState extends State<ClippedScreen> {
  //Theme Data
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;

  bool isInProgress = false;

  dynamic couponExpir;

  bool isDone = false;
  Duration calculateRemainingTime(DateTime start, DateTime end) {
    DateTime now = DateTime.now();

    if (now.isBefore(start)) {
      // If the current time is before the start time, show the full duration.
      return end.difference(start);
    } else if (now.isAfter(end)) {
      // If the current time is after the end time, show zero duration.
      return Duration.zero;
    } else {
      // Calculate the remaining time.
      return end.difference(now);
    }
  }

  checkCoupon() async {
    setState(() {
      isInProgress = true;
    });

    MyResponse<dynamic> myResponse =
        await CouponController.checkExpir(context, couponId: widget.coupon.id);

    if (myResponse.success) {
      print("coupons done12");
      log("data: " + myResponse.data.toString());
      couponExpir = myResponse.data;
    } else {
      print("coupons er");
    }

    setState(() {
      isInProgress = false;
    });
  }

  @override
  void initState() {
    checkCoupon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeNotifier>(
        builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
      int themeType = value.themeMode();
      themeData = AppTheme.getThemeFromThemeMode(themeType);
      customAppTheme = AppTheme.getCustomAppTheme(themeType);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
            ),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    )),
                Text(
                  "Welcome",
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
          leadingWidth: 200,
          actions: [
            //            IconButton(
            //  onPressed: (){
            //   AuthController.logoutUser();
            //   pushReplacementScreen(context, LoginScreen());
            //  },
            //  icon: Icon(Icons.logout,color: Colors.white,))
          ],
        ),
        body: SingleChildScrollView(
            child: isInProgress
                ? Container(
                    width: Constants.getWidth(context),
                    height: Constants.getHeight(context),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.redAccent,
                      ),
                    ),
                  )
                : isDone
                    ? Container(
                        width: Constants.getWidth(context),
                        height: Constants.getHeight(context),
                        child: Center(
                            child: Text(
                          "Coupon Time is Ended",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.redAccent),
                        )),
                      )
                    : couponExpir["timeRemaining"] == null ||
                            couponExpir["timeRemaining"] == 0
                        ? Container(
                            width: Constants.getWidth(context),
                            height: Constants.getHeight(context),
                            child: Center(
                                child: Text(
                              "This Coupon is not available right now",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.redAccent),
                            )),
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      widget.coupon.photo.toString(),
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${widget.coupon.name}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.redAccent),
                                          ),
                                          // Text("Price After Discount",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.redAccent),),
                                          Row(
                                            children: [
                                              Text(
                                                "${widget.coupon.priceAfterDiscount}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                    color: Colors.redAccent),
                                              ),
                                              SizedBox(
                                                width: 2.sp,
                                              ),
                                              Text(
                                                "${widget.coupon.price}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                    color: Colors.black,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              ),
                                            ],
                                          ),

                                          Text(
                                            "Valid : ${DateFormat('MMM d, yyyy, hh:mm a').format(DateTime.parse(widget.coupon.startAt!))} - ${DateFormat('MMM d, yyyy, hh:mm a').format(DateTime.parse(widget.coupon.endAt!))}",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                            "${widget.coupon.description}",
                                            overflow: TextOverflow
                                                .ellipsis, // This will add an ellipsis (...) when the text overflows
                                            maxLines: 2,
                                          ),

                                          ShowMoreText(
                                            text:
                                                widget.coupon.terms.toString(),
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: CountdownContainer(
                                  duration: Duration(
                                      minutes: couponExpir["timeRemaining"]),
                                  onFinish: () {
                                    isDone = true;
                                    setState(() {
                                      widget.onFinish();
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Image.network(
                                widget.coupon.barcode.toString(),
                                width: Constants.getWidth(context) * 0.8,
                                height: Constants.getHeight(context) * 0.15,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${widget.coupon.bardcodeNumber} ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )),
      );
    });
  }
}

class ShowMoreText extends StatefulWidget {
  final String text;
  final int maxLines;

  ShowMoreText({required this.text, this.maxLines = 2});

  @override
  _ShowMoreTextState createState() => _ShowMoreTextState();
}

class _ShowMoreTextState extends State<ShowMoreText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Align the content to the left
      children: <Widget>[
        if (!_isExpanded)
          TextButton(
            onPressed: () {
              setState(() {
                _isExpanded = true;
              });
            },
            child: Text('Show More'),
          ),
        if (_isExpanded)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.text,
                maxLines: null,
                overflow: TextOverflow.visible,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = false;
                  });
                },
                child: Text('Show Less'),
              ),
            ],
          ),
      ],
    );
  }
}
