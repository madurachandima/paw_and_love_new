import 'package:flutter/material.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Config/font_config.dart';
import 'package:sizer/sizer.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController textEditingController;

  final String hintText;
  final String lableText;
  final TextInputType textInputType;
  final Color textColor;
  var callbackFunction;
  var onTextChange;
  final prefixIcon;
  SearchTextField(
      {Key? key,
      required this.textEditingController,
      required this.hintText,
      required this.lableText,
      required this.textInputType,
      required this.textColor,
      required this.callbackFunction,
      required this.onTextChange,
      this.prefixIcon = Icons.search})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(
        color: textColor,
      ),
    );

    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(
        color: textColor,
        width: 2.0,
      ),
    );

    return TextField(
      onChanged: onTextChange,
      controller: textEditingController,
      style: TextStyle(
          color: textColor, fontSize: 15.sp, fontFamily: REGULAR_FONT),
      decoration: InputDecoration(
        //labelText: lableText,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
              onPressed: () {
                callbackFunction();
              },
              icon: Icon(
                prefixIcon,
                size: 5.h,
                color: ColorConfig.orange,
              )),
        ),
        labelStyle: TextStyle(
            color: textColor, fontSize: 15.sp, fontFamily: REGULAR_FONT),
        hintText: hintText,
        hintStyle: TextStyle(
            color: textColor, fontSize: 15.sp, fontFamily: REGULAR_FONT),
        fillColor: textColor,
        focusedBorder: inputBorder,
        filled: false,
        enabledBorder: outlineInputBorder,
      ),
      keyboardType: textInputType,
    );
  }
}
