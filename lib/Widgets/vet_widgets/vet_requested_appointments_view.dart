import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:intl/intl.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Utils/snackbar.dart';
import 'package:paw_and_love/controller/vet/vet_appointments_controller.dart';

class VetRequestedAppointmentsView extends StatelessWidget {
  final snap;
  final vetIndex;

  const VetRequestedAppointmentsView(
      {Key? key, required this.snap, required this.vetIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    VetAppointmentController _controller = Get.put(VetAppointmentController());

    _updateAppointmentStatus(appointmentId, vetApprovalStatus) async {
      String response = await _controller.updateAppointmentStatus(
          appointmentId: appointmentId, vetApprovalStatus: vetApprovalStatus);

      if (response != 'success') {
        flutterToastMessage(
            title: "Error",
            message: response.toString(),
            position: SnackPosition.TOP,
            backgroundColor: ColorConfig.errorRed);
      } else {
        flutterToastMessage(
            title: "Success",
            message: 'Appointment status updated!',
            position: SnackPosition.TOP,
            backgroundColor: ColorConfig.successGreen);
      }
    }

    return GestureDetector(
      onDoubleTap: () {
        _controller.vetApprovalStatus.removeAt(vetIndex);
        _controller.vetApprovalStatus.insert(vetIndex,!snap['is_approvied_by_vet']) ;
        _updateAppointmentStatus(snap.id,_controller.vetApprovalStatus.elementAt(
            vetIndex));
      },
      child: Card(
        color: _controller.vetApprovalStatus.elementAt(vetIndex)
            ? ColorConfig.successGreen
            : ColorConfig.errorRed,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        snap['clinic_name'].toString().toUpperCase(),
                        style:
                            const TextStyle(color: ColorConfig.textColorDark),
                      ),
                      Text(
                        DateFormat.yMMMd()
                            .format(snap['requested_date'].toDate())
                            .toString(),
                        style:
                            const TextStyle(color: ColorConfig.textColorDark),
                      )
                    ],
                  ),
                  const Text("Double tap for  \nUpdate status",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: ColorConfig.textColorDark)),
                ],
              ),
              _controller.vetApprovalStatus.elementAt(vetIndex)
                  ? const Text("Approved",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorConfig.textColorDark))
                  : const Text("Waiting",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorConfig.textColorDark))
            ],
          ),
        ),
      ),
    );
  }
}
