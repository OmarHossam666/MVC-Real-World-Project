import 'dart:convert';
import 'dart:developer';

import 'package:america/api/api_util.dart';
import 'package:america/controllers/AuthController.dart';
import 'package:america/models/Account.dart';
import 'package:america/models/Location.dart';
import 'package:america/models/MyResponse.dart';
import 'package:america/services/Network.dart';
import 'package:america/utils/InternetUtils.dart';

class LocationsController {
  static Future<MyResponse<List<Locations>>> getAllLocations() async {
    print("Locations sttart");
    //Getting User Api Token
    Account account = await AuthController.getAccount();
    String url = ApiUtil.MAIN_API_URL + ApiUtil.Location + ApiUtil.getStoreId();
    log("locations: $url");
    Map<String, String> headers = ApiUtil.getHeader(
        requestType: RequestType.GetWithAuth, token: account.token ?? "");

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError<List<Locations>>();
    }

    try {
      NetworkResponse response = await Network.get(url, headers: headers);
      log(response.body.toString());
      MyResponse<List<Locations>> myResponse = MyResponse(response.statusCode);
      print("Locations 111");
      if (response.statusCode == 200) {
        print("Locations done");
        List<Locations> list =
            Locations.getListFromJson(json.decode(response.body!)['locations']);
        print("Locations${myResponse.data}");
        myResponse.success = true;
        myResponse.data = list;
      } else {
        print("Locations error");
        myResponse.setError(json.decode(response.body!));
      }

      return myResponse;
    } catch (e) {
      //If any server error...
      return MyResponse.makeServerProblemError<List<Locations>>();
    }
  }
}
