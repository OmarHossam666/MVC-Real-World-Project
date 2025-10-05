import 'dart:developer';

import 'package:america/constants.dart';
import 'package:america/models/Social.dart';
import 'package:america/utils/app_ui.dart';
import 'package:america/utils/empty_widget.dart';
import 'package:america/utils/space_widget2.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialScreen extends StatefulWidget {
  final List<Social>? socials;
  const SocialScreen({super.key, this.socials});

  @override
  State<SocialScreen> createState() => _OnlinesScreenState();
}

class _OnlinesScreenState extends State<SocialScreen> {
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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 2.sp, top: 2.sp),
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
                          "Social Media",
                          style: TextStyle(fontSize: 25, color: Colors.black),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
              SpaceHeight(height: 10),
              widget.socials == null || widget.socials!.isEmpty
                  ? EmptyWidget(hint: "No Socials")
                  : Container(),
              ListView.builder(
                shrinkWrap: true, // Add this line
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.socials == null ? 0 : widget.socials!.length,
                itemBuilder: (context, index) {
                  Social location = widget.socials![index];
                  return Padding(
                    padding:
                        EdgeInsets.only(right: 2.sp, left: 2.sp, top: 2.sp),
                    child: SizedBox(
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
                                      Colors.blueAccent, // Set the border color
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
                                            SizedBox(
                                                width: 30.sp,
                                                child: Text(
                                                  location.name,
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
                                                  color: Colors.blueAccent),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blueAccent),
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
                            child: SizedBox(
                              width: 12.sp,
                              height: 12.sp,
                              // decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.blueAccent),
                              child: Center(
                                child: Image.network(
                                  location.photo,
                                  width: 9.sp,
                                  height: 9.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
