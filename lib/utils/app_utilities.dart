


import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'app_ui.dart';





class ContentType {
  final String message;

  final Color? color;

  ContentType(this.message, [this.color]);

  static ContentType failure = ContentType('failure', AppUi.colors.failureRed);
  static ContentType success =
      ContentType('success', AppUi.colors.successGreen);
  static ContentType warning = ContentType('warning', Colors.yellowAccent);
}

class AppUtil {




 

  static appAlert(context,
      {String? title, String? msg, ContentType? contentType}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        dismissDirection: DismissDirection.horizontal,
       // padding: EdgeInsets.only(bottom: 10.h,right: 10.sp ,left:  20.sp ),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: Container(
            decoration: BoxDecoration(
              color: contentType == ContentType.warning
                  ? Color.fromARGB(255, 249, 203, 65)
                  : contentType == ContentType.failure
                      ? const Color.fromARGB(255, 117, 18, 95)
                      : contentType == ContentType.success
                          ?  Colors.green
                          : const Color.fromARGB(255, 240, 213, 186),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Expanded(
                //   flex: 2,
                //   child: Container(
                 
                //        padding:
                //        EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                //       decoration: BoxDecoration(
                //         color: contentType == ContentType.warning
                //             ? Colors.amber[400]
                //             : contentType == ContentType.failure
                //                 ? AppUi.colors.failureRed
                //                 : AppUi.colors.successGreen,
                //         borderRadius: const BorderRadius.only(
                //             topRight: Radius.circular(5),
                //             bottomRight: Radius.circular(5)),
                //       ),
                //       child: contentType == ContentType.failure 
                //           ? Image.asset(AppUi.assets.failIcon) :
                //        contentType == ContentType.warning ? Container()    : Image.asset(AppUi.assets.successIcon)),
                // ),
                SizedBox(
                  width: 3.w,
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                    title==null ? Container() :    Text(
                          title ?? '',
                          style: TextStyle(    fontSize: 3.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,),
                      
                        ),
                       title==null ? Container() :     SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          msg ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          style: TextStyle(    fontSize: 2.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,),
                      
                        ),
                       
                      ],
                    ),
                  ),
                )
              ],
            ))));
  }

    static Widget appLoader({bool isSmall = false}) => Align(
        alignment: Alignment.center,
        child: LottieBuilder.asset(AppUi.assets.loading, height: 13.h),
      );
}
