import 'dart:developer';

import 'package:america/constants.dart';
import 'package:america/controllers/AuthController.dart';
import 'package:america/utils/app_ui.dart';
import 'package:america/utils/empty_widget.dart';
import 'package:america/utils/main_services.dart';
import 'package:america/utils/space_widget2.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/Location.dart';
import '../services/navigator_utils.dart';
import 'login_screen.dart';

class LocationsScreen extends StatefulWidget {
  final List<Locations>? locations;
  const LocationsScreen({super.key, this.locations});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  Future<void> _launchInWebViewGoogleMap(Uri url) async {
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
                          "Locations",
                          style: TextStyle(fontSize: 25, color: Colors.black),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SpaceHeight(height: 10),
            widget.locations == null || widget.locations!.isEmpty
                ? EmptyWidget(hint: "No Locations")
                : Container(),
            ListView.builder(
                shrinkWrap: true, // Add this line
                physics: NeverScrollableScrollPhysics(),
                itemCount:
                    widget.locations == null ? 0 : widget.locations!.length,
                itemBuilder: (context, index) {
                  Locations location = widget.locations![index];
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
                              width: 70.sp,
                              height: 18.sp,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                // Set the background color
                                border: Border.all(
                                  color:
                                      Colors.redAccent, // Set the border color
                                  width: 3.0, // Set the border width
                                ),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(3.sp),
                                    topLeft: Radius.circular(3.sp),
                                    bottomLeft: Radius.circular(3.sp)),
                              ),
                              child: Container(
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SpaceWidth(width: 16),
                                      InkWell(
                                        onTap: () {
                                          final Uri toLaunchGoogleMap = Uri.parse(
                                              "https://www.google.com/maps/search/?api=1&query=${location.lat},${location.lng}");
                                          _launchInWebViewGoogleMap(
                                              toLaunchGoogleMap);
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: 35.sp,
                                                child: Text(
                                                  "${location.name} asfasfsafasfasfasf",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 4.sp),
                                                )),
                                            Text(
                                              "Open Location",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 3.sp,
                                                  color: Colors.redAccent),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    callNumber(location.phone);
                                                  },
                                                  icon: Icon(
                                                    Icons.call,
                                                    color: Colors.red,
                                                    size: 6.sp,
                                                  )),
                                            ],
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
                                    shape: BoxShape.circle, color: Colors.red),
                                child: Container(
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/map_icon.png",
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
