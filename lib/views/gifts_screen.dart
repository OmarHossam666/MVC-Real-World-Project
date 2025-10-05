import 'dart:developer';
import 'dart:io';

import 'package:america/constants.dart';
import 'package:america/controllers/CouponController.dart';
import 'package:america/models/Coupon.dart';
import 'package:america/models/Gifts.dart';
import 'package:america/models/MyResponse.dart';
import 'package:america/services/navigator_utils.dart';
import 'package:america/utils/app_ui.dart';
import 'package:america/utils/empty_widget.dart';
import 'package:america/views/clippedScreen.dart';
import 'package:america/views/clipped_gift_screen.dart';
import 'package:america/views/homeScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:america/AppTheme.dart';
import 'package:america/AppThemeNotifier.dart';
import 'package:america/api/api_util.dart';
import 'package:america/services/AppLocalizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/AuthController.dart';
import 'login_screen.dart';

class GiftsScreen extends StatefulWidget {
  const GiftsScreen({super.key});

  @override
  _GiftsScreenState createState() => _GiftsScreenState();
}

class _GiftsScreenState extends State<GiftsScreen>
    with SingleTickerProviderStateMixin {
  //Theme Data
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;

  bool isInProgress = false;

  List<Gift>? gifts;

  List<Gift>? giftsClipped;

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    getGifts();
    getClippedGifts();

    checkToken();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  checkToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString("token") == null) {
      pushReplacementScreen(context, LoginScreen());
    }
  }

  getGifts() async {
    setState(() {
      isInProgress = true;
    });

    MyResponse<List<Gift>> myResponse = await CouponController.getClipGifts();

    if (myResponse.success) {
      gifts = myResponse.data;
    } else {
      print("coupons er");
    }

    setState(() {
      isInProgress = false;
    });
  }

  Future getClippedGifts() async {
    setState(() {
      isInProgress = true;
    });

    MyResponse<List<Gift>> myResponse =
        await CouponController.getClippedGifts();

    if (myResponse.success) {
      // log("coupons done12");
      //  log(myResponse.data.toString());
      giftsClipped = myResponse.data;
    } else {
      log("coupons clipped er");
    }

    setState(() {
      isInProgress = false;
    });
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
            IconButton(
                onPressed: () {
                  getGifts();
                  getClippedGifts();
                },
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                )),
            //             IconButton(
            //  onPressed: (){
            //   AuthController.logoutUser();
            //   pushReplacementScreen(context, LoginScreen());
            //  },
            //  icon: Icon(Icons.logout,color: Colors.white,)),
          ],
        ),
        body: SingleChildScrollView(
            child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                controller: tabController,
                tabs: [
                  Tab(text: 'Unclipped'),
                  Tab(text: 'Clipped'),
                ],
              ),
              SizedBox(
                height: Constants.getHeight(context) * 0.8,
                child: TabBarView(
                  controller: tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    gifts == null || gifts!.isEmpty
                        ? EmptyWidget(
                            hint: "There Are No Gifts Currently Available Now")
                        : isInProgress
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.redAccent,
                                ),
                              )
                            : ListView.builder(
                                //  shrinkWrap: true, // Add this line
                                //   physics: NeverScrollableScrollPhysics(),
                                itemCount: gifts!.length,
                                itemBuilder: (context, index) {
                                  if (gifts == null) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.redAccent,
                                      ),
                                    );
                                  }
                                  Gift gift = gifts![index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Image.asset(
                                          "assets/images/gift.png",
                                          width: 100,
                                          height: 100,
                                        )),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${gift.name}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                    color: Colors.redAccent),
                                              ),

                                              gift.price == null
                                                  ? Container()
                                                  : Row(
                                                      children: [
                                                        Text(
                                                          gift.price.toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 25,
                                                              color: Colors
                                                                  .redAccent),
                                                        ),
                                                      ],
                                                    ),
                                              // SizedBox(
                                              //   width: 30.sp,
                                              //   child: RichText(
                                              //     text: TextSpan(
                                              //       text:
                                              //           "${coupon.priceAfterDiscount.toString()}" +
                                              //               "  ",
                                              //       style: TextStyle(
                                              //           fontWeight:
                                              //               FontWeight.bold,
                                              //           color: Colors.green,
                                              //           fontSize: 4.5.sp),
                                              //       children: <TextSpan>[
                                              //         TextSpan(
                                              //           text: coupon.price,
                                              //           style: TextStyle(
                                              //               fontWeight:
                                              //                   FontWeight.bold,
                                              //               fontSize: 25,
                                              //               color: Colors.black,
                                              //               decoration:
                                              //                   TextDecoration
                                              //                       .lineThrough),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),
                                              Text(
                                                "Valid : ${DateFormat('MMM d, yyyy,').format(gift.startAt!)} - ${DateFormat('MMM d, yyyy,').format(gift.endAt!)}",
                                                style: TextStyle(
                                                    color: Colors.redAccent,
                                                    fontSize: 16),
                                              ),
                                              // Text(
                                              //   "${gift.description}",
                                              //   overflow: TextOverflow
                                              //       .ellipsis, // This will add an ellipsis (...) when the text overflows
                                              //   maxLines: 2,
                                              // ),
                                              // ShowMoreText(
                                              //   text: gift.terms.toString(),
                                              //   maxLines: 2,
                                              // ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            log(gift.id.toString());
                                            CouponController.movGiftToClipped(
                                                    context,
                                                    giftId: gift.id)
                                                .then((value) {
                                              getClippedGifts().then((value) {
                                                tabController.animateTo(1);
                                              });
                                            });
                                          },
                                          icon: Icon(
                                            MdiIcons.scissorsCutting,
                                            color: Colors.red,
                                            size: 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                    giftsClipped == null || giftsClipped!.isEmpty
                        ? SizedBox(
                            height: Constants.getHeight(context) * 0.7,
                            child: EmptyWidget(
                                hint:
                                    "There Are No Gift Currently Available Now"))
                        : isInProgress
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.redAccent,
                                ),
                              )
                            : ListView.builder(
                                // shrinkWrap: true, // Add this line
                                // physics: NeverScrollableScrollPhysics(),
                                itemCount: giftsClipped!.length,
                                itemBuilder: (context, index) {
                                  if (giftsClipped == null) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  Gift gift = giftsClipped![index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Image.asset(
                                          "assets/images/gift.png",
                                          width: 100,
                                          height: 100,
                                        )),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${gift.name}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              gift.price == null
                                                  ? Container()
                                                  : Row(
                                                      children: [
                                                        Text(
                                                          gift.price.toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 25,
                                                              color: Colors
                                                                  .redAccent),
                                                        ),
                                                      ],
                                                    ),
                                              Text(
                                                "Valid : ${DateFormat('MMM d, yyyy,').format(gift.startAt!)} - ${DateFormat('MMM d, yyyy,').format(gift.startAt!)}",
                                                style: TextStyle(
                                                    color: Colors.redAccent,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            pushScreen(
                                                context,
                                                ClippedGiftScreen(
                                                  gift: gift,
                                                  onFinish: () {
                                                    pushReplacementScreen(
                                                        context, HomeScreen());
                                                    pushScreen(
                                                        context, GiftsScreen());
                                                    getGifts();
                                                    getClippedGifts();
                                                  },
                                                ));
                                          },
                                          icon: Icon(
                                            MdiIcons.scissorsCutting,
                                            color: Colors.red,
                                            size: 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                  ],
                ),
              ),
            ],
          ),
        )),
      );
    });
  }
}

class ShowMoreText extends StatefulWidget {
  final String text;
  final int maxLines;

  const ShowMoreText({super.key, required this.text, this.maxLines = 2});

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
