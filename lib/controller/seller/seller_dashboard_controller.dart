import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Services/seller_dashboard_methods.dart';
import 'package:paw_and_love/controller/home_controller.dart';

class SellerDashboardController extends GetxController {
  final HomeController _controller = Get.find();
  var itemNameController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;
  var shopAddressController = TextEditingController().obs;
  var contactNumberController = TextEditingController().obs;
  var priceController = TextEditingController().obs;
  var keywordsController = TextEditingController().obs;

  var city = "".obs;
  Uint8List? imageByte;
  var image = "".obs;
  var isUploading = false.obs;

  var sellerTypes = ["Available", "UnAvailable"];
  var selectedType = "Available".obs;

  var keywords = [].obs;

  createPost() async {
    String status = await SellerDashboardMethods().createPost(
        sellerName: _controller.userName.value,
        phoneNumber: contactNumberController.value.text,
        city: city.value,
        address: shopAddressController.value.text,
        itemName: itemNameController.value.text,
        description: descriptionController.value.text,
        isAvailable: selectedType.value == 'Available' ? true : false,
        itemImageByte: imageByte,
        price: priceController.value.text,
        keys: keywords.value);
    if (status == "success") {
      clearTextFields();
    }

    return status;
  }

  updatePost({required id, required imageUrl}) async {
    String status = await SellerDashboardMethods().updatePost(
        sellerName: _controller.userName.value,
        phoneNumber: contactNumberController.value.text,
        city: city.value,
        address: shopAddressController.value.text,
        itemName: itemNameController.value.text,
        description: descriptionController.value.text,
        isAvailable: selectedType.value == 'Available' ? true : false,
        itemImageByte: imageByte,
        imageUrl: imageUrl,
        price: priceController.value.text,
        id: id);
    if (status == "success") {
      clearTextFields();
    }
    return status;
  }

  setTextFieldValues(
      {required itemName,
      required description,
      required number,
      required address,
      required price,
      required type,
      required town}) {
    itemNameController.value.text = itemName.toString();
    descriptionController.value.text = description.toString();
    contactNumberController.value.text = number.toString();
    shopAddressController.value.text = address.toString();
    priceController.value.text = price.toString();
    selectedType.value = type ? "Available" : "UnAvailable";
    city.value = town;
  }

  clearTextFields() {
    itemNameController.value.clear();
    descriptionController.value.clear();
    contactNumberController.value.clear();
    shopAddressController.value.clear();
    priceController.value.clear();
    selectedType.value = 'Available';
    image.value = '';
    city.value = '';
    imageByte = null;
    keywords.clear();
  }
}
