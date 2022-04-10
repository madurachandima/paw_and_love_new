
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paw_and_love/screens/vet/appointmens_tabs/vet_approved_appointments.dart';
import 'package:paw_and_love/screens/vet/appointmens_tabs/vet_completed_appointments.dart';

class ApprovedAppointment extends StatelessWidget {
  const ApprovedAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(child: Text("Approved")),
                Tab(child: Text("Completed")),
              ],
            ),
            // title: const Text('Tabs Demo'),
          ),
          body: const TabBarView(
            children: [
              ApprovedAppointments(),
              CompletedAppointments()

            ],
          ),
        ));

  }
}
