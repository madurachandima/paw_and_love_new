import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Config/font_config.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class ContactButton extends StatelessWidget {
  final String buttonText;
  final Color backgroundColor;
  var callbackFunction;

  ContactButton(
      {Key? key,
      required this.buttonText,
      this.backgroundColor = ColorConfig.darkBlue,
      required this.callbackFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 55,
        width: MediaQuery.of(context).size.width / 1.1,
        child: ElevatedButton(
          onPressed: () => callbackFunction(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  buttonText.toUpperCase(),
                  style: TextStyle(
                      fontFamily: REGULAR_FONT,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 4),
                ),
                const Icon(CupertinoIcons.phone_arrow_up_right)
              ],
            ),
          ),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(backgroundColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                /*   side: const BorderSide(color: Colors.white) */
              ))),
        ));
  }
}
