import 'package:america/models/Product.dart';
import 'package:america/utils/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.network(
            product.photo,
            width: 30.sp,
            height: 20.sp,
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 30.sp,
                child: RichText(
                  text: TextSpan(
                    text: "${product.after_price.toString()}" + "  ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 4.sp),
                    children: <TextSpan>[
                      TextSpan(
                          text: product.price,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 4.sp)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                  width: 30.sp,
                  child: Text(
                    "${product.name}",
                    style: TextStyle(fontSize: 2.6.sp),
                  )),
              SizedBox(
                  width: 30.sp,
                  child: Text(
                    "Valid : ${DateFormat('MMM d, yyyy').format(DateTime.parse(product.start_at!))} - ${DateFormat('MMM d, yyyy').format(DateTime.parse(product.end_at!))}",
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
