import 'package:america/utils/app_ui.dart';
import 'package:flutter/material.dart';


class LoadingButton extends StatelessWidget {
 
  final double? width;
  final double? height;
  final Color? colorButton;

  const LoadingButton({
    Key? key,
   
    this.width,
    this.height,
    this.colorButton,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return Container(
        width: width ??  82.w,
        height: height ?? 8.sp,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.sp),        
        boxShadow: const [
      BoxShadow(
          color: Color(0x4c000000),
          blurRadius: 3,
          offset: Offset(0, 1),
      ),
      BoxShadow(
          color: Color(0x26000000),
          blurRadius: 8,
          offset: Offset(0, 4),
      ),
            ],),
      child: Container(
       // decoration: BoxDecoration(gradient: AppUi.colors.secondaryGradient,borderRadius: BorderRadius.circular( 20.sp),),
        child: ElevatedButton(
  style: ElevatedButton.styleFrom(  
              backgroundColor:  colorButton ??   Color(0xFFF8D859),
            ),
          onPressed:() {
          
        }, child: SizedBox(
          width: height !=null ?  height!/3 : 4.sp,
          height: height !=null ?  height!/3 : 4.sp,
          child: const CircularProgressIndicator(color: Colors.white,strokeWidth: 3,))),
      ),
    );
  }
}


class LoadingOutlinedButton extends StatelessWidget {

  final double? width;
  final double? height;
  final Color? colorButton;

  const LoadingOutlinedButton({
    Key? key,
    this.width,
    this.height,
    this.colorButton,

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
        onPressed:(){}, child: SizedBox(
          width: height !=null ?  height!/3 : 4.sp,
          height: height !=null ?  height!/3 : 4.sp,
          child: const CircularProgressIndicator(color: Colors.blueAccent,strokeWidth: 3,))),
    );
  }
}