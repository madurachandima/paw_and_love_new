import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paw_and_love/Widgets/customeCircularProgress.dart';
import 'package:paw_and_love/screens/bottom_navigationbar_handler.dart';

class MiddleScreen extends StatefulWidget {
  const MiddleScreen({Key? key}) : super(key: key);

  @override
  State<MiddleScreen> createState() => _MiddleScreenState();
}

class _MiddleScreenState extends State<MiddleScreen> {
  late String? userRole = "";
  @override
  void initState() {
    () async {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      userRole = snap.get('role');
      setState(() {});
    }();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (userRole != "") {
      return BottomNavigationbarHandler(userRole: userRole);
    }
    return CustomeCircularProgress();
  }
}
