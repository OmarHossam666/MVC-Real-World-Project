// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

extension Sizer on num {
  double get h => this * 800 / 100;

  double get w => this * 360 / 100;

  double get sp => (((800 + 360) / 2) * this) / 100;
}


class AppUi {
  static AppColors get colors => AppColors();
  static AppAssets get assets => AppAssets();
  static AppFonts get fonts => AppFonts();
  static FontSizes get fontSizes => FontSizes();
}


class AppFonts {
  final String mainFont = "Neo Sans Arabic";
 // final String cairoFont = "Cairo";
}

class FontSizes {
  final double largeTitle=3.8.sp;
  final double meduimTitle=2.77.sp;
  final double smallTitle=2.45.sp;
  final double verysmallTitle=2.3.sp;

}


class AppColors {

  final linearGradientColor =const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.01, 0.6494, 1.0],
          colors: [
               Color(0xFFFFFFFF),
            Color(0xFFFFFFFF),
               Color(0xFFFFFFFF),
          ],
          transform: GradientRotation(168.42 * (3.1415 / 180)), // Convert degrees to radians
        );

    final secondaryGradient = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.4615, 1.0069],
          colors: [
            Color(0xFFF4BF49),
            Color(0xFFF8D859),
            Color(0xFFFFC107),
          ],
          transform: GradientRotation(92.59 * (3.1415 / 180)), // Convert degrees to radians
        );
     
      // Rest of your widget code


  final primaryLight = const Color(0xffEAF2FC);
  final primaryLightHover  = const Color(0xffDFECFB); 
  final primaryLightActive =  const Color(0xffBDD7F7); 
  final primaryNormal =  const Color(0xff2A7DE5); 
  final primaryNormalHover =  const Color(0xff2671CE); 
  final primaryNormalActive =  const Color(0xff2264B7);
  final primaryDark =  const Color(0xff205EAC); 
  final primaryDarkHover =  const Color(0xff194B89); 
  final primaryDarkActive =  const Color(0xff133867); 
  final primaryDarker =  const Color(0xff0F2C50); 

  final greyColor = const Color(0xffB2BBC6);


  final secondaryLight = const Color(0xffFFF9E6);
  final secondaryLightHover  = const Color(0xffFFF6DA); 
  final secondaryLightActive =  const Color(0xffFFECB2); 
  final secondaryNormal =  Colors.redAccent; 
  final secondaryNormalHover =  const Color(0xffE6AE06); 
  final secondaryNormalActive =  const Color(0xffCC9A06);
  final secondaryDark =  const Color(0xffBF9105); 
  final secondaryDarkHover =  const Color(0xff997404); 
  final secondaryDarkActive =  const Color(0xff735703); 
  final secondaryDarker =  const Color(0xff594402); 
  
  final brownColor = const Color(0xff964731);
  final blackColor = const Color(0xff050e19);
  final bodyText = const Color(0xff0b1f39);
  final normalDark = const Color(0xffB2BBC6);


  final scaffoldBackgroundColor = const Color(0xffF5F5F5) ;


    final failureRed = const Color.fromARGB(255, 66, 5, 94);
  final successGreen = const Color(0xff85BC87);

  
   


}

String image = 'assets/images/';
String video = 'assets/videos/';
String icons = 'assets/icons/';
String lottie = 'assets/lottie/';


class AppAssets { 

     final syncIcon = '${icons}sync_icon.svg';
     final deleteIcon = '${icons}delete_icon.svg';
     final calenderIcon = '${icons}calender_icon.svg';
     final clockIcon = '${icons}clock_icon.svg';
     final fileIcon = '${icons}file_icon.svg';

     final quizIcon = '${icons}quiz_icon.svg';
     final profileIcon = '${icons}profile_icon.svg';
     final addIcon = '${icons}add_icon.svg';
     final pointIcon = '${icons}point_icon.svg';
     final awardIcon = '${icons}award_icon.svg';

     final calculateIcon = '${icons}calculate_icon.svg';
     final learnIcon = '${icons}learn_icon.svg';
     final checkIcon = '${icons}check_icon.svg';
     final downloadIcon = '${icons}download_icon.svg';
     final callIcon = '${icons}call_icon.svg';
     final camIcon = '${icons}cam_icon.svg';

     final editIcon = '${icons}edit_icon.svg';
     final markIcon = '${icons}mark_icon.svg';
     final homeIcon = '${icons}home_icon.svg';
     final infoIcon = '${icons}info_icon.svg';
     final logoutIcon = '${icons}logout_icon.svg';

     final bookIcon = '${icons}book_icon.svg';
     final questionIcon = '${icons}question_icon.svg';
     final videoIcon = '${icons}video_icon.svg';
     final filterIcon = '${icons}filter_icon.svg';
     final cartIcon = '${icons}cart_icon.svg';

     final visibleIcon = '${icons}visible_icon.svg';
     final unvisibleIcon = '${icons}unvisible_icon.svg';
    final certifiedIcon = '${icons}certified_icon.svg';


     final searchIcon = '${icons}search_icon.png';
     final notificationsIcon = '${icons}notifications_icon.png';
     final customerServiceIcon = '${icons}customer_service_icon.png';


       final menuNavIcon = '${icons}menu_nav_icon.png';

final cartNavIcon = '${icons}cart_nav_icon.png';

final shopNavIcon = '${icons}shop_nav_icon.png';

final coursesNavIcon = '${icons}courses_nav_icon.png';

final homeNavIcon = '${icons}home_nav_icon.png';

      final applePay = '${icons}apple_pay_icon.png';
      final masterCardIcon = '${icons}mastercard_icon.png';
      final visaIcon = '${icons}visa_icon.png';
      final madaIcon = '${icons}mada_icon.png';
      final successIcon = '${icons}success_icon.png';
      final failIcon = '${icons}fail_icon.png';
      final langIcon = '${icons}lang_icon.svg';


      final bankIcon = '${icons}bank_icon.png';
      final tamaraIcon = '${icons}tamara_icon.png';


      final heroImg = '${image}hero.png';
      final signImg = '${image}sign.png';



      final logo1 = '${image}logo1.png';
      final logo2 = '${image}logo2.png';
      final logo3 = '${image}logo3.png';
      final mainLogo = '${image}main_logo.png';
       final logoGif= '${image}gif.gif';


      final intro1 = '${image}intro1.png';
      final intro2 = '${image}intro2.png';
      final intro3 = '${image}intro3.png';



      final logoAnim = '${image}logo_anim.gif';

      
      final example = '${image}example.png';
      final welcomeScreen = '${image}welcome_img.png';
      final emptyImg = '${image}empty.jpeg';

      final failedAnim = '${lottie}failed.json';
       final loading = '${lottie}loader.json';

      final mainLoader = '${lottie}main_loading.json';

      final emptySearch = '${lottie}empty_search.json';


      final splashVid = '${video}logo_animation.mov';
      

  

}

