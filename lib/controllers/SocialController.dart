import 'dart:convert';
import 'dart:developer';

import 'package:america/api/api_util.dart';
import 'package:america/controllers/AuthController.dart';
import 'package:america/models/Account.dart';
import 'package:america/models/Location.dart';
import 'package:america/models/MyResponse.dart';
import 'package:america/models/QrCood.dart';
import 'package:america/models/Social.dart';
import 'package:america/services/Network.dart';
import 'package:america/utils/InternetUtils.dart';

class SocialController {
  static Future<MyResponse<List<Social>>> getAllSocial() async {
    print("Social sttart");
    //Getting User Api Token
    Account account = await AuthController.getAccount();

    String url = ApiUtil.MAIN_API_URL + ApiUtil.Social + ApiUtil.getStoreId();
    Map<String, String> headers = ApiUtil.getHeader(
        requestType: RequestType.GetWithAuth, token: account.token ?? "");

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError<List<Social>>();
    }

    try {
      NetworkResponse response = await Network.get(url, headers: headers);
      log("social data: ${response.body}");
      MyResponse<List<Social>> myResponse = MyResponse(response.statusCode);
      print("Social 111");
      if (response.statusCode == 200) {
        print("Social done");
        List<Social> list =
            Social.getListFromJson(json.decode(response.body!)['social']);
        print("Social${myResponse.data}");
        myResponse.success = true;
        myResponse.data = list;
      } else {
        print("Social error");
        myResponse.setError(json.decode(response.body!));
      }

      return myResponse;
    } catch (e) {
      //If any server error...
      return MyResponse.makeServerProblemError<List<Social>>();
    }
  }

  static Future<MyResponse<QrModel>> getAllQrcood() async {
    print("QR sttart");
    //Getting User Api Token
    Account account = await AuthController.getAccount();
    String url = ApiUtil.MAIN_API_URL + ApiUtil.qrcood + ApiUtil.getStoreId();
    Map<String, String> headers = ApiUtil.getHeader(
        requestType: RequestType.GetWithAuth, token: account.token ?? "");

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError<QrModel>();
    }

    try {
      NetworkResponse response = await Network.get(url, headers: headers);
      log(response.body.toString());
      MyResponse<QrModel> myResponse = MyResponse(response.statusCode);
      print("QR 111");
      if (response.statusCode == 200) {
        print("QR done");
        QrModel list = qrModelFromMap(response.body!);
        print("QR${myResponse.data}");
        myResponse.success = true;
        myResponse.data = list;
      } else {
        print("Social error");
        myResponse.setError(json.decode(response.body!));
      }

      return myResponse;
    } catch (e) {
      //If any server error...
      return MyResponse.makeServerProblemError<QrModel>();
    }
  }
}
