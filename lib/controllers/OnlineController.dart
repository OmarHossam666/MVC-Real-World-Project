import 'dart:convert';

import 'package:america/api/api_util.dart';
import 'package:america/controllers/AuthController.dart';
import 'package:america/models/Account.dart';
import 'package:america/models/Online.dart';
import 'package:america/models/MyResponse.dart';
import 'package:america/services/Network.dart';
import 'package:america/utils/InternetUtils.dart';

class OnlineController {
  static Future<MyResponse<List<Online>>> getAllOnline() async {
    print("Online sttart");
    //Getting User Api Token
    Account account = await AuthController.getAccount();

    String url = ApiUtil.MAIN_API_URL + ApiUtil.Online + ApiUtil.getStoreId();
    Map<String, String> headers = ApiUtil.getHeader(
        requestType: RequestType.GetWithAuth, token: account.token ?? "");

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError<List<Online>>();
    }

    try {
      NetworkResponse response = await Network.get(url, headers: headers);
      MyResponse<List<Online>> myResponse = MyResponse(response.statusCode);
      print("Online 111");
      if (response.statusCode == 200) {
        print("Online done");
        List<Online> list =
            Online.getListFromJson(json.decode(response.body!)['online']);
        print("Online${myResponse.data}");
        myResponse.success = true;
        myResponse.data = list;
      } else {
        print("Online error");
        myResponse.setError(json.decode(response.body!));
      }

      return myResponse;
    } catch (e) {
      //If any server error...
      return MyResponse.makeServerProblemError<List<Online>>();
    }
  }
}
