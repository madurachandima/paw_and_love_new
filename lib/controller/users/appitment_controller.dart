import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Services/user_methods.dart';
import 'package:paw_and_love/model/user/appoitment_model.dart';
import 'package:paw_and_love/model/vet/vet_clinic_model.dart';

class AppointmentController extends GetxController {
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

  requestAppointment(VetClinicModel clinicModel, String clinicId,appointmentDate) async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();


    List<DocumentSnapshot> documentList = (await FirebaseFirestore.instance
            .collection("appointments")
            .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where("clinic_id", isEqualTo: clinicId)
            .get())
        .docs;
    if (documentList.isNotEmpty) {
      return "you have already requested appointment";
    } else {
      return await UserMethods().requestAppointment(
        appointmentDate: appointmentDate,
          snap: snap,
          isApprovedByVet: false,
          clinicModel: clinicModel,
          clinicId: clinicId);
    }
  }
}
