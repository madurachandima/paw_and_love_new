import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Utils/utill.dart';
import 'package:paw_and_love/Widgets/customeCircularProgress.dart';
import 'package:paw_and_love/Widgets/vet_widgets/vet_requested_appointments_view.dart';
import 'package:paw_and_love/controller/vet/vet_appointments_controller.dart';

class AppointmentRequest extends StatelessWidget {
  const AppointmentRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VetAppointmentController _controller = Get.put(VetAppointmentController());

    return Scaffold(
      backgroundColor: ColorConfig.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: ColorConfig.textColorDark),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Obx(() => Row(
                  children: [
                    if (_controller.date.value != null)
                      Text(_controller.date.value.year.toString() +
                          " ." +
                          _controller.date.value.month.toString() +
                          " ." +
                          _controller.date.value.day.toString()),
                    const Spacer(),
                    InkWell(
                      child: const Icon(
                        CupertinoIcons.calendar_circle,
                        size: 40,
                      ),
                      onTap: () async {
                        DateTime? _currentDateTime = await getDate(
                            context: context, initialDate: DateTime.now());
                        _controller.date.value = _currentDateTime!;
                        if (_currentDateTime != null) {
                          _controller.currentTimeStamp.value =
                              _currentDateTime.millisecondsSinceEpoch;
                        }
                      },
                    ),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            Obx(() => StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("appointments")
                    .where('vet_id',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .where('is_approvied_by_vet', isEqualTo: false)
                    .where('is_completed_by_vet', isEqualTo: false)
                    .where('created_at',
                        isGreaterThanOrEqualTo:
                            _controller.currentTimeStamp.value == 0
                                ? 0000000000000
                                : _controller.currentTimeStamp.value)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CustomeCircularProgress();
                  }
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Appointment found!",
                        style: TextStyle(color: ColorConfig.orange),
                      ),
                    );
                  }

                  if (snapshot.data != null || snapshot.data!.docs.isNotEmpty) {
                    _controller.vetApprovalStatus.clear();
                    for (var i = 0; i < snapshot.data!.docs.length; i++) {
                      _controller.vetApprovalStatus.insert(
                          i, snapshot.data!.docs[i]['is_approvied_by_vet']);
                    }
                  }

                  print(snapshot.data!.docs.length);

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      print(index);
                      return VetRequestedAppointmentsView(
                        snap: snapshot.data!.docs[index],
                        vetIndex: index,
                      );
                    },
                  );
                })),
          ],
        ),
      ),
    );
  }
}
