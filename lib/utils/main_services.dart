import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

callNumber(phone) async {
  try {
    Uri email = Uri(
      scheme: 'tel',
      path: phone,
    );

    await launchUrl(email);
  } catch (e) {
    debugPrint(e.toString());
  }
}