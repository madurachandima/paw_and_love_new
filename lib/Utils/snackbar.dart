import 'package:flutter/material.dart';
import 'package:get/get.dart';

flutterToastMessage(
    {required String title,
    required String message,
    required SnackPosition position,
    required Color backgroundColor}) {
  Get.snackbar(title, message,
      snackPosition: position,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      snackStyle: SnackStyle.FLOATING,
      isDismissible: true,
      barBlur: 0.5);
}
