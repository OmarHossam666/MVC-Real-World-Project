import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:america/AppTheme.dart';
import 'package:america/AppThemeNotifier.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  //Theme Data
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;

  List<String> imageList = [
    'assets/images/ba1.png',
    'assets/images/ba2.jpg',
    'assets/images/ba3.png',
  ];
  bool isInProgress = false;

  @override
  void initState() {
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
            child: Text(
              "Welcome",
              style: TextStyle(fontSize: 25),
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
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/images/ba1.png",
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        )),
      );
    });
  }
}
