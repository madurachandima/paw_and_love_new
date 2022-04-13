import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paw_and_love/Config/assets_path.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Config/font_config.dart';
import 'package:paw_and_love/Utils/const.dart';
import 'package:paw_and_love/Utils/snackbar.dart';
import 'package:paw_and_love/Utils/utill.dart';
import 'package:paw_and_love/Widgets/custome_button.dart';
import 'package:paw_and_love/Widgets/custome_text_input_field.dart';
import 'package:paw_and_love/controller/seller/seller_profile_controller.dart';
import 'package:paw_and_love/screens/seller_and_breeders/view_profile.dart';
import 'package:sizer/sizer.dart';

class CreateSellerProfile extends StatelessWidget {
  const CreateSellerProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SellerProfileController _controller = Get.put(SellerProfileController());

    createNewSeller() async {
      _controller.isUploading.value = true;
      var result = await _controller.createSellerProfile();

      if (result != "success") {
        flutterToastMessage(
            title: "Error",
            message: result.toString(),
            position: SnackPosition.TOP,
            backgroundColor: ColorConfig.errorRed);
        _controller.isUploading.value = false;
      } else {
        flutterToastMessage(
            title: "Success",
            message: "Profile is created",
            position: SnackPosition.TOP,
            backgroundColor: ColorConfig.successGreen);
        Get.off(() => const ViewSellerProfile());
        _controller.isUploading.value = false;
      }
    }

    void selectImage() async {
      var list = await pickImage(ImageSource.gallery);
      if (list != null) {
        _controller.profileImage.value = list[1].toString();
        _controller.profileImageByte = list[0];
      }
    }

    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                elevation: 0,
                expandedHeight: 50.h,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: const Text(
                    "Create your Profile",
                  ),
                  background: Obx(() => Stack(
                        alignment: Alignment.center,
                        fit: StackFit.expand,
                        children: [
                          _controller.profileImage.isEmpty
                              ? Image.asset(
                                  sellerProfile,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(_controller.profileImage.value),
                                  fit: BoxFit.cover,
                                ),
                          Positioned(
                            bottom: 10,
                            left: 80.w,
                            child: InkWell(
                              onTap: () {
                                selectImage();
                              },
                              child: const Icon(
                                CupertinoIcons.camera_circle,
                                color: Colors.white60,
                                size: 50,
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ),
              Obx(() => SliverList(
                      delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 10),
                      child: CustomeTextInputField(
                          isReadOnly: false,
                          textEditingController: _controller.nameController,
                          isPass: false,
                          hintText: "Your Name",
                          lableText: "Please Enter Your Name",
                          textInputType: TextInputType.text,
                          textColor: ColorConfig.orange),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 10),
                      child: CustomeTextInputField(
                          isReadOnly: false,
                          textEditingController:
                              _controller.phoneNumberController,
                          isPass: false,
                          hintText: "Phone Number",
                          lableText: "Please Enter Phone Number",
                          textInputType: TextInputType.number,
                          textColor: ColorConfig.orange),
                    ),
                    //city
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: SizedBox(
                        height: 8.h,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: Colors.white,
                            textTheme: const TextTheme(
                                subtitle1:
                                    TextStyle(color: ColorConfig.orange)),
                            iconTheme: const IconThemeData(
                              color: ColorConfig.orange,
                            ),
                          ),
                          child: DropdownSearch(
                            popupBarrierColor: Colors.transparent,
                            dropdownSearchBaseStyle: TextStyle(
                                color: ColorConfig.orange, fontSize: 13.sp),
                            onChanged: (value) =>
                                _controller.city = value.toString(),
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Please Select The City",
                              labelStyle: TextStyle(
                                  color: ColorConfig.orange,
                                  fontSize: 13.sp,
                                  fontFamily: REGULAR_FONT),
                              hintText: "City",
                              hintStyle: TextStyle(
                                  color: ColorConfig.orange,
                                  fontSize: 13.sp,
                                  fontFamily: REGULAR_FONT),
                              fillColor: ColorConfig.orange,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                  color: ColorConfig.orange,
                                ),
                              ),
                              filled: false,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                  color: ColorConfig.orange,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            showSearchBox: true,
                            mode: Mode.BOTTOM_SHEET,
                            showSelectedItems: true,
                            items: cites,
                          ),
                        ),
                      ),
                    ),
                    //About
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 10),
                      child: CustomeTextInputField(
                          isReadOnly: false,
                          textEditingController: _controller.aboutController,
                          isPass: false,
                          hintText: "About you",
                          lableText: "Please Enter About You",
                          textInputType: TextInputType.number,
                          textColor: ColorConfig.orange),
                    ),

                    // Obx(() => RadioGroup<String>.builder(
                    //       horizontalAlignment: MainAxisAlignment.spaceEvenly,
                    //       direction: Axis.horizontal,
                    //       textStyle: const TextStyle(
                    //         color: ColorConfig.orange,
                    //       ),
                    //       activeColor: ColorConfig.darkBlue,
                    //       groupValue: _controller.selectedType.value,
                    //       onChanged: (value) =>
                    //           _controller.selectedType.value = value.toString(),
                    //       items: _controller.sellerTypes,
                    //       itemBuilder: (item) => RadioButtonBuilder(
                    //         item,
                    //       ),
                    //     )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: CustomeButton(
                        getxController: _controller,
                        buttonText: "Create Profile",
                        callbackFunction: _controller.isUploading.value
                            ? null
                            : createNewSeller,
                        backgroundColor: ColorConfig.orange,
                      ),
                    )
                  ])))
            ];
          },
          body: Container(
              // color: CupertinoColors.lightBackgroundGray,
              )),
    );
  }
}
