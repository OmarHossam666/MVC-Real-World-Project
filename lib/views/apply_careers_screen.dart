import 'dart:developer';
import 'dart:io';

import 'package:america/constants.dart';
import 'package:america/controllers/CareersController.dart';
import 'package:america/models/Career.dart';
import 'package:america/models/MyResponse.dart';
import 'package:america/services/general_image_picker.dart';
import 'package:america/utils/app_ui.dart';
import 'package:america/utils/space_widget2.dart';
import 'package:america/utils/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ApplyCareerScreen extends StatefulWidget {
  final Career careers;
  const ApplyCareerScreen({super.key, required this.careers});

  @override
  State<ApplyCareerScreen> createState() => _ApplyCareerScreenState();
}

class _ApplyCareerScreenState extends State<ApplyCareerScreen> {
  bool isInProgress = false;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController description = TextEditingController();

  File? selectedImage;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
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
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(3.sp),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
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
                                      widget.careers.title.toString(),
                                      style: TextStyle(
                                          fontSize: 4.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SpaceHeight(height: 2),
                          Text(
                            widget.careers.description.toString(),
                            style: TextStyle(
                                fontSize: 4.sp, fontWeight: FontWeight.bold),
                          ),
                          const SpaceHeight(height: 2),
                          // selectedImage != null
                          //     ? Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           Icon(Icons.file_copy, size: 7.sp),
                          //           SizedBox(
                          //             width: Constants.getWidth(context) * 0.3,
                          //             child: Text(
                          //               "Your CV",
                          //               maxLines: 1,
                          //               style: TextStyle(
                          //                   fontSize: 3.sp,
                          //                   fontWeight: FontWeight.bold),
                          //             ),
                          //           ),
                          //         ],
                          //       )
                          //     : Container(),
                          // const SpaceHeight(height: 2),
                          // ElevatedButton(
                          //   onPressed: () async {
                          //     selectedImage = await pickDocumentFile();
                          //     setState(() {});
                          //   },
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: Colors.blueAccent,
                          //   ),
                          //   child: Text(
                          //     "Upload Your CV",
                          //     style: TextStyle(
                          //         fontSize: 4.sp, fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                          const SpaceHeight(height: 2),
                          ...List.generate(
                              widget.careers.careerSpecifications!.length,
                              (index) {
                            if (widget.careers.careerSpecifications![index]
                                    .type ==
                                2) {
                              // Type 2 - Radio Button
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.careers.careerSpecifications![index]
                                        .name
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 3.5.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SpaceHeight(height: 2),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 2.sp),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0x29000000),
                                            blurRadius: 3,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        children: widget
                                            .careers
                                            .careerSpecifications![index]
                                            .careerSpecificationValues!
                                            .map((value) {
                                          return RadioListTile<String>(
                                            title: Text(
                                              value.value!,
                                              style:
                                                  TextStyle(fontSize: 3.5.sp),
                                            ),
                                            value: value.value.toString(),
                                            groupValue: CareersController
                                                    .applyData[
                                                "career_specifications[$index][value]"],
                                            onChanged: (selectedValue) {
                                              setState(() {
                                                CareersController.applyData[
                                                        "career_specifications[$index][career_specification_id]"] =
                                                    widget
                                                        .careers
                                                        .careerSpecifications![
                                                            index]
                                                        .id
                                                        .toString();
                                                CareersController.applyData[
                                                        "career_specifications[$index][value]"] =
                                                    selectedValue;
                                              });
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else if (widget.careers
                                    .careerSpecifications![index].type ==
                                3) {
                              return Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      selectedImage = await pickDocumentFile();
                                      CareersController.applyData[
                                              "career_specifications[$index][career_specification_id]"] =
                                          widget.careers
                                              .careerSpecifications![index].id
                                              .toString();
                                      CareersController.applyData[
                                              "career_specifications[$index][value]"] =
                                          selectedImage;
                                      setState(() {});
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueAccent,
                                    ),
                                    child: Text(
                                      widget.careers
                                          .careerSpecifications![index].name
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 4.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SpaceHeight(height: 2),
                                  CareersController.applyData[
                                              "career_specifications[$index][value]"] !=
                                          null
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.file_copy, size: 7.sp),
                                            SizedBox(
                                              child: Text(
                                                widget
                                                        .careers
                                                        .careerSpecifications![
                                                            index]
                                                        .name ??
                                                    "",
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 3.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                                  const SpaceHeight(height: 2),
                                ],
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 2.sp),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height: 7.5.h,
                                  padding: const EdgeInsets.only(
                                      right: 15, left: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x29000000),
                                        blurRadius: 3,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    //  keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: widget.careers
                                          .careerSpecifications![index].name
                                          .toString(),
                                    ),

                                    onChanged: (value) {
                                      CareersController.applyData[
                                              "career_specifications[$index][career_specification_id]"] =
                                          widget.careers
                                              .careerSpecifications![index].id
                                              .toString();
                                      CareersController.applyData[
                                              "career_specifications[$index][value]"] =
                                          value.toString();
                                    },
                                  ),
                                ),
                              );
                            }
                            return Container();
                          }),
                          const SpaceHeight(height: 2),
                          SizedBox(
                            width: Constants.getWidth(context) * 0.5,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  isInProgress = true;
                                  setState(() {});
                                  CareersController.applyCareers(
                                    context,
                                    careerId: widget.careers.id,
                                  ).then((value) {
                                    isInProgress = false;
                                    setState(() {});
                                  }).then((value) {
                                    Navigator.pop(context);
                                  });
                                }
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
    );
  }
}
