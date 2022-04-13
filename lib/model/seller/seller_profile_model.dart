import 'package:cloud_firestore/cloud_firestore.dart';

class SellerProfileModel {
  final String? name;
  final String? phoneNumber;
  final String? city;
  final String? aboutSeller;
  final String? sellerProfileUrl;
  final String? sellerType;

  SellerProfileModel(
      {this.name,
      this.phoneNumber,
      this.city,
      this.aboutSeller,
      this.sellerProfileUrl,
      this.sellerType});

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone_number': phoneNumber,
        'city': city,
        'about': aboutSeller,
        'profile_url': sellerProfileUrl,
        'type': sellerType
      };

  static SellerProfileModel fromSnap(DocumentSnapshot? snap) {
    var snapshot = snap!.data() as Map<String, dynamic>;

    return SellerProfileModel(
        name: snapshot['name'],
        phoneNumber: snapshot['phone_number'],
        city: snapshot['city'],
        aboutSeller: snapshot['about'],
        sellerProfileUrl: snapshot['profile_url'],
        sellerType: snapshot['type']);
  }
}
