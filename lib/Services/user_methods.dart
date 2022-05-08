import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paw_and_love/Utils/const.dart';
import 'package:paw_and_love/model/user/appoitment_model.dart';
import 'package:paw_and_love/model/vet/vet_clinic_model.dart';

class UserMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // request appointment
  Future<String> requestAppointment(
      {required snap,
      required bool isApprovedByVet,
      required VetClinicModel clinicModel,
      required String clinicId,
      required var appointmentDate}) async {
    try {
      await _firestore.collection('appointments').doc().set(AppointmentModel(
              isApprovedByVet: isApprovedByVet,
              phoneNumber: snap.get('phone_number'),
              userName: snap.get('username'),
              uid: snap.get('uid'),
              vetId: clinicModel.vetId,
              clinicId: clinicId,
              clinicName: clinicModel.clinicName,
              clinicLocation: clinicModel.clinicLocation,
              requestedDate: appointmentDate)
          .toJson());
    } on FirebaseException catch (e) {
      return e.message.toString();
    } catch (e) {
      return ERROR_MESSAGE;
    }
    return "success";
  }

  // delete requested appointment
  Future<String> deleteRequestedAppointment(
      {required String? appointmentId}) async {
    try {
     await  _firestore.collection('appointments').doc(appointmentId).delete();
    } on FirebaseException catch (e) {
      return e.message.toString();
    } catch (err) {
      return ERROR_MESSAGE;
    }
    return "success";
  }
}
