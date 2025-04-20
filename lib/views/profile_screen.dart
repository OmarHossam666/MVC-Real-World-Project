import 'dart:developer';

import 'package:america/constants.dart';
import 'package:america/controllers/AuthController.dart';
import 'package:america/models/Online.dart';
import 'package:america/utils/app_ui.dart';
import 'package:america/utils/main_services.dart';
import 'package:america/utils/space_widget2.dart';
import 'package:america/views/contact_us_screen.dart';
import 'package:america/views/edit_profile_screen.dart';
import 'package:america/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/Location.dart';
import '../services/navigator_utils.dart';



class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


    Future<void> _launchInWebViewGoogleMap(Uri url) async {
    log(url.toString());
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: true,),
    )) {
      throw Exception('Could not launch $url');
    }
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
                              Center(child: Text("Profile",style: TextStyle(fontSize: 25,color: Colors.black),)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),


                   SpaceHeight(height: 4),

                                 Padding(
                                   padding:  EdgeInsets.only(left:4.sp),
                                   child: Row(
                                    children: [
                                        Icon(Icons.edit_document,color: Colors.black,size: 5.sp,),
                                        SpaceWidth(width: 1),
                                       InkWell(
                                                                     onTap: () {
                                                                      pushScreen(context, EditProfileScreen());
                                                                     },
                                                                     child:    Text("Edit Profile",style: TextStyle(fontSize: 18,color:Colors.black ,fontWeight: FontWeight.bold),),
                                                                   ),
                                    ],
                                   )
                                 ),

                   SpaceHeight(height: 4),

                                 Padding(
                                   padding:  EdgeInsets.only(left:4.sp),
                                   child: Row(
                                    children: [
                                        Icon(Icons.contact_mail_rounded,color: Colors.black,size: 5.sp,),
                                        SpaceWidth(width: 1),
                                       InkWell(
                                                                     onTap: () {
                                                                      pushScreen(context, ContactUsScreen());
                                                                     },
                                                                     child:    Text("Contact Us",style: TextStyle(fontSize: 18,color:Colors.black ,fontWeight: FontWeight.bold),),
                                                                   ),
                                    ],
                                   )
                                 ),

                   SpaceHeight(height: 5),

                                 Padding(
                                   padding:  EdgeInsets.only(left:4.sp),
                                   child: Row(
                                    children: [
                                        Icon(Icons.logout,color: Colors.redAccent,size: 5.sp,),
                                       InkWell(
                                                                     onTap: () {
                                                                     AuthController.logoutUser();
                    pushReplacementScreen(context, LoginScreen());
                                                                     },
                                                                     child:    Text("Logout",style: TextStyle(fontSize: 18,color:Colors.redAccent ,fontWeight: FontWeight.bold),),
                                                                   ),
                                    ],
                                   )
                                 ),

                  SpaceHeight(height: 5),

                  Divider(),

                                 Padding(
                                             padding:  EdgeInsets.only(left:4.sp),
                                   child: Row(
                                    children: [
                                        Icon(Icons.delete,color: Colors.redAccent,size: 5.sp,),
                                       InkWell(
                                                                     onTap: () {
                                        showDeleteAccountConfirmationDialog(context);
                                                                     },
                                                                     child:    Text("Delete Account",style: TextStyle(fontSize: 18,color:Colors.redAccent ,fontWeight: FontWeight.bold),),
                                                                   ),
                                    ],
                                   )
                                 ),

                 
              ]),
             ),
      ),
    );
  }

        Future<void> showDeleteAccountConfirmationDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // Prevent users from dismissing the dialog by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(''),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text("are you sure you want to delete your account ?"), // Confirmation message
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text("cancel"), // Cancel button
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: Text("confirm",style: TextStyle(color: Colors.redAccent),), // Confirm button
            onPressed: () {
              // Perform the delete account action here
              // You can add your logic for account deletion or any other action.
              // Once the action is completed, you can close the dialog.
                   AuthController.deleteUser(context);
            },
          ),
        ],
      );
    },
  );
}

}