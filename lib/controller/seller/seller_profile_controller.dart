import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Services/seller_profile_methods.dart';

class SellerProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  String? city = "";
  Uint8List? profileImageByte;
  var profileImage = "".obs;
  var isUploading = false.obs;

  var sellerTypes = ["Breeder", "Item Seller"];
  var selectedType = "Item Seller".obs;

  createSellerProfile() async {
    return await SellerProfileMethods().createSellerProfile(
        about: aboutController.text,
        city: city,
        name: nameController.text,
        phoneNumber: phoneNumberController.text,
        sellerType: selectedType.value,
        profileImageByte: profileImageByte);
  }
}
