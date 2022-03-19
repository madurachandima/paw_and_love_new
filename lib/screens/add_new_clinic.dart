import 'package:get/get.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Config/font_config.dart';
import 'package:paw_and_love/Utils/const.dart';
import 'package:paw_and_love/Utils/styles.dart';
import 'package:paw_and_love/Widgets/custome_button.dart';
import 'package:paw_and_love/Widgets/custome_dropdown_list.dart';
import 'package:paw_and_love/Widgets/custome_text_input_field.dart';
import 'package:paw_and_love/controller/vet_profile_controller.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AddnewClinic extends StatelessWidget {
  const AddnewClinic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VetProfileController _controller = Get.put(VetProfileController());

    _createNewClinic() async {}
    _openTimePicker() async {
      TimeRange? result = await showTimeRangePicker(
        context: context,
      );
      print(result);
    }

    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                elevation: 0,
                expandedHeight: 5.h,
                floating: true,
                pinned: false,
                flexibleSpace: const FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    "Add New Clinic",
                  ),
                  // background:Container(),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: CustomeTextInputField(
                      isReadOnly: false,
                      textEditingController: _controller.clinicNameController,
                      isPass: false,
                      hintText: "Clinic Name",
                      lableText: "Please Enter Dog Name",
                      textInputType: TextInputType.text,
                      textColor: ColorConfig.orange),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SizedBox(
                    height: 8.5.h,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.white,
                        textTheme: TextTheme(
                            subtitle1: TextStyle(
                                color: ColorConfig.orange,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: REGULAR_FONT)),
                        iconTheme: const IconThemeData(
                          color: ColorConfig.orange,
                        ),
                      ),
                      child: DropdownSearch(
                        popupBarrierColor: Colors.transparent,
                        dropdownSearchBaseStyle: TextStyle(
                            color: ColorConfig.orange,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: REGULAR_FONT),
                        onChanged: (value) =>
                            _controller.clinicCity = value.toString(),
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Please Select Clinic Location",
                          labelStyle: TextStyle(
                              color: ColorConfig.orange,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: REGULAR_FONT),
                          hintText: "Clinic Location",
                          hintStyle: TextStyle(
                              color: ColorConfig.orange,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
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
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: CustomeTextInputField(
                      isReadOnly: false,
                      textEditingController:
                          _controller.clinicAddressController,
                      isPass: false,
                      hintText: "Clinic Address",
                      lableText: "Please Enter Clinic Address",
                      textInputType: TextInputType.multiline,
                      isMultyLineText: true,
                      textColor: ColorConfig.orange),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: CustomeTextInputField(
                      isReadOnly: false,
                      textEditingController:
                          _controller.clinicDescriptionController,
                      isPass: false,
                      hintText: "Clinic Description",
                      lableText: "Please Enter Clinic Description",
                      textInputType: TextInputType.multiline,
                      isMultyLineText: true,
                      textColor: ColorConfig.orange),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: Text(
                    "Open Days",
                    style: defaultTextStyleSubTopic(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                  ),
                  child: Text(
                    "Every",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 5, bottom: 10),
                  child: Obx(() => CustomeDropDownList(
                      onChanged: (value) {
                        _controller.openDays.value = value!;
                      },
                      dropdownValue: _controller.openDays.value == ""
                          ? openDays[0]
                          : _controller.openDays.value,
                      dropdownItems: openDays)),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                  ),
                  child: Text(
                    "Except",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 5, bottom: 10),
                  child: Obx(() => CustomeDropDownList(
                      onChanged: (value) {
                        _controller.closeDays.value = value!;
                      },
                      dropdownValue: _controller.closeDays.value == ""
                          ? closeDays[0]
                          : _controller.closeDays.value,
                      dropdownItems: closeDays)),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: Text(
                    "Open Time",
                    style: defaultTextStyleSubTopic(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: CustomeTextInputField(
                      callbackFunction: () => _openTimePicker(),
                      isReadOnly: true,
                      textEditingController: TextEditingController(),
                      isPass: false,
                      hintText: "Clinic Open Time ",
                      lableText: "Please Enter Clinic Description",
                      textInputType: TextInputType.multiline,
                      isMultyLineText: true,
                      textColor: ColorConfig.orange),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: CustomeButton(
                    getxController: _controller,
                    buttonText: "Add New Clinic",
                    callbackFunction: _controller.isUploading.value
                        ? null
                        : _createNewClinic(),
                    backgroundColor: ColorConfig.orange,
                  ),
                )
              ]))
            ];
          },
          body: Container(
              // color: CupertinoColors.lightBackgroundGray,
              )),
    );
  }
}
