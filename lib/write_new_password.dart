// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, sized_box_for_whitespace

import 'dart:developer';

import 'package:america/controllers/AuthController.dart';
import 'package:america/utils/app_ui.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'services/general_snackbar.dart';
import 'services/navigator_utils.dart';
import 'utils/loading_button.dart';
import 'utils/primary_button.dart';

import 'utils/space_widget2.dart';
import 'utils/validation.dart';
import 'views/login_screen.dart';
import 'widgets/text_field.dart';




class WritePasswordScreen extends StatefulWidget {
  final String mobile;

  const WritePasswordScreen({super.key, required this.mobile});
  @override
  _WritePasswordScreenState createState() => _WritePasswordScreenState();
}

class _WritePasswordScreenState extends State<WritePasswordScreen>
  {


  bool isPassword = true;

  bool acceptTerms=false;

  bool isLoading =false;


   final _formKey = GlobalKey<FormState>();

      TextEditingController password = TextEditingController();
   TextEditingController confirmPassword = TextEditingController();



  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Forget Password",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Container(
        width: Constants.getWidth(context),
        height: Constants.getHeight(context),
        decoration:  BoxDecoration(
           
          ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
               Image.asset('assets/images/logo.png',width: Constants.getWidth(context)*0.35,height: Constants.getHeight(context)* 0.35,),

           

              
             const  SpaceHeight(height: 4),
    
              

          
             CustomTextField(
              textEditingController: password,
              hintText: "password",
              validator: (val){
                     return AppValidations.password(val!);
                  },
              onChanged: (val){
                  log(val!);
                },isPassword: isPassword,suffixIcon:IconButton(icon: Icon(  isPassword
                 ? Icons.visibility
                 : Icons.visibility_off,color: Colors.grey,),onPressed: () {
                          setState(() {
                            isPassword = !isPassword;
                          });
                        }) ,),
                
                const  SpaceHeight(height: 4),
    
                   CustomTextField(
                    textEditingController: confirmPassword,
                    validator: (val){
                     return AppValidations.confirmPasswordvalidation(val!,password.text);
                  },
                    hintText: "confirm password",onChanged: (val){
                  log(val!);
                },isPassword: isPassword,suffixIcon:IconButton(icon: Icon(  isPassword
                 ? Icons.visibility
                 : Icons.visibility_off,color: Colors.grey,),onPressed: () {
                          setState(() {
                            isPassword = !isPassword;
                          });
                        }) ,),
            
             const  SpaceHeight(height: 4),
               
                
           
           
               
          
             isLoading
                  ? LoadingButton(
                      colorButton: Colors.redAccent,
                    )
                  :     PrimaryButton(
            onTap: () {
              if(_formKey.currentState!.validate()){
                isLoading=true;
                setState(() {
                  
                });
                            AuthController.resetPassword(context, mobile: widget.mobile, password: password.text).then((value){
                               isLoading=false;
                            setState(() {
                              
                            });
                              if(value==true){
                                  showSnackBar(context, "Success Update Password");
                              }else{

                              }
                           //   pushReplacementScreen(context, LoginScreen());
                            });
              }

            },
       colorButton: Colors.redAccent,
                      textColor: Colors.white,
            title: "Submit"),
          
                const  SpaceHeight(height: 2),
                
          
                  InkWell(
                    onTap: () {
                      pushScreen(context, LoginScreen());
                    },
                    child: Text(
                              "Login",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 2.5.sp,
                                  fontFamily: "Tajawal",
                                  fontWeight: FontWeight.w500,
                                  ),
                              ),
                  ),
          
                  
          
             const SpaceHeight(height: 4),
           
          

       
    
                  
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
  
    super.dispose();
  }
}
