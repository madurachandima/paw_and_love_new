import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Config/assets_path.dart';

import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Utils/const.dart';
import 'package:paw_and_love/Utils/snackbar.dart';
import 'package:paw_and_love/controller/home_controller.dart';
import 'package:paw_and_love/screens/login.dart';

import 'package:sizer/sizer.dart';

import 'package:paw_and_love/Widgets/custome_text_input_field.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class ViewSellerProfile extends StatelessWidget {
  const ViewSellerProfile({Key? key}) : super(key: key);

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
                iconTheme:
                    const IconThemeData(color: ColorConfig.textColorDark),
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
                            _homeController.sellerProfileModel.value
                                        .sellerProfileUrl ==
                                    null
                                ? Image.asset(
                                    sellerProfile,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    _homeController.sellerProfileModel.value
                                        .sellerProfileUrl!,
                                    fit: BoxFit.cover,
                                  ),
                          ],
                        ))),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                const Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
                  child: Text(
                    "Seller Name",
                    style: TextStyle(color: ColorConfig.orange),
                  ),
                ),
                Obx(() => Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                      child: Text(
                        _homeController.sellerProfileModel.value.name
                            .toString(),
                        style:
                            const TextStyle(color: ColorConfig.textColorDark),
                      ),
                    )),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
                  child: Text(
                    "City",
                    style: TextStyle(color: ColorConfig.orange),
                  ),
                ),
                Obx(() => Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                      child: Text(
                        _homeController.sellerProfileModel.value.city
                            .toString(),
                        style:
                            const TextStyle(color: ColorConfig.textColorDark),
                      ),
                    )),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
                  child: Text(
                    "About",
                    style: TextStyle(color: ColorConfig.orange),
                  ),
                ),
                Obx(() => Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                      child: Text(
                        _homeController.sellerProfileModel.value.aboutSeller
                            .toString(),
                        style:
                            const TextStyle(color: ColorConfig.textColorDark),
                      ),
                    )),
              ]))
            ];
          },
          body: Container(
              // color: CupertinoColors.lightBackgroundGray,
              )),
    );
  }
}
