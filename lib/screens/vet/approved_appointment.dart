
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paw_and_love/screens/vet/appointmens_tabs/vet_approved_appointments.dart';
import 'package:paw_and_love/screens/vet/appointmens_tabs/vet_completed_appointments.dart';
import 'package:sizer/sizer.dart';

class ApprovedAppointment extends StatelessWidget {
  const ApprovedAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom:  TabBar(
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(child: Text("Approved",style: TextStyle(fontSize: 15.sp),)),
                Tab(child: Text("Completed",style: TextStyle(fontSize: 15.sp))),
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
