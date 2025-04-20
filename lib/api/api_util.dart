import 'package:america/controllers/Branches_Controller.dart';
import 'package:america/views/appScreen.dart';
import 'package:america/views/homeScreen.dart';
import 'package:flutter/material.dart';

enum RequestType { Post, Get, PostWithAuth, GetWithAuth }

class ApiUtil {
// there is comment here please chech that
  /*----------------- Fpr development server -----------------*/
  static const String IP_ADDRESS = "10.0.2.2";

  static const String PORT = "8000";
  //static const String API_VERSION = "v1";
  // static const String USER_MODE = "user/";
  //static const String BASE_URL = "http://" + IP_ADDRESS + ":" + PORT + "/";

  /*------------ For Production server ----------------------*/

  //TODO: Change base URL as per your server
  static String BASE_URL = "https://test.online/api/v1/user/";
  static String ImageUrl = "https://test.online/assets/admin/uploads/";

  static String WEB_API = BASE_URL;

  static String MAIN_API_URL_DEV = BASE_URL;
  static String MAIN_API_URL_PRODUCTION = BASE_URL;

  //Main Url for production and testing
  static String MAIN_API_URL = MAIN_API_URL_DEV;

  // ------------------ Status Code ------------------------//
  static const int SUCCESS_CODE = 200;
  static const int ERROR_CODE = 400;
  static const int UNAUTHORIZED_CODE = 401;

  //Custom codes
  static const int INTERNET_NOT_AVAILABLE_CODE = 500;
  static const int SERVER_ERROR_CODE = 501;
  static const int MAINTENANCE_CODE = 503;

  //------------------ Header ------------------------------//

  static Map<String, String> getHeader(
      {RequestType requestType = RequestType.Get, String? token = ""}) {
    switch (requestType) {
      case RequestType.Post:
        return {
          "Accept": "application/json",
          "Content-type": "application/json"
        };
      case RequestType.Get:
        return {
          "Accept": "application/json",
        };
      case RequestType.PostWithAuth:
        return {
          "Accept": "application/json",
          "Content-type": "application/json",
          "Authorization": "Bearer " + token!
        };
      case RequestType.GetWithAuth:
        return {
          "Accept": "application/json",
          "Authorization": "Bearer " + token!
        };
    }
  }

  // ----------------------  Body --------------------------//
  static Map<String, dynamic> getPatchRequestBody() {
    return {'_method': 'PATCH'};
  }

  //------------------- API LINKS ------------------------//

  //Maintenance
  static const String MAINTENANCE = "maintenance/";

  //App Data
  static const String APP_DATA = "app_data/";

  //User
  static const String USER = "user/";

  //Auth
  static const String AUTH_LOGIN = "login";
  // static const String AUTH_MOBILE_VERIFIED = "mobile_verified/";
  static const String MOBILE_NUMBER_VERIFY = "verify";
  static const String AUTH_REGISTER = "register";
  static const String Profile = "profile";

  //Update
  static const String UPDATE_PROFILE = "update_profile/";

  //Forgot password
  static const String FORGOT_PASSWORD = "password/email";

  static const mobileVerified = 'mobileVerified';

  static const resetPassword = 'reset-password';

  static const resetPasswordEmail = 'resetpasswordemail';

  //Banner
  static const String Banner = "banners";
  static const String Categories = "categories";
  static const String Online = "onlines";
  static const String Location = "locations";
  static const String Coupon = "coupons";
  static const String Product = "products";
  static const String Setting = "settings";
  static const String Social = "socials";
  static const String Weekly = "weekly";

  static const String qrcood = "qrcood";

  static const String contactUs = "contact-us";

  static const String Coupons = "coupons";

  static const String moveToClip = "move-to-clipped";

  static const String CouponClip = "clip";

  static const String CouponClipped = "clipped";

  static const String checkExpir = "checkCouponExpiration";

  static const String deleteAccount = "delete-account";

  static const String stores = "stores";

  static const String categories = "categories";

  static const String careers = "careers";
  static const String careersApply = "careersApply/store";
  static const String gifts = "gifts";

  static const String clippedGifts = "clipped-gifts";
  static const String checkGiftExpir = "check-expiration";

  static const String haveGuest = "have-guest";

  static const String howMuchGuest = "how-much-guest";

  static const String guest = "guest";

  static const String updateStoreId = "updateStoreId";

  //----------------- Redirects ----------------------------------//
  static Future<bool> checkRedirectNavigation(
      BuildContext context, int? statusCode) async {
    switch (statusCode) {
      case SUCCESS_CODE:
      case ERROR_CODE:
        return false;
      case UNAUTHORIZED_CODE:
        // await AuthController.logoutUser();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen(),
          ),
          (route) => false,
        );
        return true;
      case MAINTENANCE_CODE:
      case SERVER_ERROR_CODE:
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //     builder: (BuildContext context) => MaintenanceScreen(),
        //   ),
        //   (route) => false,
        // );
        return true;
      default:
        if (!isResponseSuccess(statusCode!)) {
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //     builder: (BuildContext context) => MaintenanceScreen(),
          //   ),
          //   (route) => false,
          // );
        }
    }
    return true;
  }

  static bool isResponseSuccess(int responseCode) {
    return responseCode >= 200 && responseCode < 300;
  }

  static String getStoreId() {
    return "?store_id=${BranchesController.selectedStore}";
  }
}
