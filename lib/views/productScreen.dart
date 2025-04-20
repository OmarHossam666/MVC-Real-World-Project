import 'dart:developer';

import 'package:america/constants.dart';
import 'package:america/controllers/ProductController.dart';

import 'package:america/models/Catogry.dart';
import 'package:america/models/MyResponse.dart';
import 'package:america/models/Product.dart';
import 'package:america/utils/app_ui.dart';
import 'package:america/utils/space_widget2.dart';
import 'package:america/widgets/category_item_widget.dart';
import 'package:america/widgets/product_widget.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:america/AppTheme.dart';
import 'package:america/AppThemeNotifier.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  //Theme Data
  late ThemeData themeData;
  late CustomAppTheme customAppTheme;

  bool isInProgress = false;
  List<Product>? products;

  CategoryModel? categoryModel;
  Category? selectedCategory;

  bool getAllProductsOrNone = false;

  @override
  void initState() {
    super.initState();
    getCategories();
    getProducts();
  }

  getCategories() async {
    if (mounted) {
      setState(() {
        isInProgress = true;
      });
    }

    MyResponse<CategoryModel> myResponseCategories =
        await ProductController.getAllCategoriesWithProducts();
    MyResponse<List<Product>> myResponseProducts =
        await ProductController.getAllProduct();

    if (myResponseCategories.success) {
      print("Product done12");
      print(myResponseCategories.data);
      categoryModel = myResponseCategories.data;
    } else {
      categoryModel = null;
      categoryModel = CategoryModel(categories: []);

      print("Product er");
    }

    if (myResponseProducts.success) {
      print("Product done12");
      print(myResponseProducts.data);
      products = myResponseProducts.data;
      categoryModel!.categories!
          .insert(0, Category(name: "All", products: myResponseProducts.data));

      if (categoryModel!.categories!.length > 0) {
        selectedCategory = categoryModel!.categories![0];
      }
    } else {
      products = [];

      print("Product er");
    }

    if (mounted) {
      setState(() {
        isInProgress = false;
      });
    }
  }

  getProducts() async {
    if (mounted) {
      setState(() {
        isInProgress = true;
      });
    }

    MyResponse<List<Product>> myResponse =
        await ProductController.getAllProduct();

    if (myResponse.success) {
      print("Product done12");
      print(myResponse.data);
      products = myResponse.data;
    } else {
      print("Product er");
    }

    if (mounted) {
      setState(() {
        isInProgress = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeNotifier>(
        builder: (BuildContext context, AppThemeNotifier value, Widget? child) {
      int themeType = value.themeMode();
      themeData = AppTheme.getThemeFromThemeMode(themeType);
      customAppTheme = AppTheme.getCustomAppTheme(themeType);

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  )),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                ),
                child: Text(
                  "Welcome",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
          leadingWidth: 200,
          actions: [
            // IconButton(
            //     onPressed: () {
            //       AuthController.logoutUser();
            //       pushReplacementScreen(context, LoginScreen());
            //     },
            //     icon: Icon(
            //       Icons.logout,
            //       color: Colors.white,
            //     ))
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Image.asset("assets/images/logo.png",
                width: Constants.getWidth(context),
                height: Constants.getHeight(context) * 0.3,
                fit: BoxFit.fill),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1.5,
              color: Color(0xffc7485f),
            ),
            isInProgress
                ? Container(
                    width: Constants.getWidth(context),
                    height: Constants.getHeight(context) * 0.6,
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.redAccent),
                    ),
                  )
                : Column(
                    children: [
                      SpaceHeight(height: 2),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Shop By Category",
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 3.7.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Constants.getHeight(context) * 0.3,
                        child: ListView.builder(
                            itemCount: categoryModel!.categories!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              Category category =
                                  categoryModel!.categories![index];
                              return CategoryItem(
                                  onTap: () {
                                    selectedCategory = category;
                                    setState(() {});
                                  },
                                  isSelected: category == selectedCategory,
                                  imageUrl: category.photo.toString(),
                                  categoryName: category.name.toString());
                            }),
                      ),
                      selectedCategory != null
                          ? Column(
                              children: [
                                ListView.builder(
                                    shrinkWrap: true, // Add this line
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        selectedCategory!.products!.length,
                                    itemBuilder: (context, index) {
                                      Product product =
                                          selectedCategory!.products![index];

                                      return ProductWidget(product: product);
                                    })
                              ],
                            )
                          : Container()
                    ],
                  ),
          ],
        )),
      );
    });
  }
}
