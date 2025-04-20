import 'dart:developer';


import 'package:america/constants.dart';
import 'package:america/controllers/AuthController.dart';
import 'package:america/controllers/SettingController.dart';
import 'package:america/models/contact_model.dart';

import 'package:america/utils/app_ui.dart';

import 'package:america/utils/space_widget2.dart';
import 'package:america/views/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../models/MyResponse.dart';
import '../services/navigator_utils.dart';



class ContactUsScreen extends StatefulWidget {

  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {

 bool isInProgress = true;
  ContactModel? contactModel;
  getContacts() async {
    if (mounted) {
      setState(() {
        isInProgress = true;
      });
    }

    MyResponse<ContactModel> myResponse =
    await    SettingController.getContactUs();;

    if (myResponse.success) {
      print("contact done12");
      log(myResponse.data.toString());
      contactModel = myResponse.data;


    } else {
      print("contact er");

    }

    if (mounted) {
      setState(() {
        isInProgress = false;
      });
    }
  }
  @override
  void initState() {
  getContacts();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
  
    return SafeArea(
      child: Scaffold(
       
    
             body: SingleChildScrollView(
              child: Column(children: [
                 Padding(
                    padding:  EdgeInsets.only(left:2.sp,top: 2.sp),
                    child: Container(
                  
                      child: Row(
                      
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back_ios,color: Colors.black,)),
                          ),
                          SpaceWidth(width: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: Text("Contact Us",style: TextStyle(fontSize: 25,color: Colors.black),)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                 
                  isInProgress ?   Container(
                      width: Constants.getWidth(context),
                      height: Constants.getHeight(context),
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.redAccent),
                      ),
                    )  : contactModel!=null && contactModel!.contact!.isNotEmpty  ?  Column(
                      children: contactModel!.contact!.map((e) => Container(
                        padding: EdgeInsets.all(2.sp),
                        child: Column(
                          children: [

                           Text(e.description.toString(),style: TextStyle(fontSize: 3.sp,color: Colors.black),),
                           Divider(),
                          ],
                        ),
                      )).toList()

                    ):Container(),
                              

                  SpaceHeight(height: 5),

                

                 
              ]),
             ),
      ),
    );
  }

 
}