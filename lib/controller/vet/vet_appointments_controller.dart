import 'package:get/get.dart';
import 'package:paw_and_love/Services/vet_appoinment_methods.dart';

class VetAppointmentController extends GetxController {
  var vetApprovalStatus = [].obs;
  var vetCompleteStatus = [].obs;
  var currentTimeStamp = 0.obs;
  var date = DateTime.now().obs;

  updateAppointmentStatus(
      {required String appointmentId, required bool vetApprovalStatus}) async {
    return await VetAppointmentMethods().updateAppointmentStatus(
        appointmentStatus: vetApprovalStatus, appointmentId: appointmentId);
  }

  updateAppointmentCompleteStatus(
      {required String appointmentId, required bool vetCompleteStatus}) async {
    return await VetAppointmentMethods().updateAppointmentCompleteStatus(
        appointmentCompleteStatus: vetCompleteStatus,
        appointmentId: appointmentId);
  }
}
