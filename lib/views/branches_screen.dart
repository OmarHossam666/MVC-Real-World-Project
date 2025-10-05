import 'dart:developer';

import 'package:america/constants.dart';
import 'package:america/controllers/Branches_Controller.dart';
import 'package:america/models/MyResponse.dart';
import 'package:america/models/stores_model.dart';
import 'package:america/services/navigator_utils.dart';
import 'package:america/utils/app_ui.dart';
import 'package:america/utils/empty_widget.dart';
import 'package:america/utils/main_services.dart';
import 'package:america/utils/space_widget.dart';
import 'package:america/utils/space_widget2.dart';
import 'package:america/views/homeScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({super.key});

  @override
  State<BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  StoresModel? stores;

  bool loadingInProgress = false;

  getStores() async {
    loadingInProgress = true;
    setState(() {});
    MyResponse<StoresModel> myResponse = await BranchesController.getBranches();

    if (myResponse.success) {
      print(myResponse.data);
      stores = myResponse.data;
    } else {}

    loadingInProgress = false;
    setState(() {});
  }

  @override
  void initState() {
    getStores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
          ),
          child: Text(
            "Stores",
            style: TextStyle(fontSize: 25),
          ),
        ),
        leadingWidth: 200,
        actions: [],
      ),
      body: SingleChildScrollView(
        child: loadingInProgress
            ? SizedBox(
                width: Constants.getWidth(context),
                height: Constants.getHeight(context),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.redAccent,
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(bottom: 3.sp),
                child: stores!.stores!.isEmpty
                    ? EmptyWidget(
                        hint: "No Branches Found",
                      )
                    : SizedBox(
                        width: Constants.getWidth(context),
                        //height: Constants.getHeight(context) * 0.7,
                        child: Column(children: [
                          Center(
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: Constants.getWidth(context) * 0.75,
                              height: Constants.getWidth(context) * 0.75,
                            ),
                          ),
                          ...stores!.stores!.map((e) {
                            return InkWell(
                              onTap: () {
                                log(e.id.toString());
                                BranchesController.selectedStore = e.id;
                                BranchesController.selectedStoreName = e.name;
                                pushReplacementScreen(context, HomeScreen());
                                BranchesController.updateStoreId(
                                    e.id.toString());
                              },
                              child: Container(
                                width: Constants.getWidth(context) * 0.9,
                                padding: EdgeInsets.only(
                                    right: 2.sp, left: 2.sp, bottom: 2.sp),
                                child: Container(
                                  padding: EdgeInsets.all(3.sp),
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(4.sp),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x29000000),
                                        blurRadius: 3,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // e.photo!.isEmpty
                                        //     ? Container()
                                        //     : Container(
                                        //         child: ClipRRect(
                                        //           borderRadius:
                                        //               BorderRadius.circular(
                                        //                   3.sp),
                                        //           child: Image.network(
                                        //             e.photo.toString(),
                                        //             height: 30.sp,
                                        //             width: Constants.getWidth(
                                        //                 context),
                                        //             fit: BoxFit.fill,
                                        //           ),
                                        //         ),
                                        //       ),
                                        // SpaceHeight(height: 3),
                                        SizedBox(
                                          width:
                                              Constants.getWidth(context) * 0.5,
                                          child: Text(
                                            e.name ?? "",
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 4.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        //   SpaceHeight(height: 2),
                                        // Row(
                                        //   children: [
                                        //     Icon(
                                        //       Icons.place_outlined,
                                        //       size: 3.sp,
                                        //       color: Colors.redAccent,
                                        //     ),
                                        //     SpaceWidth(width: 2),
                                        //     Container(
                                        //       width:
                                        //           Constants.getWidth(context) *
                                        //               0.6,
                                        //       child: Text(
                                        //         e.address ?? "",
                                        //         maxLines: 1,
                                        //         overflow: TextOverflow.clip,
                                        //         style: TextStyle(
                                        //           color: Colors.redAccent,
                                        //           decoration:
                                        //               TextDecoration.underline,
                                        //           fontSize: 3.sp,
                                        //           fontWeight: FontWeight.w400,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        // SpaceHeight(height: 2),
                                        // InkWell(
                                        //   onTap: () {
                                        //     callNumber(e.phone.toString());
                                        //   },
                                        //   child: Container(
                                        //     width: Constants.getWidth(context) *
                                        //         0.5,
                                        //     child: Row(
                                        //       children: [
                                        //         Icon(
                                        //           Icons.call,
                                        //           size: 3.sp,
                                        //           color: Colors.redAccent,
                                        //         ),
                                        //         SpaceWidth(width: 2),
                                        //         Text(
                                        //           e.phone ?? "",
                                        //           maxLines: 1,
                                        //           overflow: TextOverflow.clip,
                                        //           style: TextStyle(
                                        //             color: Colors.redAccent,
                                        //             decoration: TextDecoration
                                        //                 .underline,
                                        //             fontSize: 3.sp,
                                        //             fontWeight: FontWeight.w400,
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ]),
                                ),
                              ),
                            );
                          }),
                        ]))),
      ),
    );
  }
}
