import 'package:cloud_firestore/cloud_firestore.dart';

class VetClinicModel {
  final String? clinicName;
  final String? clinicLocation;
  final String? clinicAddress;
  final String? clinicDescription;
  final String? clinicOpenDaysEvery;
  final String? clinicOpenDaysExcept;
  final String? openTimeTo;
  final String? closeTime;
  final String? vetId;
  final List? searchQueryLocation;
  final List? searchQueryClinicName;

  VetClinicModel(
      {this.clinicName,
      this.clinicLocation,
      this.clinicDescription,
      this.clinicOpenDaysEvery,
      this.clinicOpenDaysExcept,
      this.openTimeTo,
      this.closeTime,
      this.clinicAddress,
      this.vetId,
      this.searchQueryLocation,
      this.searchQueryClinicName});

  Map<String, dynamic> toJson() => {
        'clinic_name': clinicName,
        'clinic_location': clinicLocation,
        'clinic_description': clinicDescription,
        'clinic_open_days_every': clinicOpenDaysEvery,
        'clinic_open_days_except': clinicOpenDaysExcept,
        'open_time_to': openTimeTo,
        'close_time_to': closeTime,
        'clinic_address': clinicAddress,
        'vet_id': vetId,
        'search_query_by_location': searchQueryLocation,
        'search_query_by_name': searchQueryClinicName,
      };

  static VetClinicModel fromSnap(DocumentSnapshot? snap) {
    var snapshot = snap!.data() as Map<String, dynamic>;

    return VetClinicModel(
        clinicName: snapshot['clinic_name'],
        clinicLocation: snapshot['clinic_location'],
        clinicDescription: snapshot['clinic_description'],
        clinicOpenDaysEvery: snapshot['clinic_open_days_every'],
        clinicOpenDaysExcept: snapshot['clinic_open_days_except'],
        openTimeTo: snapshot['open_time_to'],
        closeTime: snapshot['close_time_to'],
        clinicAddress: snapshot['clinic_address'],
        vetId: snapshot['vet_id'],
        searchQueryLocation: snapshot['search_query_by_location'],
        searchQueryClinicName: snapshot['search_query_by_name']);
  }
}
