import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/screens/vet/vet_clinic_view.dart';
import 'package:sizer/sizer.dart';

class VetProfileCircularAvatar extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final snap;

  const VetProfileCircularAvatar({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 35),
      child: InkWell(
        onTap: () => Get.to(ViewClinic(
          snap: snap,
        )),
        child: Container(
            height: 90,
            width: 90,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: ColorConfig.orange,
                border: Border.all(color: ColorConfig.yellow, width: 6.5),
                borderRadius: const BorderRadius.all(Radius.circular(360))),
            child: Center(
                child: Text(
              snap['clinic_address'].substring(0, 1).toUpperCase(),
              style: TextStyle(color: ColorConfig.white, fontSize: 30.sp),
            ))),
      ),
    );
  }
}
