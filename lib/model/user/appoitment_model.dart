import 'package:cloud_firestore/cloud_firestore.dart';

class AppoitmentModel {
  final String? userName;
  final String? phoneNumber;
  final String? vetId;
  final String? uid;
  final bool? isApprovedByVet;

  AppoitmentModel(
      {this.userName,
      this.phoneNumber,
      this.isApprovedByVet,
      this.vetId,
      this.uid});

  Map<String, dynamic> toJson() => {
        'username': userName,
        'phone_number': phoneNumber,
        'is_approvied_by_vet': isApprovedByVet,
        'vet_id': vetId,
        'user_id': uid
      };

  static AppoitmentModel fromSnap(DocumentSnapshot? snap) {
    var snapshot = snap!.data() as Map<String, dynamic>;

    return AppoitmentModel(
        userName: snapshot['username'],
        phoneNumber: snapshot['phone_number'],
        isApprovedByVet: snapshot['is_approvied_by_vet'],
        vetId: snapshot['vet_id'],
        uid: snapshot['user_id']);
  }
}
