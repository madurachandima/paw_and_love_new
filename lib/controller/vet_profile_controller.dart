import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Services/vet_profile_methods.dart';

class VetProfileController extends GetxController {
  TextEditingController vetNameController = TextEditingController();
  TextEditingController vetPhoneNumberController = TextEditingController();

  TextEditingController clinicNameController = TextEditingController();
  TextEditingController clinicAddressController = TextEditingController();
  TextEditingController clinicDescriptionController = TextEditingController();

  String? city = "";
  String? clinicCity = "";
  Uint8List? profileImageByte;
  var profileImage = "".obs;
  var isUploading = false.obs;
  var openDays = "".obs;
  var closeDays = "".obs;

  saveVetProfile() {
    return "";
  }

  addNewClinic() async {
    return await VetProfileMethods().addNewClinics(
        clinicAddress: clinicAddressController.text,
        clinicDescription: clinicDescriptionController.text,
        clinicLocation: clinicCity!,
        clinicName: clinicNameController.text,
        exceptEvery: closeDays.value,
        openEvery: openDays.value);
  }
}
