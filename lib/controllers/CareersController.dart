import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:america/api/api_util.dart';
import 'package:america/controllers/AuthController.dart';
import 'package:america/models/Account.dart';
import 'package:america/models/Career.dart';
import 'package:america/models/Location.dart';
import 'package:america/models/MyResponse.dart';
import 'package:america/services/Network.dart';
import 'package:america/services/general_snackbar.dart';
import 'package:america/utils/InternetUtils.dart';
import 'package:dio/dio.dart';

class CareersController {
  static Map applyData = {};
  static Future<MyResponse<CareersModel>> getAllCareers() async {
    print("Locations sttart");
    //Getting User Api Token
    String? token = "";
    Account account = await AuthController.getAccount();
    token = account.token;
    String url = ApiUtil.MAIN_API_URL + ApiUtil.careers + ApiUtil.getStoreId();
    Map<String, String> headers = ApiUtil.getHeader(
      requestType: RequestType.GetWithAuth,
      token: token.toString(),
    );

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError<CareersModel>();
    }

    try {
      NetworkResponse response = await Network.get(url, headers: headers);
      log(response.body.toString());
      MyResponse<CareersModel> myResponse = MyResponse(response.statusCode);
      print("Locations 111");
      if (response.statusCode == 200) {
        print("Locations done");
        CareersModel careersModel =
            careersModelFromJson(json.decode(response.body!));
        print("Locations${myResponse.data}");
        myResponse.success = true;
        myResponse.data = careersModel;
      } else {
        print("Locations error");
        myResponse.setError(json.decode(response.body!));
      }

      return myResponse;
    } catch (e) {
      //If any server error...
      return MyResponse.makeServerProblemError<CareersModel>();
    }
  }

  static Future applyCareers(context, {careerId}) async {
    try {
      //Getting User Api Token
      String? token = "";
      Account account = await AuthController.getAccount();
      token = account.token;
      String url = ApiUtil.MAIN_API_URL + ApiUtil.careersApply;

      log(url);

      // create a dio request with all this function fields

      Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";
      dio.options.headers["Accept"] = "application/json";
      dio.options.headers["Content-Type"] = "multipart/form-data";

      FormData formData = FormData();

      applyData.forEach((key, value) {
        if (value != null && value is File) {
          formData.files.add(
            MapEntry(
              key,
              MultipartFile.fromFileSync(
                value.path,
                filename: value.path.split('/').last,
              ),
            ),
          );
        } else {
          formData.fields.add(MapEntry(key, value.toString()));
        }
      });

      formData.fields.add(MapEntry("user_id", account.id.toString()));

      formData.fields.add(MapEntry("career_id", careerId.toString()));

      // formData.files.add(
      //   MapEntry(
      //     "photo",
      //     MultipartFile.fromFileSync(
      //       photo!.path,
      //       filename: photo.path.split('/').last,
      //     ),
      //   ),
      // );
      log(formData.fields.toString());

      log(formData.files.toString());

      var response = await dio.post(
        url,
        data: formData,
      );
      showSnackBar(context, response.data["message"].toString());
      log(response.data.toString());
      applyData.clear();
    } catch (e) {
      showSnackBar(context, e.toString());
      if (e is DioError) {
        log(e.response!.data.toString());
      }
      applyData.clear();
      log(e.toString());
    }
  }
}
