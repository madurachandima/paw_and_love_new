import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/model/vet_clinic_model.dart';
import 'package:sizer/sizer.dart';

class VetViewCard extends StatelessWidget {
  final VetClinicModel? vetClinicModel;
  const VetViewCard({Key? key, this.vetClinicModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: ColorConfig.yellow,
      child: SizedBox(
        height: 15.h,
        width: double.infinity,
        child: InkWell(
          onTap: () {
            // Get.to(() => DogSymptomView(dogIllnessModel: vetprofileModel));
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      vetClinicModel!.clinicName.toString(),
                      style:
                          TextStyle(color: ColorConfig.white, fontSize: 28.sp),
                      maxLines: 2,
                    ),
                    Text(
                      vetClinicModel!.clinicLocation.toString(),
                      style:
                          TextStyle(color: ColorConfig.white, fontSize: 15.sp),
                    )
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: ColorConfig.textColorDark,
                  size: 42.sp,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
