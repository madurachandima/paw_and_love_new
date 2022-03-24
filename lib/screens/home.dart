import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Config/assets_path.dart';
import 'package:paw_and_love/Utils/const.dart';

import 'package:paw_and_love/controller/home_controller.dart';
import 'package:paw_and_love/screens/breeders_&_sellers.dart';
import 'package:paw_and_love/screens/users/dog_common_disses.dart';
import 'package:paw_and_love/screens/users/dog_profiles.dart';
import 'package:paw_and_love/screens/vet/vet_new_profile.dart';
import 'package:paw_and_love/screens/vet/vet_profile_view.dart';
import 'package:paw_and_love/screens/veterinarian.dart';

import 'package:sizer/sizer.dart';

class Home extends StatelessWidget {
  final String? userRole;
  const Home({Key? key, required this.userRole}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController _controller = Get.put(HomeController());
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Obx(() => RichText(
                      text: TextSpan(
                          text: "What are you looking for, ",
                          style: Theme.of(context).textTheme.headline3,
                          children: [
                        TextSpan(
                            text: _controller.userName.value,
                            style: Theme.of(context).textTheme.headline2),
                      ]))),
              Obx(() => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cardWidget(
                          image: userRole == VET_ROLE
                              ? doctorProfile
                              : userRole == SELLER_ROLE
                                  ? sellerProfile
                                  : dogpPofile,
                          text: "Profile",
                          context: context,
                          pageName: userRole == VET_ROLE
                              ? _controller.isHaveCompletedProfile.value
                                  ? const ViewVetProfile()
                                  : const NewVetProfile()
                              : const DogProfile()),
                      const Spacer(),
                      cardWidget(
                          image: disease,
                          text: "Common Disses",
                          context: context,
                          pageName: const DogCommonDisses())
                    ],
                  )),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  cardWidget(
                      image: breeders,
                      text: "Breeders & Selllers",
                      context: context,
                      pageName: const BreedersAndSellers()),
                  const Spacer(),
                  cardWidget(
                      image: clinic,
                      text: "Veterinarian",
                      context: context,
                      pageName: const Veterinarian())
                ],
              )
            ]),
      ),
    );
  }

  Widget cardWidget(
      {required String image,
      required String text,
      required BuildContext context,
      required Widget pageName}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Get.to(() => pageName);
        },
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              SizedBox(
                  width: 35.w,
                  height: 20.h,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Image.asset(image, fit: BoxFit.cover),
                  )),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
