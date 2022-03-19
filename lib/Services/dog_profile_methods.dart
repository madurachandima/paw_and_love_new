import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paw_and_love/Services/storage_methods.dart';
import 'package:paw_and_love/model/dog_profile_model.dart';

class DogProfileMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> saveNewDogprofile(
      {required String? dogName,
      required String? dogOwnerName,
      required DateTime? birthDate,
      required int? ageByWeek,
      required String? dogBreed,
      required Uint8List? profileImageByte,
      required String? gender,
      required List? recommendedVaccines,
      required List? optionalVaccines,
      required Function callback}) async {
    if (dogName == "") {
      return "Dog Name is Can't be Empty";
    } else if (dogOwnerName == "") {
      return "Dog Owner Name is Can't be Empty";
    } else if (dogBreed == "") {
      return "Dog Breed Can't be Empty";
    } else if (ageByWeek == 0) {
      return "Invalid birthdate";
    } else if (ageByWeek == null) {
      return "Dog birthdate can't be empty";
    } else if (profileImageByte == null) {
      return "Please upload a dog profilr image";
    }

    try {
      String dogProfileUrl = await StorageMethods()
          .uploadImageToStorage("dog_profile_images", profileImageByte);

      DogProfileModel dogProfileModel = DogProfileModel(
          dogName: dogName,
          dogOwnerName: dogOwnerName,
          dogBreed: dogBreed,
          dogProfileUrl: dogProfileUrl,
          birthDate: birthDate,
          dogGender: gender,
          recommendedVaccines: recommendedVaccines,
          optionalVaccines: optionalVaccines);

      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("dog_profiles")
          .doc()
          .set(dogProfileModel.toJson());
    } on FirebaseException catch (err) {
      // print(err.message);
      return err.message;
    } catch (e) {
      return "Somthing is wrong";
    }
    callback();
    return "success";
  }

  Future<String?> updateDogProfile(
      {required String? id,
      required List? optional,
      required List? recomonded}) async {
    try {
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("dog_profiles")
          .doc(id)
          .update(
              {'optional_vaccine': optional, 'recomonded_vaccine': recomonded});
    } on FirebaseException catch (err) {
      // print(err.message);
      return err.message;
    } catch (e) {
      return "Somthing is wrong";
    }
    return "success";
  }

  Future deleteDogProfile({required String id}) async {
    try {
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("dog_profiles")
          .doc(id)
          .delete();
    } on FirebaseException catch (err) {
      return err.message.toString();
    } catch (e) {
      return "Somthing is wrong";
    }
    return "success";
  }
}
