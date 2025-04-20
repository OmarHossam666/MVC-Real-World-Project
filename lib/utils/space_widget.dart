import 'package:america/utils/app_ui.dart';
import 'package:flutter/cupertino.dart';



class SpaceWidget extends StatelessWidget {
  final bool isVertical;
  final bool isHorizontal;
  final double size;

  const SpaceWidget(
      {super.key,
      this.isVertical = true,
      this.isHorizontal = false,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isHorizontal ? size.h : 0,
      height: isVertical ? size.h : 0,
    );
  }
}
