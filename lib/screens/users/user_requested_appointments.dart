import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Utils/utill.dart';
import 'package:paw_and_love/Widgets/customeCircularProgress.dart';
import 'package:paw_and_love/Widgets/custome_button.dart';
import 'package:paw_and_love/Widgets/user_widgets/user_requested_appointments_view.dart';
import 'package:paw_and_love/controller/users/appitment_controller.dart';

class UserRequestedAppointments extends StatelessWidget {
  const UserRequestedAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppointmentController _controller = Get.put(AppointmentController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: ColorConfig.white,),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("appointments")
                .where('user_id',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                    snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CustomeCircularProgress();
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    "No Appointment found!",
                    style: TextStyle(color: ColorConfig.orange),
                  ),
                );
              }

              // print(snapshot.data!.docs.first.id);
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return UserRequestedAppointmentsView(
                    snap: snapshot.data!.docs[index],
                  );
                },
              );
            }),
      ),
    );
  }
}
