// import 'dart:convert';
// import 'dart:developer';

// import 'package:america/api/api_util.dart';
// import 'package:america/controllers/AuthController.dart';
// import 'package:america/models/Account.dart';
// import 'package:america/models/Banners.dart';
// import 'package:america/models/Catogry.dart';
// import 'package:america/models/MyResponse.dart';
// import 'package:america/services/Network.dart';
// import 'package:america/utils/InternetUtils.dart';

// class CategoeriesController {
//   static Future<MyResponse<List<CategoryModel>>> getAllCategories() async {
//     print("Banners sttart");
//     //Getting User Api Token

//     String url =
//         ApiUtil.MAIN_API_URL + ApiUtil.Categories + ApiUtil.getStoreId();
//     Account account = await AuthController.getAccount();
//     log(url.toString());
//     Map<String, String> headers = ApiUtil.getHeader(
//         requestType: RequestType.GetWithAuth, token: account.token ?? "");

//     //Check Internet
//     bool isConnected = await InternetUtils.checkConnection();
//     if (!isConnected) {
//       return MyResponse.makeInternetConnectionError<List<CategoryModel>>();
//     }

//     try {
//       NetworkResponse response = await Network.get(url, headers: headers);
//       MyResponse<List<Banners>> myResponse = MyResponse(response.statusCode);
//       print("Banners 111");
//       if (response.statusCode == 200) {
//         print("Banners done");
//         List<CategoryModel> list = CategoryModel.getListFromJson(
//             json.decode(response.body!)['categories']);
//         print("Banners${myResponse.data}");
//         myResponse.success = true;
//         myResponse.data = list;
//       } else {
//         print("Banners error");
//         myResponse.setError(json.decode(response.body!));
//       }

//       return myResponse;
//     } catch (e) {
//       //If any server error...
//       return MyResponse.makeServerProblemError<List<CategoryModel>>();
//     }
//   }
// }
