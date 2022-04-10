import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paw_and_love/Utils/const.dart';

class VetAppointmentMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> updateAppointmentStatus(
      {required bool appointmentStatus, required String appointmentId}) async {
    try {
      await _firestore
          .collection('appointments')
          .doc(appointmentId)
          .update({'is_approvied_by_vet': appointmentStatus});
    } on FirebaseException catch (err) {
      // print(err.message);
      return err.message.toString();
    } catch (e) {
      return ERROR_MESSAGE;
    }
    return "success";
  }

  Future<String> updateAppointmentCompleteStatus(
      {required bool appointmentCompleteStatus,
      required String appointmentId}) async {
    try {
      await _firestore.collection('appointments').doc(appointmentId).update({
        'is_completed_by_vet': appointmentCompleteStatus,
        'completed_date': DateTime.now(),
        'completed_timestamp': DateTime.now().millisecondsSinceEpoch
      });
    } on FirebaseException catch (err) {
      // print(err.message);
      return err.message.toString();
    } catch (e) {
      return ERROR_MESSAGE;
    }
    return "success";
  }
}
