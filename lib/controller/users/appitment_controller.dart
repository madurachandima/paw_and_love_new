import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Services/user_methods.dart';
import 'package:paw_and_love/model/user/appoitment_model.dart';

class AppoitmentController extends GetxController {
  var searchTextController = TextEditingController().obs;

  var isSearching = false.obs;
  var searchText = "".obs;
  var isUploading = false.obs;

  searchClinic(String searchQuery) {
    if (searchQuery.isNotEmpty) {
      isSearching.value = true;
      searchText.value = searchQuery.toUpperCase();
    } else {
      isSearching.value = false;
    }
  }

  requestAppoitment(String vetId) async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    return await UserMethods()
        .requestAppitment(snap: snap, isApprovedByVet: false, vetId: vetId);
  }
}
