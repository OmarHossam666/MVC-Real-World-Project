import 'dart:developer';

import 'package:america/utils/app_ui.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Function() onTap;
  final String imageUrl;
  final String categoryName;
  final bool isSelected;
  const CategoryItem({
    required this.onTap,
    required this.imageUrl,
    required this.categoryName,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(top: 2.sp, bottom: 2.sp),
          child: Container(
            width: 60.w,
            decoration: BoxDecoration(
              color: isSelected ? Colors.red.withOpacity(0.3) : Colors.white,
              border: Border.all(color: Colors.grey, width: 0.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                imageUrl.isEmpty || imageUrl == "null"
                    ? Container()
                    : Container(
                        width: 50.w,
                        height: 50.w,
                        padding: EdgeInsets.all(2.sp),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                        child: Center(
                          child: Image.network(
                            imageUrl,
                            width: 30.sp,
                            height: 30.sp,
                          ),
                        ),
                      ),
                const SizedBox(height: 3),
                Container(
                  width: 60.sp,
                  height: 4.sp,
                  child: Text(
                    categoryName,
                    //   maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 3.5.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
