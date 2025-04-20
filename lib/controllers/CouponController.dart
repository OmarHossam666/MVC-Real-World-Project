import 'dart:convert';
import 'dart:developer';

import 'package:america/api/api_util.dart';
import 'package:america/controllers/AuthController.dart';
import 'package:america/models/Account.dart';
import 'package:america/models/Coupon.dart';
import 'package:america/models/Gifts.dart';
import 'package:america/models/MyResponse.dart';
import 'package:america/models/User.dart';
import 'package:america/services/Network.dart';
import 'package:america/utils/InternetUtils.dart';
import 'package:america/utils/app_utilities.dart';

class CouponController {
  static Future<MyResponse<List<Coupon>>> getClipCoupons() async {
    print("Coupon sttart");
    //Getting User Api Token

    Account account = await AuthController.getAccount();

    String url = ApiUtil.MAIN_API_URL +
        ApiUtil.Coupons +
        "/${account.id}/" +
        ApiUtil.CouponClip +
        ApiUtil.getStoreId();

    log(url);

    String? token = await AuthController.getApiToken();
    log(token.toString());
    Map<String, String> headers =
        ApiUtil.getHeader(requestType: RequestType.GetWithAuth, token: token);

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError<List<Coupon>>();
    }

    try {
      NetworkResponse response = await Network.get(url, headers: headers);
      log(response.body.toString());
      MyResponse<List<Coupon>> myResponse = MyResponse(response.statusCode);
      //  print("Coupon 111");
      if (response.statusCode == 200) {
        //  print("Coupon done");
        List<Coupon> list = Coupon.getListFromJson(json.decode(response.body!));
        //  print("Coupon${myResponse.data}");
        myResponse.success = true;
        myResponse.data = list;
      } else {
        //  print("Coupon error");
        myResponse.setError(json.decode(response.body!));
      }

      return myResponse;
    } catch (e) {
      //If any server error...
      return MyResponse.makeServerProblemError<List<Coupon>>();
    }
  }

  static Future<MyResponse<List<ClippedCoupons>>> getClippedCoupons() async {
    //Getting User Api Token
    Account account = await AuthController.getAccount();
    String url = ApiUtil.MAIN_API_URL +
        ApiUtil.Coupons +
        "/${account.id}/" +
        ApiUtil.CouponClipped +
        ApiUtil.getStoreId();

    log(url);
    String? token = await AuthController.getApiToken();
    log(token.toString());
    Map<String, String> headers =
        ApiUtil.getHeader(requestType: RequestType.GetWithAuth, token: token);

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError<List<ClippedCoupons>>();
    }

    try {
      NetworkResponse response = await Network.get(url, headers: headers);
      log(response.body.toString());
      MyResponse<List<ClippedCoupons>> myResponse =
          MyResponse(response.statusCode);

      if (response.statusCode == 200) {
        List<ClippedCoupons> list = clippedCouponsFromMap(response.body!);

        myResponse.success = true;
        myResponse.data = list;
      } else {
        myResponse.setError(json.decode(response.body!));
      }

      return myResponse;
    } catch (e) {
      log(e.toString());
      //If any server error...
      return MyResponse.makeServerProblemError<List<ClippedCoupons>>();
    }
  }

  static Future<MyResponse<dynamic>> moveToClipped(context, {couponId}) async {
    print("Coupon sttart");
    //Getting User Api Token

    String url = ApiUtil.MAIN_API_URL +
        ApiUtil.Coupons +
        "/${couponId}/" +
        ApiUtil.moveToClip;

    log(url);
    Map<String, String> headers = ApiUtil.getHeader(
        requestType: RequestType.PostWithAuth,
        token: await AuthController.getApiToken());

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError<dynamic>();
    }

    try {
      NetworkResponse response = await Network.post(url, headers: headers);
      log(response.body.toString());
      MyResponse<dynamic> myResponse = MyResponse(response.statusCode);

      if (response.statusCode == 200) {
        AppUtil.appAlert(context,
            msg: json.decode(response.body!)["message"].toString(),
            contentType: ContentType.success);
      } else {
        myResponse.setError(json.decode(response.body!));
      }

      return myResponse;
    } catch (e) {
      //If any server error...
      return MyResponse.makeServerProblemError<dynamic>();
    }
  }

  static Future<MyResponse<dynamic>> checkExpir(context, {couponId}) async {
    print("Coupon sttart");
    //Getting User Api Token

    String url = ApiUtil.MAIN_API_URL +
        ApiUtil.Coupons +
        "/${couponId}/" +
        ApiUtil.checkExpir;

    log(url);
    Map<String, String> headers = ApiUtil.getHeader(
        requestType: RequestType.GetWithAuth,
        token: await AuthController.getApiToken());

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError<dynamic>();
    }

    try {
      NetworkResponse response = await Network.get(url, headers: headers);
      log(response.body.toString());
      MyResponse<dynamic> myResponse = MyResponse(200);

      if (response.statusCode == 200) {
        myResponse.success = true;
        myResponse.data = json.decode(response.body!);
        AppUtil.appAlert(context,
            msg: json.decode(response.body!)["messages"].toString(),
            contentType: ContentType.success);
      } else {
        myResponse.setError(json.decode(response.body!));
      }

      return myResponse;
    } catch (e) {
      log("error here");
      //If any server error...
      return MyResponse.makeServerProblemError<dynamic>();
    }
  }

  static Future<MyResponse<List<Gift>>> getClipGifts() async {
    //Getting User Api Token

    Account account = await AuthController.getAccount();

    String url = ApiUtil.MAIN_API_URL + ApiUtil.gifts + ApiUtil.getStoreId();

    print(url);

    String? token = await AuthController.getApiToken();
    log(token.toString());
    Map<String, String> headers =
        ApiUtil.getHeader(requestType: RequestType.GetWithAuth, token: token);

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError<List<Gift>>();
    }

    try {
      NetworkResponse response = await Network.get(url, headers: headers);
      log(response.body.toString());
      MyResponse<List<Gift>> myResponse = MyResponse(response.statusCode);
      //  print("Coupon 111");
      if (response.statusCode == 200) {
        GiftsModel giftsModel = giftsModelFromJson(response.body!);
        //  print("Coupon done");
        List<Gift> list = giftsModel.gifts!;
        //  print("Coupon${myResponse.data}");
        myResponse.success = true;
        myResponse.data = list;
      } else {
        //  print("Coupon error");
        myResponse.setError(json.decode(response.body!));
      }

      return myResponse;
    } catch (e) {
      //If any server error...
      return MyResponse.makeServerProblemError<List<Gift>>();
    }
  }

  static Future<MyResponse<List<Gift>>> getClippedGifts() async {
    //Getting User Api Token

    Account account = await AuthController.getAccount();

    String url =
        ApiUtil.MAIN_API_URL + ApiUtil.clippedGifts + ApiUtil.getStoreId();

    print(url);

    String? token = await AuthController.getApiToken();
    log(token.toString());
    Map<String, String> headers =
        ApiUtil.getHeader(requestType: RequestType.GetWithAuth, token: token);

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError<List<Gift>>();
    }

    try {
      NetworkResponse response = await Network.get(url, headers: headers);
      log(response.body.toString());
      MyResponse<List<Gift>> myResponse = MyResponse(response.statusCode);
      //  print("Coupon 111");
      if (response.statusCode == 200) {
        GiftsModel giftsModel = giftsModelFromJson(response.body!);
        //  print("Coupon done");
        List<Gift> list = giftsModel.gifts!;
        //  print("Coupon${myResponse.data}");
        myResponse.success = true;
        myResponse.data = list;
      } else {
        //  print("Coupon error");
        myResponse.setError(json.decode(response.body!));
      }

      return myResponse;
    } catch (e) {
      //If any server error...
      return MyResponse.makeServerProblemError<List<Gift>>();
    }
  }

  static Future<MyResponse<dynamic>> movGiftToClipped(context, {giftId}) async {
    print("Coupon sttart");
    //Getting User Api Token

    String url = ApiUtil.MAIN_API_URL + ApiUtil.gifts + "/${giftId}/" + "clip";

    log(url);
    Map<String, String> headers = ApiUtil.getHeader(
        requestType: RequestType.PostWithAuth,
        token: await AuthController.getApiToken());

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError<dynamic>();
    }

    try {
      NetworkResponse response = await Network.post(url, headers: headers);
      log(response.body.toString());
      MyResponse<dynamic> myResponse = MyResponse(response.statusCode);

      if (response.statusCode == 200) {
        AppUtil.appAlert(context,
            msg: json.decode(response.body!)["message"].toString(),
            contentType: ContentType.success);
      } else {
        myResponse.setError(json.decode(response.body!));
      }

      return myResponse;
    } catch (e) {
      //If any server error...
      return MyResponse.makeServerProblemError<dynamic>();
    }
  }

  static Future<MyResponse<dynamic>> checkExpirGift(context, {giftId}) async {
    print("Coupon sttart");
    //Getting User Api Token

    String url = ApiUtil.MAIN_API_URL +
        ApiUtil.gifts +
        "/${giftId}/" +
        ApiUtil.checkGiftExpir;

    log(url);
    Map<String, String> headers = ApiUtil.getHeader(
        requestType: RequestType.GetWithAuth,
        token: await AuthController.getApiToken());

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError<dynamic>();
    }

    try {
      NetworkResponse response = await Network.get(url, headers: headers);
      log(response.body.toString());
      MyResponse<dynamic> myResponse = MyResponse(200);

      if (response.statusCode == 200) {
        myResponse.success = true;
        myResponse.data = json.decode(response.body!);
        AppUtil.appAlert(context,
            msg: json.decode(response.body!)["message"].toString(),
            contentType: ContentType.success);
      } else {
        myResponse.setError(json.decode(response.body!));
      }

      return myResponse;
    } catch (e) {
      log("error here");
      //If any server error...
      return MyResponse.makeServerProblemError<dynamic>();
    }
  }
}
