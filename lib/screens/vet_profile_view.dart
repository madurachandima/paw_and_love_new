import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Config/assets_path.dart';

import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/controller/home_controller.dart';
import 'package:paw_and_love/screens/add_new_clinic.dart';

import 'package:sizer/sizer.dart';

import 'package:paw_and_love/Widgets/custome_text_input_field.dart';

class ViewVetProfile extends StatelessWidget {
  const ViewVetProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController _homeController = Get.find();
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                centerTitle: false,
                elevation: 0,
                expandedHeight: 40.h,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    background: Obx(() => Stack(
                          alignment: Alignment.center,
                          fit: StackFit.expand,
                          children: [
                            _homeController.vetProfileModel.value.vetProfileUrl!
                                    .isEmpty
                                ? Image.asset(
                                    doctorProfile,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    _homeController
                                        .vetProfileModel.value.vetProfileUrl!,
                                    fit: BoxFit.cover,
                                  ),
                          ],
                        ))),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Text(
                    "Doctor Name",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 5, bottom: 10),
                      child: CustomeTextInputField(
                          isReadOnly: true,
                          textEditingController: TextEditingController(
                              text:
                                  "Dr ${_homeController.vetProfileModel.value.vetName}"),
                          isPass: false,
                          hintText: "Your Name",
                          lableText: "Please Enter Your Name",
                          textInputType: TextInputType.text,
                          textColor: ColorConfig.orange),
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Text(
                    "City",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: CustomeTextInputField(
                          isReadOnly: true,
                          textEditingController: TextEditingController(
                              text: _homeController.vetProfileModel.value.city),
                          isPass: false,
                          hintText: "Your Name",
                          lableText: "Please Enter Your Name",
                          textInputType: TextInputType.text,
                          textColor: ColorConfig.orange),
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Text(
                    "About",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: CustomeTextInputField(
                          isReadOnly: true,
                          textEditingController: TextEditingController(
                              text: _homeController
                                  .vetProfileModel.value.aboutVet),
                          isPass: false,
                          hintText: "Your Name",
                          lableText: "Please Enter Your Name",
                          textInputType: TextInputType.text,
                          textColor: ColorConfig.orange),
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Text(
                    "Add Clinic Places",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Wrap(
                  children: [
                    // Wrap(
                    //   children: snapshot.data!.docs
                    //       .map((item) => DogProfileCircularAvatar(
                    //             snap: item,
                    //           ))
                    //       .toList(),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 20.h,
                        width: 25.w,
                        child: IconButton(
                            onPressed: () {
                              Get.to(() => const AddnewClinic());
                            },
                            icon: const Icon(
                              CupertinoIcons.add_circled,
                              size: 100,
                              color: ColorConfig.yellow,
                            )),
                      ),
                    )
                  ],
                ),
              ]))
            ];
          },
          body: Container(
              // color: CupertinoColors.lightBackgroundGray,
              )),
    );
  }
}
