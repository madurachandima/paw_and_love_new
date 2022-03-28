import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Services/dog_profile_methods.dart';
import 'package:paw_and_love/Utils/snackbar.dart';
import 'package:paw_and_love/controller/users/dog_profile_view_controllr.dart';

import 'package:paw_and_love/screens/users/dog_profile_view.dart';
import 'package:sizer/sizer.dart';

class DogProfileCircularAvatar extends StatelessWidget with DogProfileMethod {
  // ignore: prefer_typing_uninitialized_variables
  final snap;
  final List notification;
  DogProfileCircularAvatar(
      {Key? key, required this.snap, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DogProfileViewController _dogProfileController =
        Get.put(DogProfileViewController());

    return InkWell(
      onTap: () {
        _dogProfileController.optionalVaccines.value = snap['optional_vaccine'];
        _dogProfileController.recomondedVaccines.value =
            snap['recomonded_vaccine'];
        Get.to(() => ViewDogProfile(
              snap: snap,
              notifications: notification,
            ));
      },
      onLongPress: () {
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete Dog Profile'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('Are you sure you want to delet this?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () async {
                    String response = await deleteDogProfile(id: snap.id);
                    if (response != "success") {
                      flutterToastMessage(
                          title: "Error",
                          message: response,
                          position: SnackPosition.TOP,
                          backgroundColor: ColorConfig.errorRed);
                    } else {
                      flutterToastMessage(
                          title: "Success",
                          message: "Succes fully deleted",
                          position: SnackPosition.TOP,
                          backgroundColor: ColorConfig.successGreen);
                    }
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          },
        );
      },
      child: Stack(
        children: [
          Container(
              padding: const EdgeInsets.all(8.0),
              height: 20.h,
              width: 25.w,
              child: CircleAvatar(
                backgroundImage:
                    CachedNetworkImageProvider(snap['dog_profile_url']),
              )),
          if (notification.isNotEmpty)
            Positioned(
              top: 40,
              right: 18,
              child: Container(
                width: 15,
                height: 15,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
              ),
            )
        ],
      ),
    );
  }
}
