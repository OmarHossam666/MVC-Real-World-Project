import 'dart:convert';
import 'dart:developer';

import 'package:america/api/api_util.dart';
import 'package:america/controllers/AuthController.dart';
import 'package:america/models/Account.dart';
import 'package:america/models/WeeklyAd.dart';
import 'package:america/models/MyResponse.dart';
import 'package:america/services/Network.dart';
import 'package:america/utils/InternetUtils.dart';

class WeeklyAdController {
  static Future<MyResponse<List<WeeklyAd>>> getAllWeeklyAd() async {
    print("WeeklyAd sttart");
    //Getting User Api Token
    Account account = await AuthController.getAccount();
    String url = ApiUtil.MAIN_API_URL + ApiUtil.Weekly + ApiUtil.getStoreId();
    Map<String, String> headers = ApiUtil.getHeader(
        requestType: RequestType.GetWithAuth, token: account.token ?? "");

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError<List<WeeklyAd>>();
    }

    try {
      NetworkResponse response = await Network.get(url, headers: headers);
      log(response.body.toString());
      MyResponse<List<WeeklyAd>> myResponse = MyResponse(response.statusCode);
      print("WeeklyAd 111");
      if (response.statusCode == 200) {
        print("WeeklyAd done");
        List<WeeklyAd> list =
            WeeklyAd.getListFromJson(json.decode(response.body!)['weekly']);
        print("WeeklyAd${myResponse.data}");
        myResponse.success = true;
        myResponse.data = list;
      } else {
        print("WeeklyAd error");
        myResponse.setError(json.decode(response.body!));
      }

      return myResponse;
    } catch (e) {
      //If any server error...
      return MyResponse.makeServerProblemError<List<WeeklyAd>>();
    }
  }
}
