import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Utils/snackbar.dart';
import 'package:paw_and_love/Utils/styles.dart';
import 'package:paw_and_love/Utils/utill.dart';
import 'package:paw_and_love/Widgets/custome_button.dart';
import 'package:paw_and_love/Widgets/custome_text_input_field.dart';
import 'package:paw_and_love/controller/users/appitment_controller.dart';
import 'package:paw_and_love/model/vet/vet_clinic_model.dart';
import 'package:sizer/sizer.dart';

class AppointmentClinic extends StatelessWidget {
  final VetClinicModel clinicModel;
  const AppointmentClinic({Key? key, required this.clinicModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppoitmentController _controller = Get.put(AppoitmentController());
    _returnOpenTime() =>
        "Open ${returnFormatedDate(clinicModel.openTimeTo)} To ${returnFormatedDate(clinicModel.closeTime)} (24h Format) ";

    _makeAppitment() async {
      _controller.isUploading.value = true;
      String response = await _controller.requestAppoitment(clinicModel.vetId!);
      if (response != "success") {
        flutterToastMessage(
            title: "Error",
            message: response,
            position: SnackPosition.TOP,
            backgroundColor: ColorConfig.errorRed);
        _controller.isUploading.value = false;
      } else {
        flutterToastMessage(
            title: "Success",
            message: "User login success",
            position: SnackPosition.TOP,
            backgroundColor: ColorConfig.successGreen);
        _controller.isUploading.value = false;
        debugPrint("navigate to another screen");
        // Get.off(() => const MiddleScreen());
      }
    }

    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  centerTitle: false,
                  elevation: 0,
                  expandedHeight: 20.h,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      "Happy Pet Clinic",
                      style:
                          TextStyle(color: ColorConfig.white, fontSize: 20.sp),
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 10,
                    ),
                    child: Text(
                      "Clinic name",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 10),
                    child: CustomeTextInputField(
                        isReadOnly: true,
                        textEditingController:
                            TextEditingController(text: clinicModel.clinicName),
                        isPass: false,
                        hintText: "",
                        lableText: "",
                        textInputType: TextInputType.text,
                        textColor: ColorConfig.orange),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 10,
                    ),
                    child: Text(
                      "Locaton",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 10),
                    child: CustomeTextInputField(
                        isReadOnly: true,
                        textEditingController: TextEditingController(
                            text: clinicModel.clinicLocation),
                        isPass: false,
                        hintText: "",
                        lableText: "",
                        textInputType: TextInputType.text,
                        textColor: ColorConfig.orange),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 10,
                    ),
                    child: Text(
                      "Address",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 10),
                    child: CustomeTextInputField(
                        isReadOnly: true,
                        textEditingController: TextEditingController(
                            text: clinicModel.clinicAddress),
                        isPass: false,
                        hintText: "",
                        lableText: "",
                        textInputType: TextInputType.multiline,
                        isMultyLineText: true,
                        textColor: ColorConfig.orange),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 10,
                    ),
                    child: Text(
                      "About Clinic",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 10),
                    child: CustomeTextInputField(
                        isReadOnly: true,
                        textEditingController: TextEditingController(
                            text: clinicModel.clinicDescription),
                        isPass: false,
                        hintText: "",
                        lableText: "",
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
                        left: 20, right: 20, top: 20, bottom: 10),
                    child: CustomeTextInputField(
                        isReadOnly: true,
                        textEditingController: TextEditingController(
                            text: clinicModel.clinicOpenDaysEvery),
                        isPass: false,
                        hintText: "",
                        lableText: "",
                        textInputType: TextInputType.text,
                        textColor: ColorConfig.orange),
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
                        left: 20, right: 20, top: 20, bottom: 10),
                    child: CustomeTextInputField(
                        isReadOnly: true,
                        textEditingController: TextEditingController(
                            text: clinicModel.clinicOpenDaysExcept),
                        isPass: false,
                        hintText: "",
                        lableText: "",
                        textInputType: TextInputType.text,
                        textColor: ColorConfig.orange),
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
                        isReadOnly: true,
                        textEditingController:
                            TextEditingController(text: _returnOpenTime()),
                        isPass: false,
                        hintText: "",
                        lableText: "",
                        textInputType: TextInputType.text,
                        textColor: ColorConfig.orange),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                        child: CustomeButton(
                            backgroundColor: ColorConfig.orange,
                            buttonText: "Request Appointment",
                            getxController: _controller,
                            callbackFunction: () => _makeAppitment())),
                  )
                ]))
              ],
          body: Container()),
    );
  }
}
