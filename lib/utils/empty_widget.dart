import 'package:america/constants.dart';
import 'package:america/utils/SizeConfig.dart';
import 'package:america/utils/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:lottie/lottie.dart';



class EmptyWidget extends StatelessWidget {
  final String hint;
  const EmptyWidget({super.key, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         
          SizedBox(
            width: Constants.getWidth(context)*0.8,
            child: Text(hint,
            textAlign: TextAlign.center,
            style: TextStyle( fontWeight: FontWeight.bold,fontSize: 3.5.sp,color: Colors.redAccent),)),
    
    
        ],
      ),
    );
  }
}