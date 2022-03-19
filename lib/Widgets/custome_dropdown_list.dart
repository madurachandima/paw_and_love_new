import 'package:flutter/material.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Config/font_config.dart';
import 'package:sizer/sizer.dart';

class CustomeDropDownList extends StatelessWidget {
  final Function(String?)? onChanged;
  final String? dropdownValue;
  final dynamic dropdownItems;
  const CustomeDropDownList(
      {Key? key,
      required this.onChanged,
      required this.dropdownValue,
      required this.dropdownItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.5.h,
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: ColorConfig.orange, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(
              Icons.arrow_drop_down_circle_outlined,
              color: ColorConfig.orange,
              size: 30,
            ),
            elevation: 2,
            onChanged: onChanged,
            items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                      color: ColorConfig.orange,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: REGULAR_FONT),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
    ;
  }
}
