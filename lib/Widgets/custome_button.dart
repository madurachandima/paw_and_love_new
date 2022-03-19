// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Config/font_config.dart';
import 'package:paw_and_love/Widgets/customeCircularProgress.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class CustomeButton extends StatelessWidget {
  final String buttonText;
  final Color backgroundColor;
  var getxController;
  var callbackFunction;
  CustomeButton(
      {Key? key,
      required this.buttonText,
      this.backgroundColor = ColorConfig.darkBlue,
      required this.getxController,
      required this.callbackFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: MediaQuery.of(context).size.width / 1.1,
      child: Obx(() => ElevatedButton(
            onPressed: () => callbackFunction(),
            child: getxController!.isUploading!.value
                ? CustomeCircularProgress(
                    color: ColorConfig.white,
                  )
                : Text(
                    buttonText.toUpperCase(),
                    style: TextStyle(
                        fontFamily: REGULAR_FONT,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 4),
                  ),
            style: ButtonStyle(
                //  foregroundColor: MaterialStateProperty.all<Color>(ColorCt),
                backgroundColor:
                    MaterialStateProperty.all<Color>(backgroundColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  /*   side: const BorderSide(color: Colors.white) */
                ))),
          )),
    );
  }
}
