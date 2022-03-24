import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Widgets/search_textfield.dart';
import 'package:paw_and_love/Widgets/vet_view_card.dart';
import 'package:paw_and_love/model/vet_clinic_model.dart';
import 'package:paw_and_love/model/vet_profile_model.dart';

class Veterinarian extends StatelessWidget {
  const Veterinarian({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    _search() {}
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
        child: Column(
          children: [
            SearchTextField(
                prefixIcon: Icons.filter_alt_outlined,
                textEditingController: _controller,
                hintText: "Search by Name or Town",
                lableText: "",
                textInputType: TextInputType.text,
                textColor: ColorConfig.yellow,
                callbackFunction: () => _search,
                onTextChange: (value) => _search),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Vet_clinic')
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => VetViewCard(
                      vetClinicModel:
                          VetClinicModel.fromSnap(snapshot.data!.docs[index]),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
