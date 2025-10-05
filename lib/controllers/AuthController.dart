import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:america/models/User.dart';
import 'package:america/services/navigator_utils.dart';
import 'package:america/utils/app_utilities.dart';
import 'package:america/views/login_screen.dart';
import 'package:america/views/register_screen.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_util.dart';
import '../models/Account.dart';
import '../models/MyResponse.dart';
import '../services/Network.dart';
import '../services/general_snackbar.dart';
import '../utils/InternetUtils.dart';

enum AuthType { LOGIN, NOT_FOUND, BLOCKED }

class AuthController {
  //--------------------- Log In ---------------------------------------------//
  static Future<MyResponse> loginUser(
    context, {
    String? email,
    String? mobile,
    String? password,
  }) async {
    //Get FCM

    //URL
    String loginUrl = ApiUtil.MAIN_API_URL + ApiUtil.AUTH_LOGIN;

    log(loginUrl);

    var fcmToken = await FirebaseMessaging.instance.getToken();

    //Body Data
    Map data = {
      'mobile': mobile,
      // 'email': email,
      //'password': password,

      'device_token': fcmToken,

      'fcm_token': fcmToken
    };
    log(data.toString());
    //Encode
    String body = json.encode(data);

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError();
    }

    //Response
    try {
      NetworkResponse response = await Network.post(loginUrl,
          headers: ApiUtil.getHeader(requestType: RequestType.Post),
          body: body);

      log(response.body.toString());

      MyResponse myResponse = MyResponse(response.statusCode);

      if (response.statusCode == 200) {
        myResponse.data = response.body!;

        myResponse.success = true;
      } else {
        Map<String, dynamic> data = json.decode(response.body!);
        myResponse.success = false;
        myResponse.setError(data);
        if (data["errors"] != null && data["errors"].length > 0) {
          if (data["errors"][0] == "User not found") {
            pushScreen(context, RegisterScreen());
          }
          // myResponse.setError(data["errors"]);
        }
      }

      return myResponse;
    } catch (e) {
      log(e.toString());
      return MyResponse.makeServerProblemError();
    }
  }

  //--------------------- Register  ---------------------------------------------//
  static Future<MyResponse> registerUser({
    String? name,
    String? email,
    String? mobile,
    String? password,
  }) async {
    //Add FCM Token
    /* PushNotificationsManager pushNotificationsManager =
        PushNotificationsManager();
    await pushNotificationsManager.init();
    String? fcmToken = await pushNotificationsManager.getToken();*/

    //URL
    String registerUrl = ApiUtil.MAIN_API_URL + ApiUtil.AUTH_REGISTER;
    var fcmToken = await FirebaseMessaging.instance.getToken();
    //Body
    Map data = {
      'name': name,
      'mobile': mobile,
      //  'email': email,

      //  'password': password,
      'device_token': fcmToken,

      'fcm_token': fcmToken
    };

    log(data.toString());
    //Encode
    String body = json.encode(data);

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError();
    }

    //Response
    try {
      NetworkResponse response = await Network.post(registerUrl,
          headers: ApiUtil.getHeader(requestType: RequestType.Post),
          body: body);

      log(response.body.toString());

      MyResponse myResponse = MyResponse(response.statusCode);

      if (response.statusCode == 200) {
        myResponse.data = response.body!;

        myResponse.success = true;
      } else {
        Map<String, dynamic> data = json.decode(response.body!);
        myResponse.success = false;
        myResponse.setError(data);
      }

      return myResponse;
    } catch (e) {
      log(e.toString());
      //If any server error...
      return MyResponse.makeServerProblemError();
    }
  }

  //---------------------- Update user ------------------------------------------//
  static Future<MyResponse> updateUser({
    String? name,
    String? email,
    String? mobile,
    String? password,
  }) async {
    //Add FCM Token
    /* PushNotificationsManager pushNotificationsManager =
        PushNotificationsManager();
    await pushNotificationsManager.init();
    String? fcmToken = await pushNotificationsManager.getToken();*/

    //URL
    String registerUrl = ApiUtil.MAIN_API_URL + ApiUtil.UPDATE_PROFILE;
    var fcmToken = await FirebaseMessaging.instance.getToken();
    //Body
    Map data = email == null || email.isEmpty
        ? {
            'name': name,
            //'mobile': mobile,
            //  'email': email,

            //  'password': password,
          }
        : {
            'name': name,
            'mobile': mobile,
          };

    log(data.toString());
    //Encode
    String body = json.encode(data);

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError();
    }

    //Response
    try {
      NetworkResponse response = await Network.post(registerUrl,
          headers: ApiUtil.getHeader(
              requestType: RequestType.PostWithAuth,
              token: await AuthController.getApiToken()),
          body: body);

      log(response.body.toString());

      MyResponse myResponse = MyResponse(response.statusCode);

      if (response.statusCode == 200) {
        myResponse.data = response.body!;

        myResponse.success = true;
      } else {
        Map<String, dynamic> data = json.decode(response.body!);
        myResponse.success = false;
        myResponse.setError(data);
      }

      return myResponse;
    } catch (e) {
      log(e.toString());
      //If any server error...
      return MyResponse.makeServerProblemError();
    }
  }

  static Future<bool> resetPassword(context,
      {required String mobile, required String password}) async {
    try {
      String resetPasswordUrl = ApiUtil.MAIN_API_URL + ApiUtil.resetPassword;

      NetworkResponse response = await Network.post(resetPasswordUrl,
          headers: ApiUtil.getHeader(requestType: RequestType.Post),
          body: jsonEncode({
            "mobile": mobile,
            "password": password,
          }));

      log({
        "mobile": mobile,
        "password": password,
      }.toString());

      log(response.body.toString());

      log(response.statusCode.toString());

      if (response.statusCode != 200 && response.statusCode != 403) {
        showSnackBar(context, "Error in changing Password");
        return false;
      } else {
        showSnackBar(context, "Password Changed Successfully");

        // log("password: "+Constants.password);

        pushReplacementScreen(context, LoginScreen());

        return true;
      }
    } catch (exception) {
      log(exception.toString());
      showSnackBar(context, "Error");

      return false;
    }
  }

  static Future<bool> sendEmailForget(context, {required String email}) async {
    try {
      String resetPasswordUrl =
          "${ApiUtil.MAIN_API_URL}${ApiUtil.resetPasswordEmail}?email=$email";

      log(resetPasswordUrl.toString());
      NetworkResponse response = await Network.post(
        resetPasswordUrl,
        headers: ApiUtil.getHeader(requestType: RequestType.PostWithAuth),
      );

      log(response.body.toString());

      if (response.statusCode != 200) {
        showSnackBar(context, "a verfication link was sent to your email");
        return false;
      } else {
        // log("password: "+Constants.password);

        showSnackBar(context, "a verfication link was sent to your email");
        return true;
      }
    } catch (exception) {
      showSnackBar(context, "a verfication link was sent to your email");

      return false;
    }
  }

  //------------------------ Logout -----------------------------------------//
  static Future<bool> logoutUser() async {
    //Remove FCM Token
/*    PushNotificationsManager pushNotificationsManager =
        PushNotificationsManager();
    await pushNotificationsManager.removeFCM();*/

    //Clear all Data
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.remove('name');
    await sharedPreferences.remove('email');
    await sharedPreferences.remove('token');
    await sharedPreferences.remove('phone');

    return true;
  }

  static deleteUser(context) async {
    String? token = await AuthController.getApiToken();
    String deleteAccount = ApiUtil.MAIN_API_URL + ApiUtil.deleteAccount;

    NetworkResponse response = await Network.get(
      deleteAccount,
      headers:
          ApiUtil.getHeader(requestType: RequestType.GetWithAuth, token: token),
    );

    if (response.statusCode == 200) {
      log(response.body.toString());
      logoutUser();
      pushReplacementScreen(context, LoginScreen());

      AppUtil.appAlert(context,
          title: "Success",
          msg: "Account Deleted Successfully",
          contentType: ContentType.success);
    } else {
      log("error happended");
    }
  }

  //------------------------ Save user in cache -----------------------------------------//
  static saveUser(Map<String, dynamic> user) async {
    await saveUserFromUser(User.fromJson(user));
  }

  static saveUserFromUser(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt('id', user.id);
    await sharedPreferences.setString('name', user.name!);
    await sharedPreferences.setString(
        'email', user.email == null ? "" : user.email!);
    await sharedPreferences.setString(
        'phone', user.phone == null ? "" : user.phone!);
  }

  //------------------------ Get user from cache -----------------------------------------//
  static Future<Account> getAccount() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? id = sharedPreferences.getInt('id');
    String? name = sharedPreferences.getString('name');
    String? email = sharedPreferences.getString('email');
    String? token = sharedPreferences.getString('token');
    String? phone = sharedPreferences.getString('phone');

    return Account(id, name, email, token, phone);
  }

  //------------------------ Check user logged in or not -----------------------------------------//
  static Future<AuthType> userAuthType() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String? token = sharedPreferences.getString("token");
      return AuthType.LOGIN;
    } catch (e) {}
    return AuthType.NOT_FOUND;
  }

  //------------------------ Get api token -----------------------------------------//
  static Future<String?> getApiToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("token");
  }

  static Future<MyResponse> hasGuest(context) async {
    String haveGuest = ApiUtil.MAIN_API_URL + ApiUtil.haveGuest;

    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError();
    }

    try {
      NetworkResponse response = await Network.get(
        haveGuest,
        headers: ApiUtil.getHeader(requestType: RequestType.Get),
      );

      log(response.body.toString());

      MyResponse myResponse = MyResponse(response.statusCode);

      if (response.statusCode == 200) {
        myResponse.data = json.decode(response.body!);

        myResponse.success = true;
      } else {
        Map<String, dynamic> data = json.decode(response.body!);
        myResponse.success = false;
        myResponse.setError(data);
        if (data["errors"] != null && data["errors"].length > 0) {
          if (data["errors"][0] == "User not found") {
            pushScreen(context, RegisterScreen());
          }
          // myResponse.setError(data["errors"]);
        }
      }

      return myResponse;
    } catch (e) {
      log(e.toString());
      return MyResponse.makeServerProblemError();
    }
  }

  static Future<MyResponse> howMuchGuests(
    context, {
    String? email,
    String? mobile,
    String? password,
  }) async {
    //Get FCM

    //URL
    String howMuchGuest = ApiUtil.MAIN_API_URL + ApiUtil.howMuchGuest;

    log(howMuchGuest);

    var fcmToken = await FirebaseMessaging.instance.getToken();

    //Body Data
    Map data = {
      'device_token': fcmToken,
    };
    log(data.toString());
    //Encode
    String body = json.encode(data);

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError();
    }

    //Response
    try {
      NetworkResponse response = await Network.post(howMuchGuest,
          headers: ApiUtil.getHeader(requestType: RequestType.Post),
          body: body);

      log(response.body.toString());

      MyResponse myResponse = MyResponse(response.statusCode);

      if (response.statusCode == 200) {
        myResponse.data = response.body!;

        myResponse.success = true;
      } else {
        Map<String, dynamic> data = json.decode(response.body!);
        myResponse.success = false;
        myResponse.setError(data);
        if (data["errors"] != null && data["errors"].length > 0) {
          if (data["errors"][0] == "User not found") {
            pushScreen(context, RegisterScreen());
          }
          // myResponse.setError(data["errors"]);
        }
      }

      return myResponse;
    } catch (e) {
      log(e.toString());
      return MyResponse.makeServerProblemError();
    }
  }
}
