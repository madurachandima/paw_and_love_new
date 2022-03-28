import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paw_and_love/Utils/const.dart';
import 'package:paw_and_love/model/user/appoitment_model.dart';

class UserMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> requestAppitment(
      {required snap,
      required bool isApprovedByVet,
      required String vetId}) async {
    try {
      await _firestore.collection('appoitments').doc().set(AppoitmentModel(
              isApprovedByVet: isApprovedByVet,
              phoneNumber: snap.get('phone_number'),
              userName: snap.get('phone_number'),
              uid: snap.get('uid'),
              vetId: vetId)
          .toJson());
    } on FirebaseException catch (e) {
      return e.message.toString();
    } catch (e) {
      return ERROR_MESSAGE;
    }
    return "success";
  }
}
