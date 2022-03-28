import 'package:get/get.dart';
import 'package:paw_and_love/Services/dog_profile_methods.dart';
import 'package:paw_and_love/model/vet/vaccination_date_model.dart';

class DogProfileViewController extends GetxController with DogProfileMethod {
  var optionalVaccines = [].obs;
  var recomondedVaccines = [].obs;

  @override
  void dispose() {
    optionalVaccines.clear();
    recomondedVaccines.clear();
    super.dispose();
  }

  updateOptionalVaccineDate(
      {required DateTime? newDate,
      required String vaccineName,
      required String? id}) async {
    for (var i = 0; i < optionalVaccines.length; i++) {
      // print(optionalVaccines[i].entries.first.key==vaccineName);
      if (optionalVaccines[i].entries.first.key == vaccineName) {
        var map =
            VaccinactionDateModel(isVaccinated: true, vaccinatedDate: newDate)
                .toJson();

        var tempVaccineMap = {vaccineName: map};
        optionalVaccines.removeAt(i);
        optionalVaccines.insert(i, tempVaccineMap);
        String? response = await updateDogProfile(
            id: id, optional: optionalVaccines, recomonded: recomondedVaccines);
        print(response);
        print(optionalVaccines);
      }
    }
  }

  updateRecomondedVaccineDate(
      {required DateTime? newDate,
      required String vaccineName,
      required String? id}) async {
    for (var i = 0; i < recomondedVaccines.length; i++) {
      // print(optionalVaccines[i].entries.first.key==vaccineName);
      if (recomondedVaccines[i].entries.first.key == vaccineName) {
        var map =
            VaccinactionDateModel(isVaccinated: true, vaccinatedDate: newDate)
                .toJson();

        var tempVaccineMap = {vaccineName: map};
        recomondedVaccines.removeAt(i);
        recomondedVaccines.insert(i, tempVaccineMap);
        String? response = await updateDogProfile(
            id: id, optional: optionalVaccines, recomonded: recomondedVaccines);
        print(response);
      }
    }
  }
}
