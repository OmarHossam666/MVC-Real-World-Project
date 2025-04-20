// ignore_for_file: public_member_api_docs, sort_constructors_first, body_might_complete_normally_nullable
import 'package:america/utils/app_ui.dart';
import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {

  final double? width;
  final double? height;
  final String? hintText;
  final bool? isPassword;
  final Widget? suffixIcon;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String? Function(String? val)? validator;

  final dynamic onChanged;
  final dynamic onSubmit;
  final Function()? onTap;

  final bool disableWrite ;
  final Color? borderColor;

  const CustomTextField({
    Key? key,
    this.onTap,
    this.disableWrite=false,
    this.width,
    this.height,
    this.hintText,
    this.isPassword,
    this.suffixIcon,
    this.textEditingController,
    this.textInputType,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.onSubmit,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
           width: width ?? MediaQuery.of(context).size.width * 0.85,
                height: height ?? 8.h,
              decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: borderColor !=null ? Border.all(
      color: borderColor!, // Replace with your desired border color
      width: 1, // Replace with your desired border width
    ): null,
            boxShadow: const [
                BoxShadow(
                    color: Color(0x29000000),
                    blurRadius: 3,
                    offset: Offset(0, 3),
                ),
            ],
            color: Colors.white,
              ),
      child: Container(
                     
                        padding: const EdgeInsets.only(right:10, left:10,top: 5),
                        child: TextFormField(
                          onTap: onTap,
                          readOnly: disableWrite,
                          controller: textEditingController,
                        
                          keyboardType: textInputType ?? TextInputType.text,
                          textInputAction: textInputAction ?? TextInputAction.next,
                         decoration: InputDecoration(border: InputBorder.none,
    focusedBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    disabledBorder: InputBorder.none,hintText: hintText?? "",suffixIcon: suffixIcon,hintStyle: TextStyle(color: borderColor??Colors.grey)),
                          obscureText: isPassword ?? false,
                          validator: validator ?? (val){},
                          onChanged: onChanged ?? (val){},
                          onFieldSubmitted: onSubmit ?? (val){},
                          
                        ),
                      ),
    );
  }
}
