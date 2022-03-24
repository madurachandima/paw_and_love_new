import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Widgets/dog_symptom_view.dart';
import 'package:paw_and_love/model/dog_illness_model.dart';
import 'package:sizer/sizer.dart';

class DogSymptomsViewCard extends StatelessWidget {
  final DogIllnessModel dogIllnessModel;
  const DogSymptomsViewCard({Key? key, required this.dogIllnessModel})
      : super(key: key);

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
            Get.to(() => DogSymptomView(dogIllnessModel: dogIllnessModel));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dogIllnessModel.name,
                style: TextStyle(color: ColorConfig.white, fontSize: 28.sp),
                maxLines: 2,
              ),
              Text(
                "Read more..",
                style: TextStyle(color: ColorConfig.white, fontSize: 15.sp),
              )
            ],
          ),
        ),
      ),
    );
  }
}
