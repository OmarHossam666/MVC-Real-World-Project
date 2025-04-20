// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:america/utils/app_ui.dart';
import 'package:flutter/material.dart';

import 'space_widget.dart';




class CustomTextFormField extends StatelessWidget {

  final double? width;
  final double? height;
  final String title;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String? val)? validator;
  final Function(String s)? onChange;
  final Widget? suffixIcon;
  final bool? readOnly;
  final bool? obsecureText;
  final int? maxLines;
  final Color? fieldColor;
  final double? textWidth;
  final bool autoValidate;
  final TextInputType? textInputType;

  final Function()? onTap;

  const CustomTextFormField({
    Key? key,
    this.width,
    this.height,
    required this.title,
    this.textInputType,
    this.maxLines,
    this.textWidth,
    this.hint,
    this.controller,
    this.validator,
    this.onChange,
    this.suffixIcon,
    this.readOnly,
    this.onTap,
    this.obsecureText,
    this.fieldColor,
    this.autoValidate=false,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         
          children: [
            Container(
              width: textWidth,

              child: FittedBox(
                child: Text(
                  title,
                
                  style: const TextStyle(
                      color: Color(0xff050e19),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.50,
                      
                  ),
                        ),
              ),
            ),
         const SpaceWidget(size:1),
            Stack(
              children: [
                Container(
                  width: width ??  90.w,
                  height: height ??  5.7.h,
                  padding: EdgeInsets.symmetric(horizontal: 1.sp),
            
                  decoration: BoxDecoration(
                    color: fieldColor ?? Colors.white,
                    border: Border.all(color: const Color(0xffB2BBC6),width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
              
                ),
            
                Container(
                    width: width ??  100.w,
                    height: 20.h,
                    padding: EdgeInsets.only(right:1.5.sp,left: 1.5.sp),
                    child: TextFormField(
                    autovalidateMode: autoValidate ?  AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                      controller: controller,
                      textInputAction: TextInputAction.next,
                      keyboardType: textInputType ?? TextInputType.text,
                      readOnly: readOnly ?? false,
                      obscureText: obsecureText??false,
                      maxLines:  maxLines ?? 1,
                      decoration: InputDecoration(
                        
                     // contentPadding: const EdgeInsets.symmetric(horizontal:10.0),
                      
                        border: InputBorder.none,
                        hintText: hint ?? "",
                        hintStyle: TextStyle(fontWeight: FontWeight.w500,color: const Color(0xffB2BBC6),fontSize: AppUi.fontSizes.smallTitle),
                      //  suffixIcon: suffixIcon,
                        
                        suffixIcon: suffixIcon
                  
                      ),
                      validator: validator,
                      onChanged: onChange,
                      onTap: onTap,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}









