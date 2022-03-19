import 'package:flutter/cupertino.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:sizer/sizer.dart';

subHeadingStyle() {
  return TextStyle(
      color: ColorConfig.orange, fontSize: 18.sp, fontWeight: FontWeight.w500);
}

subTopicStyle() {
  return TextStyle(
    color: ColorConfig.orange,
    fontSize: 15.sp,
  );
}

defaultTextStyle() {
  return TextStyle(color: ColorConfig.textColorDark, fontSize: 14.sp);
}

defaultTextStyleSubTopic() {
  return TextStyle(color: ColorConfig.orange, fontSize: 18.sp);
}
