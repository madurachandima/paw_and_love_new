import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String? userName;
  final String? phoneNumber;
  final String? vetId;
  final String? uid;
  final bool? isApprovedByVet;
  final bool? isCompletedByVet;
  final int? dateTime;
  final String? clinicName;
  final String? clinicLocation;
  final String? clinicId;
  final DateTime? requestedDate;
  final int? completedTimeStamp;
  final DateTime? completedDate;

  AppointmentModel({
    this.userName,
    this.phoneNumber,
    this.isApprovedByVet,
    this.isCompletedByVet,
    this.vetId,
    this.uid,
    this.dateTime,
    this.clinicName,
    this.clinicLocation,
    this.clinicId,
    this.requestedDate,
    this.completedDate,
    this.completedTimeStamp,
  });

  Map<String, dynamic> toJson() => {
        'username': userName,
        'phone_number': phoneNumber,
        'is_approvied_by_vet': isApprovedByVet,
        'is_completed_by_vet': false,
        'vet_id': vetId,
        'user_id': uid,
        'created_at': DateTime.now().millisecondsSinceEpoch,
        'clinic_name': clinicName,
        'clinic_location': clinicLocation,
        'clinic_id': clinicId,
        'requested_date': requestedDate,
        'completed_date': null,
        'completed_timestamp': null
      };

  static AppointmentModel fromSnap(DocumentSnapshot? snap) {
    var snapshot = snap!.data() as Map<String, dynamic>;

    return AppointmentModel(
      userName: snapshot['username'],
      phoneNumber: snapshot['phone_number'],
      isApprovedByVet: snapshot['is_approvied_by_vet'],
      vetId: snapshot['vet_id'],
      uid: snapshot['user_id'],
      dateTime: snapshot['created_at'],
      clinicName: snapshot['clinic_name'],
      clinicLocation: snapshot['clinic_location'],
      clinicId: snapshot['clinic_id'],
      requestedDate: snapshot['requested_date'],
    );
  }
}
