// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:america/utils/app_ui.dart';
import 'package:flutter/material.dart';


class SpaceHeight extends StatelessWidget {
  final double height;
  const SpaceHeight({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return  SizedBox( height: height.sp ,);
  }
}

class SpaceWidth extends StatelessWidget {
  final double width;
  const SpaceWidth({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return  SizedBox( width: width.sp ,);
  }
}
