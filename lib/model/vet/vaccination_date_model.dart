import 'package:intl/intl.dart';

class VaccinactionDateModel {
  DateTime? vaccinatedDate;
  bool? isVaccinated;

  VaccinactionDateModel(
      {required this.vaccinatedDate, required this.isVaccinated});

  Map<String, dynamic> toJson() => {
        'dateTime': vaccinatedDate,
        'isVaccinated': isVaccinated,
      };

  static VaccinactionDateModel fromMap(Map? map) {
    // var snapshot = snap!.data() as Map<String, dynamic>;

    return VaccinactionDateModel(
      isVaccinated: map!['isVaccinated'],
      vaccinatedDate: DateTime.parse(DateFormat("yyyy-MM-dd")
          .format(DateTime.parse(map['dateTime'].toDate().toString()))),
    );
  }
}
