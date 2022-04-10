import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Config/assets_path.dart';
import 'package:paw_and_love/Utils/const.dart';

import 'package:paw_and_love/controller/home_controller.dart';
import 'package:paw_and_love/screens/breeders_&_sellers.dart';
import 'package:paw_and_love/screens/users/dog_common_disses.dart';
import 'package:paw_and_love/screens/users/dog_profiles.dart';
import 'package:paw_and_love/screens/vet/approved_appointment.dart';
import 'package:paw_and_love/screens/vet/vet_new_profile.dart';
import 'package:paw_and_love/screens/vet/vet_profile_view.dart';
import 'package:paw_and_love/screens/make_appointment.dart';

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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (userRole == VET_ROLE)
                    Obx(() => cardWidget(
                        image: doctorProfile,
                        text: "Profile",
                        context: context,
                        pageName: _controller.isHaveCompletedProfile.value
                            ? const ViewVetProfile()
                            : const NewVetProfile())),
                  if (userRole != VET_ROLE)
                    cardWidget(
                        image: userRole == SELLER_ROLE
                            ? sellerProfile
                            : dogpPofile,
                        text: "Profile",
                        context: context,
                        pageName: const DogProfile()),
                  const Spacer(),
                  cardWidget(
                      image: disease,
                      text: "Common Disses",
                      context: context,
                      pageName: const DogCommonDisses())
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  cardWidget(
                      image: breeders,
                      text: "Breeders \n& Selllers",
                      context: context,
                      pageName: const BreedersAndSellers()),
                  const Spacer(),
                  if (userRole != VET_ROLE)
                  cardWidget(
                      image: clinic,
                      text: "Make \nAppointment",
                      context: context,
                      pageName: const Veterinarian()),

                  if (userRole == VET_ROLE)
                  cardWidget(
                      image: clinic,
                      text: "Approved \nAppointment",
                      context: context,
                      pageName: const ApprovedAppointment())
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
                    padding:
                        const EdgeInsets.only(left: 14.0, right: 14, top: 14),
                    child: Image.asset(image, fit: BoxFit.cover),
                  )),
              SizedBox(
                height: 1.h,
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
