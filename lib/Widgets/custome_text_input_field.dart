import 'package:flutter/material.dart';
import 'package:paw_and_love/Config/font_config.dart';
import 'package:sizer/sizer.dart';

class CustomeTextInputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final String lableText;
  final TextInputType textInputType;
  final Color textColor;
  final bool isReadOnly;
  final bool isMultyLineText;
  final bool isEnableInputAction;
  var callbackFunction;
  var onSubmitCallbackFunction;

  CustomeTextInputField(
      {Key? key,
      required this.textEditingController,
      required this.isPass,
      required this.hintText,
      required this.lableText,
      required this.textInputType,
      required this.textColor,
      required this.isReadOnly,
      this.isMultyLineText = false,
      this.callbackFunction,
      this.onSubmitCallbackFunction,
      this.isEnableInputAction = false})
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
      onTap: () {
        if (callbackFunction != null) {
          callbackFunction();
        }
      },
      onSubmitted: (string) {
        // print(string);
        if (onSubmitCallbackFunction != null) {
          onSubmitCallbackFunction(string);
        }
      },
      // textInputAction: isMultyLineText
      //     ? TextInputAction.newline
      //     : isEnableInputAction
      //         ? TextInputAction.newline
      //         : TextInputAction.none,
      textInputAction:
          isMultyLineText ? TextInputAction.newline : TextInputAction.done,
      minLines: 1,
      maxLines: isMultyLineText ? 5 : 1,
      readOnly: isReadOnly,
      controller: textEditingController,
      style: TextStyle(
          color: textColor, fontSize: 15.sp, fontFamily: REGULAR_FONT),
      decoration: InputDecoration(
        //labelText: lableText,
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
      obscureText: isPass,
    );
  }
}
