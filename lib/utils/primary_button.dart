import 'package:america/utils/app_ui.dart';
import 'package:flutter/material.dart';


class PrimaryButton extends StatelessWidget {
  final String title;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? colorButton;
  final Color? textColor;
  final double? fontsize;
  final Function()? onTap;
  const PrimaryButton({
    Key? key,
    required this.title,
    this.width,
    this.height,
    this.borderRadius,
    this.colorButton,
    this.textColor,
    this.fontsize,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return Container(
        width: width ??  82.w,
        height: height ?? 8.sp,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius ?? 20.sp),
          
     
        //  color: AppUi.colors.primaryNormal,        
      //   boxShadow: const [
      // BoxShadow(
      //     color: Color(0x4c000000),
      //     blurRadius: 3,
      //     offset: Offset(0, 1),
      // ),
      // BoxShadow(
      //     color: Color(0x26000000),
      //     blurRadius: 8,
      //     offset: Offset(0, 4),
      // ),
      //       ],
            ),
  

        child: Container(
         // decoration: BoxDecoration(gradient: AppUi.colors.secondaryGradient,borderRadius: BorderRadius.circular(borderRadius ?? 20.sp),),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(  
    backgroundColor:  colorButton ??   Color(0xFFF8D859),
             ),
            onPressed:onTap, child: Text(title,
            textAlign: TextAlign.center,
            style:TextStyle(color: textColor ?? Colors.black,fontWeight: FontWeight.w700 ,fontSize: fontsize ?? AppUi.fontSizes.meduimTitle))),
        ),
  
    );
  }
}


class PrimaryOutlinedButton extends StatelessWidget {
  final String title;
  final double? width;
  final double? height;
  final Color? colorButton;
  final Color? textColor;
  final double? fontsize;
  final Function()? onTap;
  const PrimaryOutlinedButton({
    Key? key,
    required this.title,
    this.width,
    this.height,
    this.colorButton,
    this.textColor,

    this.fontsize,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return Container(
        width: width ??  82.w,
        height: height ?? 8.sp,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.sp),     
      ),
      child: OutlinedButton(
        
           style: OutlinedButton.styleFrom(
  
    backgroundColor: Colors.transparent,
     side: BorderSide(width: 1, color: colorButton ??  AppUi.colors.primaryNormal), // background color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50), // rounded corners
      //side: BorderSide(color: Colors.red, width: 5),
    ),),
        onPressed:onTap, child: Text(title,
                    textAlign: TextAlign.center,
        style:TextStyle(color: textColor ?? AppUi.colors.primaryNormal,fontSize: fontsize ?? AppUi.fontSizes.smallTitle))),
    );
  }
}