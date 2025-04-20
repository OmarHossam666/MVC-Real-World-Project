import 'dart:convert';
import 'dart:developer';

import 'package:america/constants.dart';
import 'package:america/reset_password_screen.dart';
import 'package:america/utils/app_ui.dart';
import 'package:america/utils/primary_button.dart';
import 'package:america/utils/space_widget.dart';
import 'package:america/views/appScreen.dart';
import 'package:america/views/branches_screen.dart';
import 'package:america/views/homeScreen.dart';
import 'package:america/views/register_screen.dart';
import 'package:america/widgets/navigator.dart';
import 'package:america/widgets/text_field.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/AuthController.dart';
import '../pin_code_screen.dart';
import '../utils/app_utilities.dart';
import '../utils/loading_button.dart';
import '../utils/validation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  TextEditingController mobile = TextEditingController();

  String countryCode = "+1";

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  int selectedRadio = 1;

  bool showGuest = false;

  @override
  void initState() {
    AuthController.hasGuest(context).then((value) {
      log(value.data["data"].toString());
      setState(() {
        showGuest = value.data["data"] == 1 ? true : false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Login",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SpaceWidget(size: 10),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: Constants.getWidth(context) * 0.75,
                  height: Constants.getWidth(context) * 0.75,
                ),
              ),
              SpaceWidget(size: 10),
              // Padding(
              //   padding: EdgeInsets.only(right: 2.sp, left: 2.sp),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Row(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Text(
              //               "Login With",
              //               style: TextStyle(
              //              color: Colors.redAccent,
              //                 fontSize: 3.sp,
              //                 decorationStyle: TextDecorationStyle.solid,
              //                 decorationThickness: 2.0,
              //                 decorationColor: const Color(0xff5b7db1),
              //                 fontWeight: FontWeight.w700,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Radio(
              //                 value: 1,
              //                 groupValue: selectedRadio,
              //                 focusColor: Colors.redAccent,
              //                 activeColor:Colors.redAccent,
              //                 onChanged: (value) {
              //                   setState(() {
              //                     selectedRadio = value as int;
              //                   });
              //                 },
              //               ),
              //               Text(
              //                 "Phone",
              //                 style: TextStyle(

              //                   fontSize: 2.5.sp,
              //                   decorationStyle: TextDecorationStyle.solid,
              //                   decorationThickness: 2.0,

              //                   fontWeight: FontWeight.w700,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Radio(
              //                 value: 2,
              //                 groupValue: selectedRadio,
              //                      focusColor: Colors.redAccent,
              //                 activeColor:Colors.redAccent,
              //                 onChanged: (value) {
              //                   setState(() {
              //                     selectedRadio = value as int;
              //                   });
              //                 },
              //               ),
              //               Text(
              //                 'Email',
              //                 style: TextStyle(

              //                   fontSize: 2.5.sp,
              //                   decorationStyle: TextDecorationStyle.solid,
              //                   decorationThickness: 2.0,

              //                   fontWeight: FontWeight.w700,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              selectedRadio == 2
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 7.5.h,
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x29000000),
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: email,
                        //  keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Email",
                        ),

                        validator: (val) {
                          return AppValidations.generalValidation(val!);
                        },
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 7.5.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x29000000),
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.27,
                              child: CountryCodePicker(
                                onChanged: (code) {
                                  log(code.dialCode.toString());
                                  countryCode = code.dialCode!;
                                  log(countryCode.substring(1));
                                },
                                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                initialSelection: 'US',

                                // countryFilter: ['EG', 'SA', 'JO', 'AE', 'LB', 'SY', 'LY', 'MA', 'YE', 'IQ', 'KW', 'QA', 'BH', 'OM', 'TN', 'SD', 'DZ', 'MR', 'TN', 'PS'],

                                //    favorite: ['+962'],
                                //   favorite: [ '+962','+971','+213' ,'+966' ,'+20', '+964','+970' , '+961', '+963', '+218', '+212', '+967',],

                                // optional. Shows only country name and flag
                                showCountryOnly: false,
                                // optional. Shows only country name and flag when popup is closed.
                                showOnlyCountryWhenClosed: false,

                                //   alignLeft: false,
                                // optional. aligns the flag and the Text left
                                // alignLeft: false,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                  controller: mobile,
                                  validator: (val) {
                                    return AppValidations.generalValidation(
                                        val!);
                                  },
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Your Phone Number",
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
              SpaceWidget(size: 3),
              // CustomTextField(
              //   hintText: "password",
              //   isPassword: true,
              //   textEditingController: password,
              //   validator: (val) {
              //     return AppValidations.password(val!);
              //   },
              // ),
              // SpaceWidget(size: 1),
              // Padding(
              //   padding:  EdgeInsets.symmetric(horizontal: 5.sp),
              //   child: Row(
              //     children: [
              //       InkWell(
              //                 onTap: () {
              //                   pushScreen(context, ResetPasswordScreen());
              //                 },
              //                 child: Text(
              //                   "Forget Password ?",
              //                   style: TextStyle(
              //                       color: Colors.redAccent,
              //                       fontWeight: FontWeight.bold),
              //                 )),
              //     ],
              //   ),
              // ),
              SpaceWidget(size: 5),
              isLoading
                  ? LoadingButton(
                      colorButton: Colors.redAccent,
                    )
                  : PrimaryButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });

                          AuthController.loginUser(context,
                                  email: selectedRadio == 2
                                      ? email.text
                                      : "$countryCode${mobile.text}",
                                  mobile: selectedRadio == 2
                                      ? email.text
                                      : "$countryCode${mobile.text}",
                                  password: password.text)
                              .then((response) async {
                            setState(() async {
                              isLoading = false;
                              if (response.success) {
                                pushReplacementScreen(
                                    context, BranchesScreen());
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                Map<String, dynamic> data =
                                    json.decode(response.data);
                                Map<String, dynamic> user = data['user'];
                                String token = data['token'];

                                await AuthController.saveUser(user);

                                await sharedPreferences.setString(
                                    'token', token);
                              } else {
                                AppUtil.appAlert(context,
                                    msg: response.errorText.toString(),
                                    contentType: ContentType.failure);
                              }
                            });
                          });
                        }
                      },
                      title: "Login",
                      colorButton: Colors.redAccent,
                      textColor: Colors.white,
                    ),
              SpaceWidget(size: 2),
              Container(
                width: Constants.getWidth(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "you don't have account? ",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                        onTap: () {
                          pushScreen(context, RegisterScreen());
                        },
                        child: Text(
                          "Signup",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
              SpaceWidget(size: 2),
              !showGuest
                  ? const SizedBox.shrink()
                  : InkWell(
                      onTap: () {
                        pushScreen(context, BranchesScreen());
                        AuthController.howMuchGuests(context);
                      },
                      child: Text(
                        "Enter As Guest",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 3.sp),
                      )),
              SpaceWidget(size: 10),
            ],
          ),
        ),
      ),
    );
  }
}
