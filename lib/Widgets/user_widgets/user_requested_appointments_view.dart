import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:intl/intl.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Services/user_methods.dart';
import 'package:paw_and_love/Utils/snackbar.dart';

class UserRequestedAppointmentsView extends StatelessWidget {
  final snap;

  const UserRequestedAppointmentsView({Key? key, required this.snap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _deleteAppointmentRequest(appointmentId) async {
      String response = await UserMethods()
          .deleteRequestedAppointment(appointmentId: appointmentId);
      if (response != 'success') {
        flutterToastMessage(
            title: "Error",
            message: response.toString(),
            position: SnackPosition.TOP,
            backgroundColor: ColorConfig.errorRed);
      } else {
        flutterToastMessage(
            title: "Success",
            message: 'Appointment deleted!',
            position: SnackPosition.TOP,
            backgroundColor: ColorConfig.successGreen);
      }
    }

    print( snap['requested_date']);
    print( Timestamp.fromDate(DateTime.now()).seconds);

    return Dismissible(
      key: Key(snap.id),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          _deleteAppointmentRequest(snap.id);
        }
      },
      background: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(
              Icons.delete_outline_rounded,
              size: 50,
              color: ColorConfig.white,
            ),
            Icon(
              Icons.delete_outline_rounded,
              size: 50,
              color: ColorConfig.white,
            )
          ],
        ),
        color: ColorConfig.errorRed,
      ),
      child: Card(
        color: ColorConfig.successGreen,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                snap['clinic_name'].toString().toUpperCase(),
                style: const TextStyle(color: ColorConfig.textColorDark),
              ),
              const SizedBox(
                width: double.infinity,
                child: Text("Swipe for cancel",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: ColorConfig.textColorDark)),
              ),
              Text(
                DateFormat.yMMMd()
                    .format(snap['requested_date'].toDate())
                    .toString(),
                style: const TextStyle(color: ColorConfig.textColorDark),
              )
            ],
          ),
        ),
      ),
    );
  }
}
