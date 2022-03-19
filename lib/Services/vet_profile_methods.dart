import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Services/storage_methods.dart';
import 'package:paw_and_love/model/vet_profile_model.dart';

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
      return "Somthing went to wrong";
    }
    return "success";
  }

  addNewClinics(
      {required String? clinicName,
      required String clinicLocation,
      required String clinicAddress,
      required String clinicDescription,
      required String? openEvery,
      required String exceptEvery}) async {}
}
