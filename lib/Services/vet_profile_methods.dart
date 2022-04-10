import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Services/storage_methods.dart';
import 'package:paw_and_love/Utils/const.dart';
import 'package:paw_and_love/Utils/search_quary_builder.dart';
import 'package:paw_and_love/model/vet/vet_clinic_model.dart';
import 'package:paw_and_love/model/vet/vet_profile_model.dart';

class VetProfileMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> createNewVetprofile(
      {required String? vetName,
      required String? phoneNumber,
      required String? city,
      required String? aboutVet,
      required Uint8List? profileImageByte}) async {
    if (vetName == "") {
      return "Please Enter Your Name";
    }
    if (phoneNumber == "") {
      return "Please Enter your Phone Number";
    }
    if (!GetUtils.isPhoneNumber(phoneNumber!)) {
      return "Invalid phone number";
    }
    if (city == "") {
      return "please select the city";
    }
    if (aboutVet == "") {
      return "About you field is empty";
    }
    if (profileImageByte == null || profileImageByte.isEmpty) {
      return "Please upload a  profile image";
    }

    try {
      String vetProfileUrl = await StorageMethods()
          .uploadImageToStorage("vet_profile_images", profileImageByte);

      VetProfileModel vetprofileModel = VetProfileModel(
        vetName: vetName,
        phoneNumber: phoneNumber,
        aboutVet: aboutVet,
        vetProfileUrl: vetProfileUrl,
        city: city,
      );
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("vet_profile")
          .doc()
          .set(vetprofileModel.toJson());
    } on FirebaseException catch (err) {
      return err.message.toString();
    } catch (e) {
      return ERROR_MESSAGE;
    }
    return "success";
  }

  Future<String> addNewClinics(
      {required String? clinicName,
      required String clinicLocation,
      required String clinicAddress,
      required String clinicDescription,
      required String? openEvery,
      required String? exceptEvery,
      required String? openTime,
      required String? closeTime}) async {
    if (clinicName == "") {
      return "Please enter clinic name";
    }

    if (clinicLocation == "") {
      return "Please select the clinic location";
    }
    if (clinicAddress == "") {
      return "Please enter the address";
    }
    if (clinicDescription == "") {
      return "Please enter description";
    }
    if (openTime == "" || closeTime == "") {
      return "Select Open and Close times";
    }

    try {
      VetClinicModel _vetClinicModel = VetClinicModel(
          clinicName: clinicName,
          clinicLocation: clinicLocation,
          clinicAddress: clinicAddress,
          clinicDescription: clinicDescription,
          clinicOpenDaysEvery: openEvery,
          clinicOpenDaysExcept: exceptEvery,
          openTimeTo: openTime,
          closeTime: closeTime,
          vetId: FirebaseAuth.instance.currentUser!.uid,
          searchQueryLocation:
              SearchQuaryBuilder.searchQuaryBuilder(clinicLocation),
          searchQueryClinicName:
              SearchQuaryBuilder.searchQuaryBuilder(clinicName));

      await _firestore
          .collection('Vet_clinic')
          .doc()
          .set(_vetClinicModel.toJson());
    } on FirebaseException catch (err) {
      return err.message.toString();
    } catch (e) {
      return ERROR_MESSAGE;
    }

    return "success";
  }


}
