import 'package:america/constants.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewScreen extends StatelessWidget {
  final String imageUrl;
  const ImagePreviewScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Constants.getWidth(context),
        height: Constants.getHeight(context),
    child: PhotoView(
      imageProvider: NetworkImage(imageUrl),
    )
  );
  }
}