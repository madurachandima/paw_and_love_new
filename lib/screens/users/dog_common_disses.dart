import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Config/assets_path.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Widgets/chat_bot_view.dart';
import 'package:paw_and_love/Widgets/customeCircularProgress.dart';
import 'package:paw_and_love/Widgets/user_widgets/dog_symptoms_view_card.dart';
import 'package:paw_and_love/Widgets/search_textfield.dart';
import 'package:paw_and_love/controller/users/dog_common_disses_controller.dart';
import 'package:paw_and_love/model/user/dog_illness_model.dart';
import 'package:sizer/sizer.dart';

class DogCommonDisses extends StatelessWidget {
  const DogCommonDisses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DogCommonDissesController _dissesController =
        Get.put(DogCommonDissesController());
    TextEditingController _searchController = TextEditingController();

    _searchSymptoms() {
      debugPrint("search");
    }

    onTextChange(value) {
      _dissesController.searchQuery.value =
          value.toString().toUpperCase().trim();
      debugPrint(_dissesController.searchQuery.value);
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
          padding: const EdgeInsets.all(18.0),
          child: InkWell(
            onTap: () {
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return const ChatBotView();
                },
              );
            },
            child: SizedBox(
              child: Image.asset(
                chatbot,
                width: 21.w,
              ),
            ),
          )),
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SearchTextField(
                onTextChange: onTextChange,
                callbackFunction: _searchSymptoms,
                textEditingController: _searchController,
                hintText: "Search here",
                lableText: "Search here",
                textInputType: TextInputType.text,
                textColor: ColorConfig.orange,
              ),
            ),
            Obx(() => StreamBuilder(
                  stream: _dissesController.searchQuery.value.isNotEmpty
                      ? FirebaseFirestore.instance
                          .collection("illness")
                          .where('searchQuery',
                              arrayContains:
                                  _dissesController.searchQuery.value)
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection("illness")
                          .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? CustomeCircularProgress()
                        : Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return DogSymptomsViewCard(
                                    dogIllnessModel: DogIllnessModel.fromSnap(
                                        snapshot.data!.docs[index].data()),
                                  );
                                }),
                          );
                  },
                ))

            //DogSymptomsView()
          ],
        ),
      ),
    );
  }
}
