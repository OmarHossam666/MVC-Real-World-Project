// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, sized_box_for_whitespace, use_build_context_synchronously

import 'dart:developer';

import 'package:america/utils/app_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'dart:ui' as ui;

import 'constants.dart';
import 'services/general_snackbar.dart';
import 'utils/primary_button.dart';

import 'utils/space_widget2.dart';

class PinCodeScreen extends StatefulWidget {
  final String phone;
  final Function()? onSuccess;

  final Function()? onSuccessPin;

  const PinCodeScreen(
      {super.key,
      required this.phone,
      required this.onSuccess,
      this.onSuccessPin});
  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen>
    with SingleTickerProviderStateMixin {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController pinCode = TextEditingController();

  bool isPassword = true;

  bool acceptTerms = false;
  late AnimationController _controller;

  String verificationID = "";
  final _formKey = GlobalKey<FormState>();

  int customer = 1;

  bool isLoading = false;

  verifyNumber() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: widget.phone,
      verificationCompleted: (phoneAuthCredential) {
        log("sucess Phone");
      },
      verificationFailed: (error) {
        log("failed Phone");
        showSnackBar(context, error.toString());
      },
      codeAutoRetrievalTimeout: (verificationId) {},
      timeout: const Duration(seconds: 120),
      codeSent: (String verificationId, int? resendToken) async {
        verificationID = verificationId;
        // Sign the user in (or link) with the credential
        //await auth.signInWithCredential(credential);
      },
    );
  }

  @override
  void initState() {
    super.initState();

    // Define the animation duration and curve
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    verifyNumber();
    // Start the animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Confirm Phone Number",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Container(
        width: Constants.getWidth(context),
        height: Constants.getHeight(context),
        decoration: BoxDecoration(),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: Constants.getWidth(context) * 0.35,
                  height: Constants.getHeight(context) * 0.35,
                ),

                const SpaceHeight(height: 4),

                Text(
                  "Check Your Number",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 3.5.sp,
                    fontFamily: "Tajawal",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SpaceHeight(height: 4),

                Container(
                  width: Constants.getWidth(context) * 0.85,
                  child: Text(
                    "You will recieve a pin code on your phone ${widget.phone}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 2.5.sp,
                      fontFamily: "Tajawal",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SpaceHeight(height: 4),

                SizedBox(
                  width: Constants.getWidth(context) * 0.85,
                  child: Directionality(
                    textDirection: ui.TextDirection.ltr,
                    child: PinCodeTextField(
                      controller: pinCode,
                      appContext: context,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      animationDuration: const Duration(milliseconds: 300),
                      enablePinAutofill: true,
                      cursorColor: Colors.redAccent,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.underline,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 30,
                        inactiveColor: Colors.redAccent,
                        activeColor: Colors.greenAccent,
                        selectedColor: Colors.redAccent,
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                ),

                const SpaceHeight(height: 2),

                InkWell(
                  onTap: () {
                    verifyNumber();

                    showSnackBar(context, "resend code");
                    // resend message
                  },
                  child: Container(
                    width: Constants.getWidth(context) * 0.85,
                    child: Text.rich(
                      TextSpan(
                        text: "you do not recieve a code",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 2.5.sp,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: " resend message",
                            style: TextStyle(
                              color: const Color(0xff5b7db1),
                              fontSize: 2.5.sp,
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.solid,
                              decorationThickness: 2.0,
                              decorationColor: const Color(0xff5b7db1),
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                const SpaceHeight(height: 4),
                PrimaryButton(
                    colorButton: Colors.redAccent,
                    textColor: Colors.white,
                    onTap: () async {
                      // Update the UI - wait for the user to enter the SMS code
                      String smsCode = pinCode.text;

                      log("confirm");
                      log(verificationID);
                      log(smsCode);
                      // Create a PhoneAuthCredential with the code

                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationID,
                                smsCode: smsCode);
                        log(credential.smsCode.toString());
                        await auth.signInWithCredential(credential);
                        //  showSnackBar(context, "success_register".tr());

                        //  pushScreen (context, WritePasswordScreen(mobile: widget.phone,));

                        widget.onSuccess!();
                      } catch (e) {
                        log(e.toString());
                        showSnackBar(context, e.toString());
                      }

                      log("done");
                    },
                    width: MediaQuery.of(context).size.width * 0.85,
                    title: "Confirm"),
                const SpaceHeight(height: 2),
                // InkWell(
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                //   child: Text(
                //      "Check Number",
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //         color: Colors.black,
                //         fontSize: 3.sp,
                //         fontFamily: "Tajawal",
                //         fontWeight: FontWeight.w500,
                //     ),
                //           ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
