import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Config/font_config.dart';
import 'package:paw_and_love/Utils/const.dart';
import 'package:paw_and_love/Utils/snackbar.dart';
import 'package:paw_and_love/Utils/styles.dart';
import 'package:paw_and_love/Widgets/custome_button.dart';
import 'package:paw_and_love/controller/dog_profile_controller.dart';
import 'package:paw_and_love/model/vaccination_date_model.dart';
import 'package:paw_and_love/screens/users/dog_profiles.dart';
import 'package:sizer/sizer.dart';
import 'package:paw_and_love/Utils/utill.dart';
import 'package:paw_and_love/Widgets/custome_text_input_field.dart';

class AddNewDogProfile extends StatelessWidget {
  const AddNewDogProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DogProfileController _profileController = Get.put(DogProfileController());

    createNewDogProfle() async {
      _profileController.isUploading.value = true;
      var result = await _profileController.saveNewDogprofile();

      if (result != "success") {
        flutterToastMessage(
            title: "Error",
            message: result.toString(),
            position: SnackPosition.TOP,
            backgroundColor: ColorConfig.errorRed);
        _profileController.isUploading.value = false;
      } else {
        flutterToastMessage(
            title: "Success",
            message: "Dog profile is created",
            position: SnackPosition.TOP,
            backgroundColor: ColorConfig.successGreen);
        Get.off(() => const DogProfile());
        _profileController.isUploading.value = false;
      }
    }

    void selectImage() async {
      var list = await pickImage(ImageSource.gallery);
      if (list != null) {
        _profileController.profileImage.value = list[1].toString();
        _profileController.profileImageByte = list[0];
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
                    "Add New Profile",
                  ),
                  background: Obx(() => Stack(
                        alignment: Alignment.center,
                        fit: StackFit.expand,
                        children: [
                          _profileController.profileImage.isEmpty
                              ? Image.network(
                                  "https://images.unsplash.com/photo-1552053831-71594a27632d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=362&q=80",
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(_profileController.profileImage.value),
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
                          textEditingController:
                              _profileController.dogNameController,
                          isPass: false,
                          hintText: "Dog Name",
                          lableText: "Please Enter Dog Name",
                          textInputType: TextInputType.text,
                          textColor: ColorConfig.orange),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 10),
                      child: CustomeTextInputField(
                          isReadOnly: false,
                          textEditingController:
                              _profileController.dogOwnerNameController,
                          isPass: false,
                          hintText: "Dog Owner Name",
                          lableText: "Please Enter Dog Owner Name",
                          textInputType: TextInputType.text,
                          textColor: ColorConfig.orange),
                    ),
                    //dog breed
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
                                _profileController.dogBreed = value.toString(),
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Please Select Dog Breed",
                              labelStyle: TextStyle(
                                  color: ColorConfig.orange,
                                  fontSize: 13.sp,
                                  fontFamily: REGULAR_FONT),
                              hintText: "Dog Breed",
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
                            items: dogBreeds,
                          ),
                        ),
                      ),
                    ),
                    //dog birthdate
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Obx(() => CustomeTextInputField(
                          callbackFunction: () async {
                            DateTime? selectedDate = await getDate(
                                context: context, initialDate: DateTime.now());

                            if (selectedDate!.isBefore(DateTime.now())) {
                              // ignore: unnecessary_null_comparison
                              if (selectedDate != null) {
                                _profileController.birthdate = selectedDate;
                                String date = selectedDate.year.toString() +
                                    "-" +
                                    selectedDate.month.toString() +
                                    "-" +
                                    selectedDate.day.toString();
                                _profileController
                                    .dogBirthDateController.value.text = date;

                                var a = daysBetween(
                                    DateTime(selectedDate.year,
                                        selectedDate.month, selectedDate.day),
                                    DateTime.now());

                                if (a > 0) {
                                  _profileController.birthdateByWeeks =
                                      getDaysByWeeks(a);
                                  if (_profileController.birthdateByWeeks! >
                                      0) {
                                    _profileController.getVaccinationByAge(
                                        age: _profileController
                                            .birthdateByWeeks!);
                                  }
                                } else {
                                  flutterToastMessage(
                                      title: "Error",
                                      message: "Invalid Birthdate",
                                      position: SnackPosition.TOP,
                                      backgroundColor: ColorConfig.errorRed);

                                  _profileController.clearBirthdates();
                                }
                              } else {
                                _profileController
                                    .dogBirthDateController.value.text = "";
                                flutterToastMessage(
                                    title: "Error",
                                    message: "Dog Birthdate can't be empty",
                                    position: SnackPosition.TOP,
                                    backgroundColor: ColorConfig.errorRed);

                                _profileController.clearBirthdates();
                              }
                            } else {
                              flutterToastMessage(
                                  title: "Error",
                                  message: "Invalid Birthdate",
                                  position: SnackPosition.TOP,
                                  backgroundColor: ColorConfig.errorRed);

                              _profileController.clearBirthdates();
                            }
                          },
                          isReadOnly: true,
                          textEditingController:
                              _profileController.dogBirthDateController.value,
                          isPass: false,
                          hintText: "Dog Birth Date",
                          lableText: "Please Select Dog Birth Date",
                          textInputType: TextInputType.text,
                          textColor: ColorConfig.orange)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: Text(
                              "Gender",
                              style: TextStyle(
                                  fontSize: 13.sp, color: ColorConfig.orange),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 40.w,
                                child: Obx(() => RadioListTile<DogGender>(
                                      activeColor: ColorConfig.orange,
                                      title: Text(
                                        'Male',
                                        style: TextStyle(
                                            color: ColorConfig.orange,
                                            fontSize: 13.sp),
                                      ),
                                      value: DogGender.male,
                                      groupValue:
                                          _profileController.gender.value,
                                      onChanged: (value) {
                                        _profileController.gender.value =
                                            value!;
                                      },
                                    )),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 40.w,
                                child: Obx(() => RadioListTile<DogGender>(
                                      activeColor: ColorConfig.orange,
                                      title: Text(
                                        'Female',
                                        style: TextStyle(
                                            color: ColorConfig.orange,
                                            fontSize: 13.sp),
                                      ),
                                      value: DogGender.female,
                                      groupValue:
                                          _profileController.gender.value,
                                      onChanged: (value) {
                                        _profileController.gender.value =
                                            value!;
                                      },
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    if (_profileController.recommendedVaccines.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Please select the vaccine gave to your Dog",
                              style: subHeadingStyle(),
                            ),
                            const Divider(
                              color: Colors.black26,
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text("Recomonded Vaccines",
                                  style: subTopicStyle()),
                            ),
                            Obx(() => ListView.builder(
                                itemCount: _profileController
                                    .recommendedVaccines.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, index) {
                                  return CheckboxListTile(
                                    activeColor: ColorConfig.orange,
                                    title: Text(_profileController
                                        .recommendedVaccines[index]
                                        .entries
                                        .first
                                        .key
                                        .toString()),
                                    value: _profileController
                                        .recommendedVaccines[index]
                                        .entries
                                        .first
                                        .value
                                        .isVaccinated,
                                    onChanged: (value) async {
                                      DateTime? dateTime = DateTime.now();
                                      if (value!) {
                                        dateTime = await getDate(
                                            context: context,
                                            initialDate: DateTime.now());
                                      }
                                      if (dateTime!.isAfter(DateTime.now())) {
                                        flutterToastMessage(
                                            title: "Error",
                                            message: "Invalid Vaccinated Date",
                                            position: SnackPosition.TOP,
                                            backgroundColor:
                                                ColorConfig.errorRed);
                                      } else {
                                        Map<String, dynamic> elementMap = {
                                          _profileController
                                                  .recommendedVaccines[index]
                                                  .entries
                                                  .first
                                                  .key:
                                              VaccinactionDateModel(
                                                  vaccinatedDate: dateTime,
                                                  isVaccinated: value)
                                        };
                                        _profileController.recommendedVaccines
                                            .removeAt(index);
                                        _profileController.recommendedVaccines
                                            .insert(index, elementMap);
                                      }
                                    },
                                  );
                                })),
                          ],
                        ),
                      ),
                    if (_profileController.optionalVaccines.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Optional Vaccines", style: subTopicStyle()),
                            Obx(() => ListView.builder(
                                itemCount:
                                    _profileController.optionalVaccines.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, index) {
                                  return CheckboxListTile(
                                    activeColor: ColorConfig.orange,
                                    title: Text(_profileController
                                        .optionalVaccines[index]
                                        .entries
                                        .first
                                        .key
                                        .toString()),
                                    value: _profileController
                                        .optionalVaccines[index]
                                        .entries
                                        .first
                                        .value
                                        .isVaccinated,
                                    onChanged: (value) async {
                                      DateTime? dateTime;
                                      if (value!) {
                                        dateTime = await getDate(
                                            context: context,
                                            initialDate: DateTime.now());
                                      }
                                      if (dateTime!.isAfter(DateTime.now())) {
                                        flutterToastMessage(
                                            title: "Error",
                                            message: "Invalid Vaccinated Date",
                                            position: SnackPosition.TOP,
                                            backgroundColor:
                                                ColorConfig.errorRed);
                                      } else {
                                        Map<String, dynamic> elementMap = {
                                          _profileController
                                                  .optionalVaccines[index]
                                                  .entries
                                                  .first
                                                  .key:
                                              VaccinactionDateModel(
                                                  vaccinatedDate: dateTime,
                                                  isVaccinated: value)
                                        };
                                        _profileController.optionalVaccines
                                            .removeAt(index);

                                        _profileController.optionalVaccines
                                            .insert(index, elementMap);
                                      }
                                    },
                                  );
                                })),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: CustomeButton(
                        getxController: _profileController,
                        buttonText: "Create Profile",
                        callbackFunction: _profileController.isUploading.value
                            ? null
                            : createNewDogProfle,
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
