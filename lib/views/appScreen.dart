import 'package:america/AppTheme.dart';
import 'package:america/AppThemeNotifier.dart';
import 'package:america/api/api_util.dart';
import 'package:america/services/AppLocalizations.dart';

import 'package:america/utils/SizeConfig.dart';
import 'package:america/views/couponsScreen.dart';
import 'package:america/views/locationScreen.dart';
import 'package:america/views/weeklyAdsScreen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:america/views/homeScreen.dart';




class AppScreen extends StatefulWidget {
  final int selectedPage;

  const AppScreen({super.key, this.selectedPage = 0});

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool isInProgress = false;



  TabController ?_tabController;

  _handleTabSelection() {
    setState(() {
      _currentIndex = _tabController!.index;
    });
  }


  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController!.addListener(_handleTabSelection);

    super.initState();
  }


  @override
  dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  ThemeData? themeData;
  CustomAppTheme? customAppTheme;


  @override
  Widget build(BuildContext context) {

    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget ?child) {
        int themeMode = value.themeMode();
        themeData = AppTheme.getThemeFromThemeMode(themeMode);
        customAppTheme = AppTheme.getCustomAppTheme(themeMode);
        return  Scaffold(
          backgroundColor: customAppTheme!.bgLayer1,
          bottomNavigationBar: BottomAppBar(
              elevation: 0,
              shape: CircularNotchedRectangle(),
              child: Container(
                decoration: BoxDecoration(
                  color: customAppTheme!.bgLayer1,
                  boxShadow: [
                    BoxShadow(
                      color: themeData!.cardTheme.shadowColor!.withAlpha(40),
                      blurRadius: 1,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                padding: Spacing.only(top: 5, bottom: 5),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: themeData!.colorScheme.primary,
                  tabs: <Widget>[
                    Container(
                        child: (_currentIndex == 0)
                            ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              MdiIcons.home,
                              color: themeData!.colorScheme.primary,
                            ),
                            Container(
                              child: Text(Translator.translate("home"),style: TextStyle(color: themeData!.primaryColor,fontSize: 10),),
                            )
                          ],
                        )
                            : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              MdiIcons.home,
                              color: themeData!.colorScheme.onSurface,
                            ),
                            Container(
                              child: Text(Translator.translate("home"),style: TextStyle(color: themeData!.colorScheme.onSurface,fontSize: 10),),
                            )
                          ],
                        )
                    ),
                    Container(

                        child: (_currentIndex == 1)
                            ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              MdiIcons.newspaperVariantOutline,
                              color: themeData!.colorScheme.primary,
                            ),
                            Container(
                              child: Text(Translator.translate("Weekly Ads"),style: TextStyle(color: themeData!.primaryColor,fontSize: 10),),
                            )
                          ],
                        )
                            : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              MdiIcons.newspaperVariantOutline,
                              color: themeData!.colorScheme.onSurface,
                            ),
                            Container(
                              child: Text(Translator.translate("Weekly Ads"),style: TextStyle(color: themeData!.colorScheme.onSurface,fontSize: 10),),
                            )
                          ],
                        )),
                    Container(

                        child: (_currentIndex == 2)
                            ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              MdiIcons.scissorsCutting,
                              color: themeData!.colorScheme.primary,
                            ),
                            Container(
                              child: Text(Translator.translate("Coupons"),style: TextStyle(color: themeData!.primaryColor,fontSize: 10),),
                            )
                          ],
                        )
                            : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              MdiIcons.scissorsCutting,
                              color: themeData!.colorScheme.onSurface,
                            ),
                            Container(
                              child: Text(Translator.translate("Coupons"),style: TextStyle(color: themeData!.colorScheme.onSurface,fontSize: 10),),
                            )
                          ],
                        )),

                  ],
                ),
              )),

          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              HomeScreen(),
              WeeklyAdsScreen(),
              CouponsScreen(),
            ],
          ),
        );

      },
    );
  }

}
