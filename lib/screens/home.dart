import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Config/assets_path.dart';
import 'package:paw_and_love/Utils/const.dart';

import 'package:paw_and_love/controller/home_controller.dart';
import 'package:paw_and_love/screens/users/item_sellers.dart';
import 'package:paw_and_love/screens/seller_and_breeders/create_profile.dart';
import 'package:paw_and_love/screens/seller_and_breeders/seller_dashboard.dart';
import 'package:paw_and_love/screens/seller_and_breeders/view_profile.dart';
import 'package:paw_and_love/screens/users/dog_common_disses.dart';
import 'package:paw_and_love/screens/users/dog_profiles.dart';
import 'package:paw_and_love/screens/vet/approved_appointment.dart';
import 'package:paw_and_love/screens/vet/vet_new_profile.dart';
import 'package:paw_and_love/screens/vet/vet_profile_view.dart';
import 'package:paw_and_love/screens/make_appointment.dart';

import 'package:sizer/sizer.dart';

class Home extends StatelessWidget {
  final String? role;

  const Home({Key? key, required this.role}) : super(key: key);

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
                  if (role == VET_ROLE)
                    Obx(() => cardWidget(
                        image: doctorProfile,
                        text: "Profile",
                        context: context,
                        pageName: _controller.isHaveCompletedProfile.value
                            ? const ViewVetProfile()
                            : const NewVetProfile())),
                  if (role == USER_ROLE)
                    cardWidget(
                        image: dogpPofile,
                        text: "Profile",
                        context: context,
                        pageName: const DogProfile()),
                  if (role == SELLER_ROLE)
                    Obx(() => cardWidget(
                        image: sellerProfile,
                        text: "Profile",
                        context: context,
                        pageName: _controller.isHaveCompletedProfile.value
                            ? const ViewSellerProfile()
                            : const CreateSellerProfile())),
                  const Spacer(),
                  cardWidget(
                      image: disease,
                      text: "Common Diseases",
                      context: context,
                      pageName: const DogCommonDisses())
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  role == SELLER_ROLE
                      ? cardWidget(
                          image: breeders,
                          text: "Dashboard",
                          context: context,
                          pageName: const Dashboard())
                      : cardWidget(
                          image: breeders,
                          text: "Item \nSellers",
                          context: context,
                          pageName: const ItemSellers()),
                  const Spacer(),
                  if (role != VET_ROLE)
                    cardWidget(
                        image: clinic,
                        text: "Make \nAppointment",
                        context: context,
                        pageName: const Veterinarian()),
                  if (role == VET_ROLE)
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
