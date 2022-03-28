import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Services/home_methods.dart';
import 'package:paw_and_love/model/vet/vaccination_date_model.dart';
import 'package:paw_and_love/model/vet/vaccination_model.dart';
import 'package:paw_and_love/model/vet/vet_profile_model.dart';

class HomeController extends GetxController {
  VaccinationModel vaccinationModel = VaccinationModel();
  var vetProfileModel = VetProfileModel().obs;
  List recommendedVaccines = [];
  List optionalVaccines = [];
  var userName = "".obs;
  var role = "".obs;
  var notificationList = [].obs;
  var isHaveCompletedProfile = false.obs;
  @override
  void onInit() {
    super.onInit();
    () async {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      role.value = snap.get("role");
      userName.value = snap.get("username");
      try {
        vetProfileModel.value = await HomeMethods().getVetProfile();
        if (vetProfileModel.value != null) {
          isHaveCompletedProfile.value = true;
        } else {
          isHaveCompletedProfile.value = false;
        }
      } catch (e) {
        isHaveCompletedProfile.value = false;
      }

      notificationList.value = await HomeMethods().getDogsVaccinationdetails();
      //print(notificationList);
    }();
  }

  getVaccinationByWeeks({required int weeksDiffrience}) {
    for (var i = 0; i < vaccinationModel.ageGroup!.length; i++) {
      var result = vaccinationModel.ageGroup![i].entries.first.key.split('-');

      if (weeksDiffrience >= int.parse(result[0]) &&
          weeksDiffrience <= int.parse(result[1])) {
        var values = vaccinationModel.ageGroup![i].entries.first.value;
        recommendedVaccines.clear();
        optionalVaccines.clear();
        for (var i = 0; i < values.last.optional!.length; i++) {
          Map<String, VaccinactionDateModel> optionalMap = HashMap();
          //optionalMap.entries.first.key
          optionalMap.assign(
              values.last.optional![i],
              VaccinactionDateModel(
                  vaccinatedDate: DateTime.now(), isVaccinated: false));
          optionalVaccines.add(optionalMap);
        }
        for (var i = 0; i < values.first.recommended!.length; i++) {
          Map<String, VaccinactionDateModel> recomendedMap = HashMap();
          recomendedMap.assign(
              values.first.recommended![i],
              VaccinactionDateModel(
                  vaccinatedDate: DateTime.now(), isVaccinated: false));
          recommendedVaccines.add(recomendedMap);
        }
      }
    }
    print(recommendedVaccines);
    print(optionalVaccines);
  }
}
