import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Services/storage_methods.dart';
import 'package:paw_and_love/Utils/const.dart';
import 'package:paw_and_love/model/seller/seller_profile_model.dart';

class SellerProfileMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createSellerProfile(
      {required String? name,
      required String? phoneNumber,
      required String? city,
      required String? about,
      required String? sellerType,
      required Uint8List? profileImageByte}) async {
    if (name == "") {
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
    if (about == "") {
      return "About you field is empty";
    }
    if (profileImageByte == null || profileImageByte.isEmpty) {
      return "Please upload a  profile image";
    }

    try {
      String profileUrl = await StorageMethods()
          .uploadImageToStorage("seller_profile_images", profileImageByte);

      SellerProfileModel sellerProfileModel = SellerProfileModel(
          name: name,
          phoneNumber: phoneNumber,
          aboutSeller: about,
          sellerProfileUrl: profileUrl,
          city: city,
          sellerType: sellerType);
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("seller_profile")
          .doc()
          .set(sellerProfileModel.toJson());
    } on FirebaseException catch (err) {
      return err.message.toString();
    } catch (e) {
      return ERROR_MESSAGE;
    }
    return "success";
  }
}
