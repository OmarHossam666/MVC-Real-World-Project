import 'package:america/constants.dart';
import 'package:america/controllers/WeeklyAdController.dart';
import 'package:america/models/MyResponse.dart';
import 'package:america/models/WeeklyAd.dart';
import 'package:america/utils/app_ui.dart';
import 'package:america/utils/empty_widget.dart';
import 'package:america/views/image_preview_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_state.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:america/AppTheme.dart';
import 'package:america/AppThemeNotifier.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_widget/zoom_widget.dart';

import '../controllers/AuthController.dart';
import '../services/navigator_utils.dart';
import 'login_screen.dart';

class WeeklyAdsScreen extends StatefulWidget {
  @override
  _WeeklyAdsScreenState createState() => _WeeklyAdsScreenState();
}

class _WeeklyAdsScreenState extends State<WeeklyAdsScreen> {
  //Theme Data
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;

  bool isInProgress = false;

  List<WeeklyAd>? weeklyAds;

  @override
  void initState() {
    super.initState();
    getWeekly();
  }

  getWeekly() async {
    if (mounted) {
      setState(() {
        isInProgress = true;
      });
    }

    MyResponse<List<WeeklyAd>> myResponse =
        await WeeklyAdController.getAllWeeklyAd();

    if (myResponse.success) {
      print("weeklyAds done12");
      print(myResponse.data);
      weeklyAds = myResponse.data;
    } else {
      print("weeklyAds er");
    }

    if (mounted) {
      setState(() {
        isInProgress = false;
      });
    }
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
            //             IconButton(
            //  onPressed: (){
            //   AuthController.logoutUser();
            //   pushReplacementScreen(context, LoginScreen());
            //  },
            //  icon: Icon(Icons.logout,color: Colors.white,))
          ],
        ),
        body:

            //             Container(
            //   child: PhotoViewGallery.builder(
            //     backgroundDecoration: BoxDecoration(color: Colors.transparent),
            //     scrollPhysics: const BouncingScrollPhysics(),
            //     builder: (BuildContext context, int index) {
            //       return PhotoViewGalleryPageOptions(
            //         imageProvider: NetworkImage(weeklyAds![index].photo!),
            //         initialScale: PhotoViewComputedScale.contained * 0.8,
            //        // heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index].id),
            //       );
            //     },
            //     itemCount: weeklyAds!.length,
            //     loadingBuilder: (context, event) => Center(
            //       child: Container(
            //         // width: 20.0,
            //         // height: 20.0,
            //         // child: CircularProgressIndicator(
            //         //   // value: event == null
            //         //   //     ? 0
            //         //   //     : event.cumulativeBytesLoaded / event.expectedTotalBytes,
            //         // ),
            //       ),
            //     ),

            //   )
            // )

            isInProgress
                ? Container(
                    width: Constants.getWidth(context),
                    height: Constants.getHeight(context),
                    child: SizedBox(
                      height: 30.sp,
                      width: 30.sp,
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Colors.redAccent,
                      )),
                    ),
                  )
                : weeklyAds == null || weeklyAds!.isEmpty
                    ? EmptyWidget(hint: "New Ad Coming Soon!")
                    : CarouselSlider(
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          height: Constants.getHeight(context),
                        ),

                        items: weeklyAds!.map((WeeklyAd weeklyAd) {
                          return Builder(builder: (BuildContext context) {
                            return Container(
                              width: Constants.getWidth(context),
                              height: Constants.getHeight(context),
                              child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return Container(
                                          height: Constants.getHeight(context),
                                          color: Colors.white,
                                          child: Center(
                                            child: ImagePreviewScreen(
                                                imageUrl:
                                                    weeklyAd.photo.toString()),
                                          ),
                                        );
                                      },
                                    );
                                    // pushScreen(context, ImagePreviewScreen(imageUrl: weeklyAd.photo.toString()));
                                  },
                                  child: Image.network(
                                    weeklyAd.photo.toString(),
                                    fit: BoxFit.fill,
                                  )),
                            );
                          });
                        }).toList(),

                        // SizedBox(
                        //   height: 400,
                        //    child: SfPdfViewer.network(
                        //      weeklyAd.pdf,
                        //      enableDoubleTapZooming: true, // Enable double-tap to zoom
                        //    ));
                      ),
      );
    });
  }
}

openUrl(cVUrl) async {
  final url = Uri.parse(cVUrl);
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    // <--
    throw Exception('Could not launch $url');
  }
}
