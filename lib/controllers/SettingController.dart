import 'dart:convert';
import 'dart:developer';

import 'package:america/api/api_util.dart';
import 'package:america/controllers/AuthController.dart';
import 'package:america/models/Account.dart';
import 'package:america/models/Setting.dart';
import 'package:america/models/MyResponse.dart';
import 'package:america/models/contact_model.dart';
import 'package:america/services/Network.dart';
import 'package:america/utils/InternetUtils.dart';

class SettingController {
  static Future<MyResponse<List<Setting>>> getAllSetting() async {
    print("Setting sttart");
    //Getting User Api Token
    Account account = await AuthController.getAccount();

    String url = ApiUtil.MAIN_API_URL + ApiUtil.Setting + ApiUtil.getStoreId();
    Map<String, String> headers = ApiUtil.getHeader(
        requestType: RequestType.GetWithAuth, token: account.token ?? "");

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError<List<Setting>>();
    }

    try {
      NetworkResponse response = await Network.get(url, headers: headers);
      log("settings data: ${response.body}");
      MyResponse<List<Setting>> myResponse = MyResponse(response.statusCode);
      print("Setting 111");
      if (response.statusCode == 200) {
        print("Setting done");
        List<Setting> list =
            Setting.getListFromJson(json.decode(response.body!)['setting']);
        print("Setting${myResponse.data}");
        myResponse.success = true;
        myResponse.data = list;
      } else {
        print("Setting error");
        myResponse.setError(json.decode(response.body!));
      }

      return myResponse;
    } catch (e) {
      //If any server error...
      return MyResponse.makeServerProblemError<List<Setting>>();
    }
  }

  static Future<MyResponse<ContactModel>> getContactUs() async {
    print("Setting sttart");
    //Getting User Api Token
    Account account = await AuthController.getAccount();
    String url = ApiUtil.MAIN_API_URL + ApiUtil.contactUs;
    Map<String, String> headers = ApiUtil.getHeader(
        requestType: RequestType.GetWithAuth, token: account.token ?? "");

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError<ContactModel>();
    }

    try {
      NetworkResponse response = await Network.get(url, headers: headers);
      log("contact us data: ${response.body}");
      MyResponse<ContactModel> myResponse = MyResponse(response.statusCode);

      if (response.statusCode == 200) {
        ContactModel list = ContactModel.fromJson(json.decode(response.body!));

        myResponse.success = true;
        myResponse.data = list;
      } else {
        myResponse.setError(json.decode(response.body!));
      }

      return myResponse;
    } catch (e) {
      //If any server error...
      return MyResponse.makeServerProblemError<ContactModel>();
    }
  }
}
