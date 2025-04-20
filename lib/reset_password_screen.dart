// // ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, sized_box_for_whitespace

// import 'dart:developer';

// import 'package:america/controllers/AuthController.dart';
// import 'package:america/utils/app_ui.dart';
// import 'package:country_code_picker/country_code_picker.dart';

// import 'package:flutter/foundation.dart';

// import 'package:flutter/material.dart';

// import 'constants.dart';
// import 'pin_code_screen.dart';
// import 'services/navigator_utils.dart';
// import 'utils/loading_button.dart';
// import 'utils/primary_button.dart';

// import 'utils/space_widget2.dart';
// import 'utils/validation.dart';
// import 'views/login_screen.dart';





// class ResetPasswordScreen extends StatefulWidget {
//   @override
//   _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
// }

// class _ResetPasswordScreenState extends State<ResetPasswordScreen>
//   {


//   bool isPassword = true;
//      TextEditingController mobile = TextEditingController();
//   bool acceptTerms=false;

//      String countryCode = "+962";

//      bool type = false;


//    final _formKey = GlobalKey<FormState>();
 

//   final TextEditingController email = TextEditingController();
//   final TextEditingController password = TextEditingController();

 

//   final formKey = GlobalKey<FormState>();

//   bool isLoading = false;

//   int selectedRadio = 1;


   

//   @override
//   void initState() {
//     super.initState();


//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:   AppBar(
//         backgroundColor: Colors.red,
//         title: Text(
//           "Forget Password",
//           style: TextStyle(fontSize: 25),
//         ),
//       ),
//       body: Container(
//         width: Constants.getWidth(context),
//         height: Constants.getHeight(context),
//         decoration:  BoxDecoration(
          
//           ),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
                
//               Image.asset('assets/images/logo.png',width: Constants.getWidth(context)*0.35,height: Constants.getHeight(context)* 0.35,),

          
                 
//              const  SpaceHeight(height: 1),
    
//                Padding(
//                 padding: EdgeInsets.only(right: 2.sp, left: 2.sp),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Padding(
//                           padding:  EdgeInsets.all(3.sp),
//                           child: Text(
//                             "Forget Password",
//                             style: TextStyle(
//                            color: Colors.redAccent,
//                               fontSize: 3.sp,
//                               decorationStyle: TextDecorationStyle.solid,
//                               decorationThickness: 2.0,
//                               decorationColor: const Color(0xff5b7db1),
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Radio(
//                               value: 1,
//                               groupValue: selectedRadio,
//                               focusColor: Colors.redAccent,
//                               activeColor:Colors.redAccent,
//                               onChanged: (value) {
//                                 setState(() {
//                                   selectedRadio = value as int;
//                                 });
//                               },
//                             ),
//                             Text(
//                               "Phone",
//                               style: TextStyle(
                                
//                                 fontSize: 2.5.sp,
//                                 decorationStyle: TextDecorationStyle.solid,
//                                 decorationThickness: 2.0,
                             
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Radio(
//                               value: 2,
//                               groupValue: selectedRadio,
//                                    focusColor: Colors.redAccent,
//                               activeColor:Colors.redAccent,
//                               onChanged: (value) {
//                                 setState(() {
//                                   selectedRadio = value as int;
//                                 });
//                               },
//                             ),
//                             Text(
//                               'Email',
//                               style: TextStyle(
                               
//                                 fontSize: 2.5.sp,
//                                 decorationStyle: TextDecorationStyle.solid,
//                                 decorationThickness: 2.0,
                              
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

                  
//                              selectedRadio == 2
//                   ? Container(
//                       width: MediaQuery.of(context).size.width * 0.85,
//                       height: 7.5.h,
//                       padding: const EdgeInsets.only(right: 15, left: 15),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Color(0x29000000),
//                             blurRadius: 3,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                         color: Colors.white,
//                       ),
//                       child: TextFormField(
//                         controller: email,
//                         //  keyboardType: TextInputType.phone,
//                         decoration: InputDecoration(
//                           enabledBorder: InputBorder.none,
//                           focusedBorder: InputBorder.none,
//                           hintText: "Email",
//                         ),

//                         validator: (val) {
//                           return AppValidations.generalValidation(val!);
//                         },
//                       ),
//                     )
//                   : Container(
//                       width: MediaQuery.of(context).size.width * 0.85,
//                       height: 7.5.h,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Color(0x29000000),
//                             blurRadius: 3,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                         color: Colors.white,
//                       ),
//                       child: Center(
//                         child: Row(
//                           children: [
//                             Container(
//                               width: MediaQuery.of(context).size.width * 0.27,
//                               child: CountryCodePicker(
//                                 onChanged: (code) {
//                                   log(code.dialCode.toString());
//                                   countryCode = code.dialCode!;
//                                   log(countryCode.substring(1));
//                                 },
//                                 // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
//                                 initialSelection: 'US',
                             
//                                 // countryFilter: ['EG', 'SA', 'JO', 'AE', 'LB', 'SY', 'LY', 'MA', 'YE', 'IQ', 'KW', 'QA', 'BH', 'OM', 'TN', 'SD', 'DZ', 'MR', 'TN', 'PS'],

//                                 //    favorite: ['+962'],
//                                 //   favorite: [ '+962','+971','+213' ,'+966' ,'+20', '+964','+970' , '+961', '+963', '+218', '+212', '+967',],

//                                 // optional. Shows only country name and flag
//                                 showCountryOnly: false,
//                                 // optional. Shows only country name and flag when popup is closed.
//                                 showOnlyCountryWhenClosed: false,

//                                 //   alignLeft: false,
//                                 // optional. aligns the flag and the Text left
//                                 // alignLeft: false,
//                               ),
//                             ),
//                             Container(
//                               width: MediaQuery.of(context).size.width * 0.5,
//                               child: TextFormField(
//                                   controller: mobile,
//                                   validator: (val) {
//                                     return AppValidations.generalValidation(
//                                         val!);
//                                   },
//                                   textInputAction: TextInputAction.next,
//                                   keyboardType: TextInputType.phone,
//                                   decoration: InputDecoration(
//                                     enabledBorder: InputBorder.none,
//                                     focusedBorder: InputBorder.none,
//                                     hintText: "Your Phone Number",
//                                   )),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
      
            
//              const  SpaceHeight(height: 10),
               
                
           
           
               
          
//              isLoading
//                   ? LoadingButton(
//                       colorButton: Colors.redAccent,
//                     )
//                   :      PrimaryButton(
//             onTap: ()async {

//               if(selectedRadio == 2){
//                 if(email.text.isNotEmpty){
//                   setState(() {
//                     isLoading=true;
//                   });
//                            await    AuthController.sendEmailForget(context, email: email.text);

//                             setState(() {
//                     isLoading=false;
//                   });
//                 }
//                 // Email 
   
//               }else{
//                  pushScreen(context, PinCodeScreen(phone:"$countryCode${mobile.text}" ,register: false,));
//               }
             
//             },
//                      colorButton: Colors.redAccent,
//                       textColor: Colors.white,
            
//             title: selectedRadio==2?"Send Email" : "Continue"),
          
//                 const  SpaceHeight(height: 2),
                
          
//                   InkWell(
//                     onTap: () {
//                       pushScreen(context, LoginScreen());
//                     },
//                     child: Text(
//                                "Login",
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 2.5.sp,
//                                   fontFamily: "Tajawal",
//                                   fontWeight: FontWeight.w500,
//                                   ),
//                               ),
//                   ),
          
                  
          
//              const SpaceHeight(height: 4),
           
          

       
    
                  
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
  
//     super.dispose();
//   }
// }
