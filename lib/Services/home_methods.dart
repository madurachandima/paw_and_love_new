import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paw_and_love/Utils/utill.dart';
import 'package:paw_and_love/model/seller/seller_profile_model.dart';
import 'package:paw_and_love/model/user/dog_profile_model.dart';
import 'package:paw_and_love/model/vet/vaccination_date_model.dart';
import 'package:paw_and_love/model/vet/vaccination_model.dart';
import 'package:intl/intl.dart';
import 'package:paw_and_love/model/vet/vet_profile_model.dart';

class HomeMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DogProfileModel? _dogprofilemodel;
  VaccinactionDateModel? _vaccinactionDateModel;
  List? _recomondedVaccines = [];
  List? _optionalVaccines = [];
  final List? _pendingVaccines = [];

  Future getDogsVaccinationdetails() async {
    var response =
        await readjsonFile(path: "assets/json/anual_vaccination.json");
    VaccinationModel vaccinationModel = vaccinationModelFromJson(response);

    QuerySnapshot<Map<String, dynamic>> snap = await _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("dog_profiles")
        .get();

    for (var item in snap.docs) {
      _dogprofilemodel = DogProfileModel.fromSnap(item);
      _recomondedVaccines = _dogprofilemodel!.recommendedVaccines;
      _optionalVaccines = _dogprofilemodel!.optionalVaccines;
      _returnPendingVaccinationDetails(
          vaccinationModel: vaccinationModel,
          recomondedVaccines: _recomondedVaccines,
          optionalVaccines: _optionalVaccines,
          id: item.id);
    }
    return _pendingVaccines;
  }

  _returnPendingVaccinationDetails(
      {required VaccinationModel? vaccinationModel,
      required List? recomondedVaccines,
      required List? optionalVaccines,
      required String? id}) async {
    List? recomonded = _checkVaccinationDetails(
        vaccinationArray: recomondedVaccines,
        vaccinationModel: vaccinationModel,
        key: 0,
        id: id);

    if (recomonded!.isNotEmpty) {
      _pendingVaccines!.add(recomonded);
    }
    List? optional = _checkVaccinationDetails(
        vaccinationArray: optionalVaccines,
        vaccinationModel: vaccinationModel,
        key: 1,
        id: id);

    if (optional!.isNotEmpty) {
      _pendingVaccines!.add(optional);
    }
  }

  _checkVaccinationDetails(
      {required List? vaccinationArray,
      required VaccinationModel? vaccinationModel,
      required int? key,
      required String? id}) {
    List vaccines = [];

    for (Map vaccinationItem in vaccinationArray!) {
      _vaccinactionDateModel =
          VaccinactionDateModel.fromMap(vaccinationItem.entries.first.value);

      if (_vaccinactionDateModel!.isVaccinated!) {
        for (var item in vaccinationModel!.ageGroup!) {
          List weekDiffrience = item.entries.first.key.split('-');
          int weekCount = getDaysByWeeks(daysBetween(
              DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.parse(
                  _vaccinactionDateModel!.vaccinatedDate!.toString()))),
              DateTime.now()));

          bool isContaineSameValue = key == 0
              ? item.entries.first.value[key!].recommended!
                  .contains(vaccinationItem.entries.first.key)
              : item.entries.first.value[key!].optional!
                  .contains(vaccinationItem.entries.first.key);

          if (isContaineSameValue &&
              weekCount >= int.parse(weekDiffrience[0]) &&
              weekCount <= int.parse(weekDiffrience[1])) {
            // print("Please take ${vaccinationItem.entries.first.key}");
            vaccines.add({id: vaccinationItem.entries.first.key});
            // return {id, vaccinationItem.entries.first.key};
          }
        }
      }
    }
    return vaccines;
  }

  Future getVetProfile() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snap = await _firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("vet_profile")
          .get();

      VetProfileModel vetProfileModel = VetProfileModel.fromSnap(snap.docs[0]);
      return vetProfileModel;
    } catch (e) {
      return null;
    }
  }

  Future getSellerProfile() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snap = await _firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("seller_profile")
          .get();

      SellerProfileModel sellerProfileModel =
          SellerProfileModel.fromSnap(snap.docs[0]);
      return sellerProfileModel;
    } catch (e) {
      return null;
    }
  }
}
