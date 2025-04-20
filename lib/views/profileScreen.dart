import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:america/AppTheme.dart';
import 'package:america/AppThemeNotifier.dart';
import 'package:america/services/AppLocalizations.dart';
import 'package:america/widgets/SelectLanguageDialog.dart';
import 'package:america/widgets/navigator.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  //Theme Data
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeNotifier>(
        builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
          int themeType = value.themeMode();
          themeData = AppTheme.getThemeFromThemeMode(themeType);
          customAppTheme = AppTheme.getCustomAppTheme(themeType);
          return  Scaffold(
              body: Column(
                children: [
                 Text("asdfd")
                ],
              )

    );
        }
    );
  }



}

