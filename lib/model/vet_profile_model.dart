import 'package:cloud_firestore/cloud_firestore.dart';

class VetProfileModel {
  final String? vetName;
  final String? phoneNumber;
  final String? city;
  final String? aboutVet;
  final String? vetProfileUrl;

  VetProfileModel({
    this.vetName,
    this.phoneNumber,
    this.aboutVet,
    this.vetProfileUrl,
    this.city,
  });

  Map<String, dynamic> toJson() => {
        'vet_name': vetName,
        'vet_phone_number': phoneNumber,
        'about_vet': aboutVet,
        'vet_profile_url': vetProfileUrl,
        'city': city,
      };

  static VetProfileModel fromSnap(DocumentSnapshot? snap) {
    var snapshot = snap!.data() as Map<String, dynamic>;

    return VetProfileModel(
      vetName: snapshot['vet_name'],
      phoneNumber: snapshot['vet_phone_number'],
      aboutVet: snapshot['about_vet'],
      vetProfileUrl: snapshot['vet_profile_url'],
      city: snapshot['city'],
    );
  }
}
