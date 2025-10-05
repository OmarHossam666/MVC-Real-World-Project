import 'dart:developer';
import 'dart:ui';

import 'package:america/constants.dart';
import 'package:america/controllers/AuthController.dart';
import 'package:america/controllers/BannerController.dart';
import 'package:america/controllers/Branches_Controller.dart';
import 'package:america/controllers/CategoeriesController.dart';
import 'package:america/controllers/LocationController.dart';
import 'package:america/controllers/OnlineController.dart';
import 'package:america/controllers/SettingController.dart';
import 'package:america/controllers/SocialController.dart';
import 'package:america/models/Banners.dart';
import 'package:america/models/Catogry.dart';
import 'package:america/models/Location.dart';
import 'package:america/models/MyResponse.dart';
import 'package:america/models/Online.dart';
import 'package:america/models/QrCood.dart';
import 'package:america/models/Setting.dart';
import 'package:america/models/Social.dart';
import 'package:america/onlines_screen.dart';
import 'package:america/services/navigator_utils.dart';
import 'package:america/utils/app_ui.dart';
import 'package:america/utils/space_widget2.dart';
import 'package:america/views/branches_screen.dart';

import 'package:america/views/careers_screen.dart';
import 'package:america/views/couponsScreen.dart';
import 'package:america/views/gifts_screen.dart';
import 'package:america/views/locationScreen.dart';
import 'package:america/views/login_screen.dart';
import 'package:america/views/productScreen.dart';
import 'package:america/views/profile_screen.dart';

import 'package:america/views/socials_screen.dart';
import 'package:america/views/weeklyAdsScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:america/AppTheme.dart';
import 'package:america/AppThemeNotifier.dart';
import 'package:america/api/api_util.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/space_widget.dart';
import 'LocationsScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Theme Data
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;

  bool isInProgress = false;
  late Map<String, Function> actionMap;
  List<Banners>? banners;
  List<Setting>? settings;
  List<Locations>? locations;
  List<Social>? socials;
  List<Online>? onlines;
  List<CategoryModel>? categories;

  QrModel? qrModel;

  bool loadedQr = false;

  int currentIndex = 0;

  bool isLoading = false;
  Map<String, Widget> tableScreenMap = {
    "product": ProductScreen(),
    "coupon": CouponsScreen(),
    "weekly": WeeklyAdsScreen(),
    // Add more mappings as needed
  };

  initData() async {
    isLoading = true;

    setState(() {});
    getQrCood();
    await getBanners();
    await getSettings();
    await getLocations();
    await getSocials();

    await getOnlines();

    // Initialize actionMap here in the initState method
    actionMap = {
      "location": () {
        if (locations!.first.lng != null) {
          final Uri toLaunchGoogleMap = Uri.parse(
              "https://www.google.com/maps/search/?api=1&query=${locations!.first.lat},${locations!.first.lng}");
          _launchInWebViewGoogleMap(toLaunchGoogleMap);
          return null; // Return null as no widget to display
        } else {
          return Text("Can't find lat and lng");
        }
      },
      "online": () {
        final Uri linkOnline = Uri.parse(onlines!.first.link);
        _launchInWebViewWithoutJavaScript(linkOnline);
        return null; // Return null as no widget to display
            },
      "social": () async {
        for (var setting in settings!) {
          if (setting.link != null) {
            final Uri toLaunch = Uri.parse(setting.link!);

            _launchInWebViewWithoutJavaScript(toLaunch);
          }
        }
        return null; // Return null as no widget to display
      },
    };
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

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

  Future<void> _launchInWebViewWithoutJavaScript(Uri url) async {
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

  getQrCood() async {
    MyResponse<QrModel> myResponse = await SocialController.getAllQrcood();

    if (myResponse.success) {
      print("qr done12");
      print(myResponse.data);
      qrModel = myResponse.data;
      loadedQr = true;
      setState(() {});
    } else {
      print("qr er");
    }
  }

  getBanners() async {
    if (mounted) {
      setState(() {
        isInProgress = true;
      });
    }

    MyResponse<List<Banners>> myResponse =
        await BannerController.getAllBanners();

    if (myResponse.success) {
      print("banners done12");
      print(myResponse.data);
      banners = myResponse.data;
    } else {
      print("banners er");
    }

    if (mounted) {
      setState(() {
        isInProgress = false;
      });
    }
  }

  getSettings() async {
    if (mounted) {
      setState(() {
        isInProgress = true;
      });
    }

    MyResponse<List<Setting>> myResponse =
        await SettingController.getAllSetting();

    if (myResponse.success) {
      print("Setting done12");
      print(myResponse.data);
      settings = myResponse.data;

      settings!.add(Setting(id: 1000, table_name: "scan"));
      settings!.add(Setting(id: 10010, table_name: "branches"));
      //  settings!.add(Setting(id: 1001, table_name: "career"));
      // settings!.add(Setting(id: 1002, table_name: "gift"));
    } else {
      print("Setting er");
    }

    if (mounted) {
      setState(() {
        isInProgress = false;
      });
    }
  }

  getLocations() async {
    if (mounted) {
      setState(() {
        isInProgress = true;
      });
    }

    MyResponse<List<Locations>> myResponse =
        await LocationsController.getAllLocations();

    if (myResponse.success) {
      print("locations done12");
      log(myResponse.data.toString());
      locations = myResponse.data;
    } else {
      print("locations er");
    }

    if (mounted) {
      setState(() {
        isInProgress = false;
      });
    }
  }

  getSocials() async {
    if (mounted) {
      setState(() {
        isInProgress = true;
      });
    }

    MyResponse<List<Social>> myResponse = await SocialController.getAllSocial();

    if (myResponse.success) {
      print("socials done12");
      print(myResponse.data);
      socials = myResponse.data;
    } else {
      print("socials er");
    }

    if (mounted) {
      setState(() {
        isInProgress = false;
      });
    }
  }

  getOnlines() async {
    if (mounted) {
      setState(() {
        isInProgress = true;
      });
    }

    MyResponse<List<Online>> myResponse = await OnlineController.getAllOnline();

    if (myResponse.success) {
      print("onlines done12");
      log(myResponse.data.toString());
      onlines = myResponse.data;
    } else {
      print("onlines er");
    }

    if (mounted) {
      setState(() {
        isInProgress = false;
      });
    }
  }

  Future<void> showDeleteAccountConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Prevent users from dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(''),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    "are you sure you want to delete your account ?"), // Confirmation message
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("cancel"), // Cancel button
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text(
                "confirm",
                style: TextStyle(color: Colors.redAccent),
              ), // Confirm button
              onPressed: () {
                // Perform the delete account action here
                // You can add your logic for account deletion or any other action.
                // Once the action is completed, you can close the dialog.
                AuthController.deleteUser(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          height: Constants.getHeight(context) * 0.45,
          color: Colors.white,
          child: Center(
            child: SizedBox(
              width: 230,
              height: 230,
              child: SizedBox(
                width: 230,
                height: 230,
                child: SvgPicture.string(qrModel!.social![0].photo.toString()),
              ),
            ),
          ),
        );
      },
    );
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //      // title: Text('My Dialog'),
    //       content: ,

    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeNotifier>(
        builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
      int themeType = value.themeMode();
      themeData = AppTheme.getThemeFromThemeMode(themeType);
      customAppTheme = AppTheme.getCustomAppTheme(themeType);

      return SafeArea(
        child: Scaffold(
          //   floatingActionButton: loadedQr ==false ? Container() : FloatingActionButton(
          //     backgroundColor: Colors.white,
          //     onPressed: () {
          // // Show the dialog
          //   _showDialog();
          //     },
          //     child: Icon(Icons.qr_code_2,size: 30,color: Colors.black,),
          //   ),
          //  appBar: AppBar(
          //    backgroundColor: Colors.red,
          //    leading:  Padding(
          //      padding: const EdgeInsets.only(left: 20.0,),
          //      child: Text("Welcome",style: TextStyle(fontSize: 25),),
          //    ),
          //    leadingWidth: 200,
          //    actions: [
          //      IconButton(
          //          onPressed: (){
          //           AuthController.logoutUser();
          //           pushReplacementScreen(context, LoginScreen());
          //          },
          //          icon: Icon(Icons.logout,color: Colors.white,))
          //    ],
          //  ),
          body: Stack(
            children: [
              SingleChildScrollView(
                  child: isLoading
                      ? SizedBox(
                          width: Constants.getWidth(context),
                          height: Constants.getHeight(context),
                          child: Center(
                            child: CircularProgressIndicator(
                                color: Colors.redAccent),
                          ),
                        )
                      : Stack(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            Constants.getWidth(context) * 0.8,
                                        child: Text(
                                          "Welcome to ${BranchesController.selectedStoreName ?? ''} !",
                                          style: TextStyle(
                                            fontSize: 21,
                                            color: Color(0xffc7485f),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          // onlines != null
                                          //     ? InkWell(
                                          //         onTap: () {
                                          //           pushScreen(
                                          //               context,
                                          //               OnlinesScreen(
                                          //                 onlines: onlines,
                                          //               ));
                                          //         },
                                          //         child: SvgPicture.asset(
                                          //           "assets/images/shop_now.svg",
                                          //           width: 6.sp,
                                          //           height: 6.sp,
                                          //         ),
                                          //       )
                                          //     : Container(),
                                          SpaceWidth(width: 2),
                                          InkWell(
                                            onTap: () {
                                              pushScreen(
                                                  context, ProfileScreen());
                                              // showDeleteAccountConfirmationDialog(context);
                                            },
                                            child: Icon(
                                              Icons.account_circle,
                                              color: Colors.redAccent,
                                              size: 8.sp,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1.5,
                                  color: Color(0xffc7485f),
                                ),
                                Image.asset("assets/images/logo.png",
                                    width: Constants.getWidth(context),
                                    height: Constants.getHeight(context) * 0.3,
                                    fit: BoxFit.fill),
                                banners == null || banners!.isEmpty
                                    ? Container()
                                    : Divider(
                                        thickness: 1.5,
                                        color: Color(0xffc7485f),
                                      ),
                                banners == null || banners!.isEmpty
                                    ? Container()
                                    : Center(
                                        child: CarouselSlider.builder(
                                        itemCount: banners!.length,
                                        itemBuilder: (BuildContext context,
                                            int index, int realIndex) {
                                          Banners banner = banners![index];
                                          return FutureBuilder<void>(
                                            future:
                                                null, // Replace with the appropriate future if needed
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                // Future is still loading, show a loading indicator
                                                return CircularProgressIndicator();
                                              } else if (snapshot.hasError) {
                                                // Future completed with an error, show an error message
                                                print(
                                                    "Error: ${snapshot.error}");
                                                return Container(
                                                  child: Text(
                                                      "Failed to load image"),
                                                );
                                              } else {
                                                // Future completed successfully, show the image
                                                return ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 1.0),
                                                    child: Image.network(
                                                      banner.photo,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          );
                                        },
                                        options: CarouselOptions(
                                          height: Constants.getHeight(context) *
                                              0.25,
                                          autoPlay: true,
                                          enlargeCenterPage: true,
                                          aspectRatio: 16 / 9,
                                          autoPlayCurve: Curves.fastOutSlowIn,
                                          enableInfiniteScroll: true,
                                          autoPlayAnimationDuration:
                                              Duration(milliseconds: 900),
                                          viewportFraction: 0.94,
                                          onPageChanged: (index, reason) {
                                            currentIndex = index;
                                            setState(() {});
                                          },
                                        ),
                                      )),
                                Divider(
                                  thickness: 1.5,
                                  color: Color(0xffc7485f),
                                ),
                                banners == null || banners!.isEmpty
                                    ? Container()
                                    : DotsIndicator(
                                        dotsCount: banners!.length,
                                        position: currentIndex,
                                        decorator: DotsDecorator(
                                          color: Color(0xffc7485f),
                                          activeColor: Color(0xffc7485f),
                                          size: const Size.square(9.0),
                                          activeSize: const Size(18.0, 9.0),
                                          activeShape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                        ),
                                      ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 15.sp),
                                  child: Container(
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: settings!.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount:
                                                  2, // 3 boxes in each row
                                              childAspectRatio: 0.9,
                                              mainAxisSpacing: 1.4),
                                      itemBuilder: (context, index) {
                                        Setting setting = settings![index];

                                        String image = setting.table_name ==
                                                "career"
                                            ? "assets/images/careers.png"
                                            : setting.table_name == "gift"
                                                ? "assets/images/gift.png"
                                                : setting.table_name ==
                                                        "branches"
                                                    ? "assets/images/branch.png"
                                                    : setting.table_name ==
                                                            "weekly"
                                                        ? "assets/images/weekly_ads.png"
                                                        : setting.table_name ==
                                                                "product"
                                                            ? "assets/images/products_icon.png"
                                                            : setting.table_name ==
                                                                    "coupon"
                                                                ? "assets/images/coupon.png"
                                                                : setting.table_name ==
                                                                        "location"
                                                                    ? "assets/images/location.svg"
                                                                    : setting.table_name ==
                                                                            "social"
                                                                        ? "assets/images/social_media.png"
                                                                        : setting.table_name ==
                                                                                "scan"
                                                                            ? "assets/images/scan.png"
                                                                            : setting.table_name == "online"
                                                                                ? "assets/images/products.png"
                                                                                : "assets/images/weekly_ads.png";
                                        Color color = setting.table_name ==
                                                "career"
                                            ? Colors.blueAccent
                                            : setting.table_name == "gift"
                                                ? Colors.redAccent
                                                : setting.table_name ==
                                                        "branches"
                                                    ? Colors.pink
                                                    : setting.table_name ==
                                                            "weekly"
                                                        ? Color(0xfff32833)
                                                        : setting.table_name ==
                                                                "product"
                                                            ? Color(0xffffba4c)
                                                            : setting.table_name ==
                                                                    "coupon"
                                                                ? Color(
                                                                    0xff000190)
                                                                : setting.table_name ==
                                                                        "location"
                                                                    ? Color(
                                                                        0xff119201)
                                                                    : setting.table_name ==
                                                                            "social"
                                                                        ? Color(
                                                                            0xff0198e0)
                                                                        : setting.table_name ==
                                                                                "scan"
                                                                            ? Color(0xffec1fa0)
                                                                            : setting.table_name == "online"
                                                                                ? Color(0xfffb123c)
                                                                                : Colors.redAccent;
                                        Color moreColor = setting.table_name ==
                                                "weekly"
                                            ? Color(0xff4e9a63)
                                            : setting.table_name == "branches"
                                                ? Colors.pink
                                                : setting.table_name == "gift"
                                                    ? Color(0xffc7485f)
                                                    : setting.table_name ==
                                                            "product"
                                                        ? Color(0xffffba4c)
                                                        : setting.table_name ==
                                                                "coupon"
                                                            ? Color(0xff009fda)
                                                            : setting.table_name ==
                                                                    "location"
                                                                ? Color(
                                                                    0xfff24f04)
                                                                : setting.table_name ==
                                                                        "social"
                                                                    ? Color(
                                                                        0xfff9b751)
                                                                    : setting.table_name ==
                                                                            "scan"
                                                                        ? Color(
                                                                            0xff7401e0)
                                                                        : setting.table_name ==
                                                                                "online"
                                                                            ? Color(0xfffb123c)
                                                                            : Colors.redAccent;
                                        return BoxItem(
                                          text: setting.table_name == "career"
                                              ? "Careers"
                                              : setting.table_name == "branches"
                                                  ? "Stores"
                                                  : setting.table_name == "gift"
                                                      ? "Gifts"
                                                      : setting.table_name ==
                                                              "online"
                                                          ? "Shop Now"
                                                          : setting.table_name ==
                                                                  "weekly"
                                                              ? "Weekly Ad"
                                                              : setting.table_name ==
                                                                      "social"
                                                                  ? "Social Media"
                                                                  : setting.table_name ==
                                                                          "scan"
                                                                      ? "Scan & Share "
                                                                      : setting.table_name ==
                                                                              "product"
                                                                          ? "In Store Deals!"
                                                                          : setting.table_name == "location"
                                                                              ? "Locations"
                                                                              : setting.table_name == "coupon"
                                                                                  ? "Coupons"
                                                                                  : setting.table_name!,
                                          color: color,
                                          moreColor: moreColor,
                                          image: setting.table_name ==
                                                  "location"
                                              ? SvgPicture.asset(
                                                  image,
                                                  width: 18.sp,
                                                  height: 18.sp,
                                                )
                                              : setting.table_name == "social"
                                                  ? Image.asset(
                                                      image,
                                                      width: 18.sp,
                                                      height: 15.sp,
                                                    )
                                                  : Image.asset(
                                                      image,
                                                      width: 18.sp,
                                                      height: 18.sp,
                                                    ),
                                          onTap: () {
                                            if (setting.table_name ==
                                                "career") {
                                              pushScreen(
                                                  context, CareerScreen());
                                              return;
                                            }
                                            if (setting.table_name ==
                                                "branches") {
                                              pushScreen(
                                                  context, BranchesScreen());
                                              return;
                                            }
                                            if (setting.table_name == "gift") {
                                              pushScreen(
                                                  context, GiftsScreen());
                                              return;
                                            }
                                            if (setting.table_name ==
                                                "social") {
                                              pushScreen(
                                                  context,
                                                  SocialScreen(
                                                    socials: socials,
                                                  ));
                                              return;
                                            }
                                            if (setting.table_name ==
                                                "location") {
                                              pushScreen(
                                                  context,
                                                  LocationsScreen(
                                                    locations: locations,
                                                  ));
                                              return;
                                            }
                                            if (setting.table_name ==
                                                "online") {
                                              pushScreen(
                                                  context,
                                                  OnlinesScreen(
                                                    onlines: onlines,
                                                  ));
                                              return;
                                            }
                                            if (setting.table_name == "scan") {
                                              _showDialog();
                                              return;
                                            }
                                            if (actionMap.containsKey(
                                                setting.table_name)) {
                                              final result = actionMap[
                                                  setting.table_name]!();
                                              if (result != null &&
                                                  result is Widget) {
                                                // Display the widget (e.g., an error message)
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    content: result,
                                                  ),
                                                );
                                              }
                                            } else {
                                              if (tableScreenMap.containsKey(
                                                  setting.table_name)) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          tableScreenMap[setting
                                                              .table_name]!),
                                                );
                                              } else {
                                                // Handle cases where neither action nor screen matches
                                              }
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
              Positioned(
                  bottom: 4.sp,
                  right: 1.sp,
                  left: 1.sp,
                  child: Center(
                    child: Container(
                      width: 60.sp,
                      height: 10.sp,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.sp),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              pushReplacementScreen(context, HomeScreen());
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 5.sp,
                                  height: 5.sp,
                                  child: Image.asset(
                                    "assets/images/home_icon.png",
                                    color: Colors.white,
                                  ),
                                ),
                                const SpaceWidget(size: 0.5),
                              ],
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              pushScreen(context, CouponsScreen());
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 5.sp,
                                  height: 5.sp,
                                  child: Image.asset(
                                    "assets/images/cut.png",
                                    color: Colors.white,
                                  ),
                                ),
                                const SpaceWidget(size: 0.5),
                              ],
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              pushScreen(
                                  context,
                                  LocationsScreen(
                                    locations: locations,
                                  ));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 5.sp,
                                  height: 5.sp,
                                  child: Image.asset(
                                    "assets/images/map_icon.png",
                                    color: Colors.white,
                                  ),
                                ),
                                const SpaceWidget(size: 0.5),
                              ],
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              _showDialog();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 5.sp,
                                  height: 5.sp,
                                  child: Image.asset(
                                    "assets/images/qr_icon.png",
                                    color: Colors.white,
                                  ),
                                ),
                                const SpaceWidget(size: 0.5),
                              ],
                            ),
                          ),

                          // InkWell(
                          //     onTap: () {
                          //                       AuthController.logoutUser();
                          //         pushReplacementScreen(context, LoginScreen());
                          //   },

                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //        Container(
                          //             width:5.sp,
                          //         height:5.sp,

                          //         child: Image.asset("assets/images/logout.png",color: Colors.white,),
                          //       ),
                          //          const SpaceWidget(size: 0.5),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      );
    });
  }
}

class BoxItem extends StatelessWidget {
  final String text;
  final Color color;

  final Color moreColor;

  final Widget image;
  final VoidCallback onTap;

  const BoxItem(
      {super.key, required this.text,
      required this.color,
      required this.image,
      required this.onTap,
      required this.moreColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 2.sp,
              child: Container(
                width: 26.sp,
                height: 20.sp,
                decoration: BoxDecoration(
                  // Set the background color
                  border: Border.all(
                    color: color, // Set the border color
                    width: 3.0, // Set the border width
                  ),
                  borderRadius: BorderRadius.circular(6.sp),
                ),
                child: Center(
                  child: text == "scan"
                      ? Column(
                          children: [
                            SpaceHeight(height: 3),
                            Container(
                              width: 20.sp, // Adjust the width as needed
                              height: 20.sp,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)), // Adjust the height as needed
                              child: image,
                            )
                          ],
                        )
                      : image,
                ),
              ),
            ),

            Positioned(
              top: 20.sp,
              child: Container(
                width: 30.sp,
                height: 11.sp,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2.sp),
                        bottomRight: Radius.circular(2.sp))),
                child: Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            //   Positioned(
            //   top:27.sp,
            //   child: Container(
            //       width: 16.sp,
            //       height:6.sp,
            //           decoration: BoxDecoration(color: moreColor,),
            //       child: Center(
            //         child: Text(
            //        "View More",
            //           style: TextStyle(
            //             fontSize:16,
            //             color: Colors.white
            //           ),
            //         ),
            //       ),),
            // ),

            //   Text(text, style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
