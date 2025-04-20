import 'dart:developer';
import 'dart:io';

import 'package:america/constants.dart';
import 'package:america/models/Coupon.dart';
import 'package:america/models/Gifts.dart';
import 'package:america/utils/app_ui.dart';
import 'package:america/utils/space_widget2.dart';
import 'package:america/widgets/counter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:america/AppTheme.dart';
import 'package:america/AppThemeNotifier.dart';
import '../controllers/CouponController.dart';
import '../models/MyResponse.dart';

class ClippedGiftScreen extends StatefulWidget {
  final Gift gift;
  final Function() onFinish;

  const ClippedGiftScreen(
      {super.key, required this.gift, required this.onFinish});
  @override
  _ClippedGiftScreenState createState() => _ClippedGiftScreenState();
}

class _ClippedGiftScreenState extends State<ClippedGiftScreen> {
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
        await CouponController.checkExpirGift(context, giftId: widget.gift.id);

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
                          "Gift Time is Ended",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.redAccent),
                        )),
                      )
                    : couponExpir["time_remaining"] == null
                        ? Container(
                            width: Constants.getWidth(context),
                            height: Constants.getHeight(context),
                            child: Center(
                                child: Text(
                              "This Gift is not available right now",
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
                                child: Container(
                                  padding: EdgeInsets.all(7.sp),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[300],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      widget.gift.price == null
                                          ? Container()
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  widget.gift.price.toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 7.sp,
                                                      color: Colors.yellow),
                                                ),
                                              ],
                                            ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/giftbox.png",
                                            height: 20.sp,
                                            width: 20.sp,
                                          ),
                                          SpaceWidth(width: 5),
                                          Text(
                                            "GIFT CARD",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 6.sp),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SpaceHeight(height: 10),
                              Padding(
                                padding: EdgeInsets.all(3.sp),
                                child: Container(
                                  padding: EdgeInsets.all(3.sp),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.red[700]!, // Border color
                                      width: 2, // Border width
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Time Left : ${couponExpir["time_remaining"].toString()}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Image.network(
                                widget.gift.barcode.toString(),
                                width: Constants.getWidth(context) * 0.8,
                                height: Constants.getHeight(context) * 0.15,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${widget.gift.barcodeNumber} ",
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
