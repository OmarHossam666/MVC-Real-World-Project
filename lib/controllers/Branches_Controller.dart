import 'dart:convert';
import 'dart:developer';

import 'package:america/api/api_util.dart';
import 'package:america/controllers/AuthController.dart';
import 'package:america/models/Banners.dart';
import 'package:america/models/MyResponse.dart';
import 'package:america/models/stores_model.dart';
import 'package:america/services/Network.dart';
import 'package:america/utils/InternetUtils.dart';

class BranchesController {
  static int? selectedStore;
  static String? selectedStoreName;
  static Future<MyResponse<StoresModel>> getBranches() async {
    print("Banners sttart");
    //Getting User Api Token

    String url = ApiUtil.MAIN_API_URL + ApiUtil.stores;
    log(url.toString());
    Map<String, String> headers = ApiUtil.getHeader(
      requestType: RequestType.Get,
    );

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError<StoresModel>();
    }

    try {
      NetworkResponse response = await Network.get(url, headers: headers);
      log(response.body.toString());
      MyResponse<StoresModel> myResponse = MyResponse(response.statusCode);
      log("I am here");
      if (response.statusCode == 200) {
        StoresModel storesModel =
            StoresModel.fromJson(json.decode(response.body!));
        log("I am here2");
        myResponse.success = true;
        myResponse.data = storesModel;
      } else {
        myResponse.setError(json.decode(response.body!));
      }

      return myResponse;
    } catch (e) {
      log(e.toString());
      //If any server error...
      return MyResponse.makeServerProblemError<StoresModel>();
    }
  }

  static Future updateStoreId(storeId) async {
    print("Banners sttart");
    //Getting User Api Token

    String url = ApiUtil.MAIN_API_URL + ApiUtil.updateStoreId;
    log(url.toString());
    Map<String, String> headers = ApiUtil.getHeader(
      requestType: RequestType.PostWithAuth,
      token: await AuthController.getApiToken(),
    );

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();

    try {
      NetworkResponse response = await Network.post(url,
          headers: headers, body: jsonEncode({"store_id": storeId}));
      log("store id : " + response.body.toString());
    } catch (e) {
      log(e.toString());
      //If any server error...
    }
  }
}
