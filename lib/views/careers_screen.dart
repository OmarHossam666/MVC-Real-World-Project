import 'dart:developer';

import 'package:america/constants.dart';
import 'package:america/controllers/CareersController.dart';
import 'package:america/models/Career.dart';
import 'package:america/models/MyResponse.dart';
import 'package:america/services/navigator_utils.dart';
import 'package:america/utils/app_ui.dart';
import 'package:america/utils/space_widget2.dart';

import 'package:america/views/apply_careers_screen.dart';
import 'package:flutter/material.dart';

class CareerScreen extends StatefulWidget {
  const CareerScreen({super.key});

  @override
  State<CareerScreen> createState() => _CareerScreenState();
}

class _CareerScreenState extends State<CareerScreen> {
  bool isInProgress = false;

  CareersModel? careers;

  getCareers() async {
    if (mounted) {
      setState(() {
        isInProgress = true;
      });
    }

    MyResponse<CareersModel> myResponse =
        await CareersController.getAllCareers();

    if (myResponse.success) {
      print("carrers done12");
      log(myResponse.data.toString());
      careers = myResponse.data;
    } else {
      print("carrers er");
    }

    if (mounted) {
      setState(() {
        isInProgress = false;
      });
    }
  }

  @override
  void initState() {
    getCareers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Careers",
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
          ),
          body: isInProgress
              ? SizedBox(
                  width: Constants.getWidth(context),
                  height: Constants.getHeight(context),
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.redAccent),
                  ),
                )
              : ListView.builder(
                  itemCount: careers!.careers!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(3.sp),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(3.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.work,
                                  size: 7.sp,
                                  color: Colors.blueAccent,
                                ),
                                SpaceWidth(width: 1),
                                Text(
                                  careers!.careers![index].title.toString(),
                                  style: TextStyle(
                                      fontSize: 4.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                pushScreen(
                                    context,
                                    ApplyCareerScreen(
                                        careers: careers!.careers![index]));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                              ),
                              child: Text(
                                "Apply",
                                style: TextStyle(
                                    fontSize: 4.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )),
    );
  }
}
