import 'dart:developer';

import 'package:america/api/api_util.dart';
import 'package:america/constants.dart';
import 'package:america/models/basic_model.dart';
import 'package:america/views/appScreen.dart';
import 'package:america/views/splashScreen.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:shared_preferences/shared_preferences.dart';


import '../models/base_api_model.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

     BaseApiModel? baseApiModel ;
      BasicData? basicData ;
  
 
  int? initscreen;

  @override
  void initState() {
   getBaseUrl();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Lottie.asset("assets/images/loading.json",width:MediaQuery.of(context).size.width*0.6,height: MediaQuery.of(context).size.width*0.6 ),
        ),
      ),
    );
  }

  checkFirst()async{

        
       Constants.navigateToWithReplacement(context, SplashScreen());

     
             
  }


  getBaseUrl()async{
    log("start");
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    log(packageInfo.packageName.toString());
    try{

 
    var response = await Dio().post(
        "https://flyerall.co/api/central-domain",
        data: {
          "app_id" : packageInfo.packageName
        },
      );
        
      var baseApiData = await response.data;
      log(baseApiData.toString());
 
     if(baseApiData["type"]==0){

        basicData = BasicData.fromJson(response.data);
        log("converted");
        ApiUtil.MAIN_API_URL = "https://${basicData!.domain}/api/v1/user/";
        ApiUtil.ImageUrl = "https://${basicData!.domain}/assets/admin/uploads/";
       
        log(ApiUtil.MAIN_API_URL);

     } else{
     
      baseApiModel = BaseApiModel.fromMap(baseApiData);
      log("converted");
      
         ApiUtil.MAIN_API_URL = "https://${baseApiModel!.domain}/api/v1/user/";
        ApiUtil.ImageUrl = "https://${baseApiModel!.domain}/assets/admin/uploads/";
      
      log(ApiUtil.MAIN_API_URL);
     }
      
 
     


      checkFirst();


  }catch(e){
          log(e.toString());
         }
  }
}