import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Widgets/search_textfield.dart';
import 'package:paw_and_love/Widgets/vet_widgets/vet_view_card.dart';
import 'package:paw_and_love/controller/users/appitment_controller.dart';
import 'package:paw_and_love/model/vet/vet_clinic_model.dart';

class Veterinarian extends StatelessWidget {
  const Veterinarian({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppointmentController _controller = Get.put(AppointmentController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: ColorConfig.textColorDark),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
        child: Obx(() => Column(
              children: [
                SearchTextField(
                    textEditingController:
                        _controller.searchTextController.value,
                    hintText: "Search by Location",
                    lableText: "",
                    textInputType: TextInputType.text,
                    textColor: ColorConfig.yellow,
                    callbackFunction: () => {},
                    onTextChange: (value) => _controller.searchClinic(value)),
                const SizedBox(
                  height: 10,
                ),
                StreamBuilder(
                  stream: !_controller.isSearching.value
                      ? FirebaseFirestore.instance
                          .collection('Vet_clinic')
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection('Vet_clinic')
                          .where('search_query_by_location',
                              arrayContains: _controller.searchText.value)
                          .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return Text(
                        "No result found",
                        style: Theme.of(context).textTheme.bodyText2,
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) => VetViewCard(
                          vetClinicModel: VetClinicModel.fromSnap(
                              snapshot.data!.docs[index]),
                          clinicId: snapshot.data!.docs[index].id,

                        ),
                      ),
                    );
                  },
                )
              ],
            )),
      ),
    );
  }
}
