import 'dart:developer';

import 'package:america/constants.dart';
import 'package:america/controllers/AuthController.dart';
import 'package:america/models/Online.dart';
import 'package:america/utils/app_ui.dart';
import 'package:america/utils/empty_widget.dart';
import 'package:america/utils/main_services.dart';
import 'package:america/utils/space_widget2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'views/login_screen.dart';

class OnlinesScreen extends StatefulWidget {
  final List<Online>? onlines;
  const OnlinesScreen({super.key, this.onlines});

  @override
  State<OnlinesScreen> createState() => _OnlinesScreenState();
}

class _OnlinesScreenState extends State<OnlinesScreen> {
  Future<void> _launchInWebViewGoogleMap(Uri url) async {
    log(url.toString());
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
      webViewConfiguration: const WebViewConfiguration(
        enableJavaScript: true,
      ),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(left: 2.sp, top: 2.sp),
              child: Container(
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          )),
                    ),
                    SpaceWidth(width: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          "Shops",
                          style: TextStyle(fontSize: 25, color: Colors.black),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SpaceHeight(height: 10),
            widget.onlines == null || widget.onlines!.isEmpty
                ? EmptyWidget(hint: "No Shops")
                : Container(),
            ListView.builder(
                shrinkWrap: true, // Add this line
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.onlines == null ? 0 : widget.onlines!.length,
                itemBuilder: (context, index) {
                  Online location = widget.onlines![index];
                  return Padding(
                    padding:
                        EdgeInsets.only(right: 2.sp, left: 2.sp, top: 2.sp),
                    child: Container(
                      width: 30.sp,
                      height: 26.sp,
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              width: Constants.getWidth(context) * 0.9,
                              height: 18.sp,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                // Set the background color
                                border: Border.all(
                                  color:
                                      Color(0xffffbc4c), // Set the border color
                                  width: 3.0, // Set the border width
                                ),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(3.sp),
                                    topLeft: Radius.circular(3.sp),
                                    bottomLeft: Radius.circular(3.sp)),
                              ),
                              child: Container(
                                padding:
                                    EdgeInsets.only(right: 2.sp, left: 15.sp),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          log(location.link.toString());
                                          final Uri toLaunchGoogleMap =
                                              Uri.parse(location.link);
                                          _launchInWebViewGoogleMap(
                                              toLaunchGoogleMap);
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                width: 30.sp,
                                                child: Text(
                                                  "${location.name}",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 4.sp),
                                                )),
                                            Text(
                                              "Shop Now",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 3.sp,
                                                  color: Color(0xffffbc4c)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xffffbc4c)),
                                        child: Container(
                                          child: Center(
                                            child: IconButton(
                                                onPressed: () {
                                                  final Uri toLaunchGoogleMap =
                                                      Uri.parse(location.link);
                                                  _launchInWebViewGoogleMap(
                                                      toLaunchGoogleMap);
                                                },
                                                icon: RotatedBox(
                                                    quarterTurns: 2,
                                                    child: Icon(
                                                      Icons.arrow_back_rounded,
                                                      color: Colors.white,
                                                      size: 5.sp,
                                                    ))),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 0,
                              left: 3.sp,
                              child: Container(
                                width: 12.sp,
                                height: 12.sp,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffffbc4c)),
                                child: Container(
                                  child: Center(
                                    child: SvgPicture.asset(
                                      "assets/images/shop_now.svg",
                                      width: 5.sp,
                                      height: 5.sp,
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  );
                }),
          ]),
        ),
      ),
    );
  }
}
