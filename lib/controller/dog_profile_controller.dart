import 'dart:collection';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Services/dog_profile_methods.dart';
import 'package:paw_and_love/Utils/utill.dart';
import 'package:paw_and_love/model/vaccination_date_model.dart';
import 'package:paw_and_love/model/vaccination_model.dart';

enum DogGender { male, female }

class DogProfileController extends GetxController {
  TextEditingController dogNameController = TextEditingController();
  TextEditingController dogOwnerNameController = TextEditingController();
  VaccinationModel vaccinationModel = VaccinationModel();
  DateTime? birthdate;
  int? birthdateByWeeks;
  String? dogBreed = "";
  Uint8List? profileImageByte;

  var recommendedVaccines = [].obs;
  var optionalVaccines = [].obs;
  var profileImage = "".obs;
  var dogBirthDateController = TextEditingController().obs;
  var gender = DogGender.male.obs;
  var isUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    () async {
      try {
        var response = await readjsonFile(path: "assets/json/vaccination.json");
        vaccinationModel = vaccinationModelFromJson(response);
      } catch (e) {
        debugPrint(e.toString());
      }
    }();
  }

  getVaccinationByAge({required int age}) {
    for (var i = 0; i < vaccinationModel.ageGroup!.length; i++) {
      var result = vaccinationModel.ageGroup![i].entries.first.key.split('-');

      if (age >= int.parse(result[0]) && age <= int.parse(result[1])) {
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

  Future<String?> saveNewDogprofile() async {
    return await DogProfileMethod().saveNewDogprofile(
        dogName: dogNameController.text,
        dogOwnerName: dogOwnerNameController.text,
        birthDate: birthdate,
        ageByWeek: birthdateByWeeks,
        dogBreed: dogBreed,
        profileImageByte: profileImageByte,
        gender: gender.value.name,
        recommendedVaccines: recommendedVaccines,
        optionalVaccines: optionalVaccines,
        callback: clearTextFields);
  }

  clearBirthdates() {
    birthdateByWeeks = 0;
    recommendedVaccines.clear();
    optionalVaccines.clear();
  }

  clearTextFields() {
    dogNameController.clear();
    dogOwnerNameController.clear();
    dogBirthDateController.value.clear();
    dogBreed = "";
    gender.value = DogGender.male;
    recommendedVaccines.clear();
    optionalVaccines.clear();
  }
}
