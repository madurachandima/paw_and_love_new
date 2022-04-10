import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Config/assets_path.dart';

import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Utils/const.dart';
import 'package:paw_and_love/Utils/snackbar.dart';
import 'package:paw_and_love/Widgets/vet_widgets/vet_profile_circuler_avatar.dart';
import 'package:paw_and_love/controller/home_controller.dart';
import 'package:paw_and_love/screens/login.dart';
import 'package:paw_and_love/screens/vet/add_new_clinic.dart';

import 'package:sizer/sizer.dart';

import 'package:paw_and_love/Widgets/custome_text_input_field.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class ViewVetProfile extends StatelessWidget {
  const ViewVetProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController _homeController = Get.find();
    _signout() async {
      try {
        await FirebaseAuth.instance.signOut();
        Get.off(() => const Login());
      } on FirebaseException catch (err) {
        flutterToastMessage(
            title: "Error",
            message: err.message!,
            backgroundColor: ColorConfig.errorRed);
      } catch (e) {
        flutterToastMessage(
            title: "Error",
            message: ERROR_MESSAGE,
            backgroundColor: ColorConfig.errorRed);
      }
    }

    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                centerTitle: false,
                elevation: 0,
                expandedHeight: 40.h,
                floating: false,
                pinned: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        AwesomeDialog(
                                context: context,
                                animType: AnimType.BOTTOMSLIDE,
                                dialogType: DialogType.WARNING,
                                title: 'Log out',
                                desc: 'Are you sure you want to Log out?',
                                btnCancelOnPress: () {},
                                btnCancelText: "No",
                                btnOkOnPress: () => _signout(),
                                btnOkText: "Yes")
                            .show();
                      },
                      icon: const Icon(Icons.logout))
                ],
                flexibleSpace: FlexibleSpaceBar(
                    background: Obx(() => Stack(
                          alignment: Alignment.center,
                          fit: StackFit.expand,
                          children: [
                            _homeController.vetProfileModel.value.vetProfileUrl!
                                    .isEmpty
                                ? Image.asset(
                                    doctorProfile,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    _homeController
                                        .vetProfileModel.value.vetProfileUrl!,
                                    fit: BoxFit.cover,
                                  ),
                          ],
                        ))),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Text(
                    "Doctor Name",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 5, bottom: 10),
                      child: CustomeTextInputField(
                          isReadOnly: true,
                          textEditingController: TextEditingController(
                              text:
                                  "Dr ${_homeController.vetProfileModel.value.vetName}"),
                          isPass: false,
                          hintText: "Your Name",
                          lableText: "Please Enter Your Name",
                          textInputType: TextInputType.text,
                          textColor: ColorConfig.orange),
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Text(
                    "City",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: CustomeTextInputField(
                          isReadOnly: true,
                          textEditingController: TextEditingController(
                              text: _homeController.vetProfileModel.value.city),
                          isPass: false,
                          hintText: "Your Name",
                          lableText: "Please Enter Your Name",
                          textInputType: TextInputType.text,
                          textColor: ColorConfig.orange),
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Text(
                    "About",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: CustomeTextInputField(
                          isReadOnly: true,
                          textEditingController: TextEditingController(
                              text: _homeController
                                  .vetProfileModel.value.aboutVet),
                          isPass: false,
                          hintText: "Your Name",
                          lableText: "Please Enter Your Name",
                          textInputType: TextInputType.text,
                          textColor: ColorConfig.orange),
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Text(
                    "Add Clinic Places",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Vet_clinic')
                        .where('vet_id',
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Wrap(
                        children: [
                          Wrap(
                            children: snapshot.data!.docs
                                .map((snap) =>
                                    VetProfileCircularAvatar(snap: snap))
                                .toList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 20.h,
                              width: 25.w,
                              child: IconButton(
                                  onPressed: () {
                                    Get.to(() => const AddnewClinic());
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.add_circled,
                                    size: 100,
                                    color: ColorConfig.yellow,
                                  )),
                            ),
                          )
                        ],
                      );
                    }),
              ]))
            ];
          },
          body: Container(
              // color: CupertinoColors.lightBackgroundGray,
              )),
    );
  }
}
