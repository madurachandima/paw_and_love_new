import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Services/vet_profile_methods.dart';
import 'package:paw_and_love/Utils/const.dart';

class VetProfileController extends GetxController {
  TextEditingController vetNameController = TextEditingController();
  TextEditingController vetPhoneNumberController = TextEditingController();
  TextEditingController aboutVetController=TextEditingController();

  TextEditingController clinicNameController = TextEditingController();
  TextEditingController clinicAddressController = TextEditingController();
  TextEditingController clinicDescriptionController = TextEditingController();
  TextEditingController clinicOpenTime = TextEditingController();

  String? city = "";
  String? clinicCity = "";
  Uint8List? profileImageByte;
  var profileImage = "".obs;
  var isUploading = false.obs;
  var openDays = "".obs;
  var closeDays = "".obs;
  var openTimeto = "".obs;
  var closeTimeto = "".obs;

  @override
  void onInit() {
    openDays.value = openDaysList[0];
    closeDays.value = closeDaysList[0];
    super.onInit();
  }

  saveVetProfile() async {
    return await VetProfileMethods().createNewVetprofile(
        vetName: vetNameController.text,
        phoneNumber: vetPhoneNumberController.text,
        city: city,
        aboutVet: aboutVetController.text,
        profileImageByte: profileImageByte);
  }

  addNewClinic() async {
    return await VetProfileMethods().addNewClinics(
        clinicAddress: clinicAddressController.text,
        clinicDescription: clinicDescriptionController.text,
        clinicLocation: clinicCity!,
        clinicName: clinicNameController.text,
        exceptEvery: closeDays.value,
        openEvery: openDays.value,
        openTime: openTimeto.value,
        closeTime: closeTimeto.value);
  }
}
