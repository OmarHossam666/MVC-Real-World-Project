import 'dart:convert';
import 'dart:developer';

import 'package:america/api/api_util.dart';
import 'package:america/controllers/AuthController.dart';
import 'package:america/models/Account.dart';
import 'package:america/models/Catogry.dart';
import 'package:america/models/Product.dart';
import 'package:america/models/MyResponse.dart';
import 'package:america/services/Network.dart';
import 'package:america/utils/InternetUtils.dart';

class ProductController {
  static Future<MyResponse<List<Product>>> getAllProduct() async {
    print("Product sttart");
    //Getting User Api Token

    String url = ApiUtil.MAIN_API_URL + ApiUtil.Product + ApiUtil.getStoreId();
    Account account = await AuthController.getAccount();
    log(url);
    Map<String, String> headers = ApiUtil.getHeader(
        requestType: RequestType.GetWithAuth, token: account.token ?? "");

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError<List<Product>>();
    }

    try {
      NetworkResponse response = await Network.get(url, headers: headers);
      log(response.body.toString());

      MyResponse<List<Product>> myResponse = MyResponse(response.statusCode);
      print("Product 111");
      if (response.statusCode == 200) {
        print("Product done");
        List<Product> list =
            Product.getListFromJson(json.decode(response.body!)['products']);
        print("Product${myResponse.data}");
        myResponse.success = true;
        myResponse.data = list;
      } else {
        print("Product error");
        myResponse.setError(json.decode(response.body!));
      }

      return myResponse;
    } catch (e) {
      //If any server error...
      return MyResponse.makeServerProblemError<List<Product>>();
    }
  }

  static Future<MyResponse<CategoryModel>>
      getAllCategoriesWithProducts() async {
    print("Product sttart");
    //Getting User Api Token

    String url =
        ApiUtil.MAIN_API_URL + ApiUtil.categories + ApiUtil.getStoreId();
    Account account = await AuthController.getAccount();
    Map<String, String> headers = ApiUtil.getHeader(
      requestType: RequestType.GetWithAuth,
      token: account.token ?? "",
    );

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError<CategoryModel>();
    }

    try {
      NetworkResponse response = await Network.get(url, headers: headers);

      MyResponse<CategoryModel> myResponse = MyResponse(response.statusCode);
      print("Product 111");
      if (response.statusCode == 200) {
        print("Product done");
        CategoryModel list =
            CategoryModel.fromJson(json.decode(response.body!));
        print("Product${myResponse.data}");
        myResponse.success = true;
        myResponse.data = list;
      } else {
        print("Product error");
        myResponse.setError(json.decode(response.body!));
      }

      return myResponse;
    } catch (e) {
      //If any server error...
      return MyResponse.makeServerProblemError<CategoryModel>();
    }
  }
}
