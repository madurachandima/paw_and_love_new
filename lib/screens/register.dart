import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:paw_and_love/middle_screen.dart';
import 'package:paw_and_love/screens/login.dart';
import 'package:paw_and_love/controller/registration_controller.dart';
import 'package:paw_and_love/Config/color_config.dart';

import 'package:paw_and_love/Utils/snackbar.dart';
import 'package:paw_and_love/Widgets/custome_button.dart';
import 'package:paw_and_love/Widgets/custome_text_input_field.dart';
import 'package:sizer/sizer.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegistrationController _registrationController =
        Get.put(RegistrationController());
    void clickRegisterButton() async {
      _registrationController.isUploading.value = true;
      String response = await _registrationController.userRegistration();
      if (response != "success") {
        flutterToastMessage(
            title: "Error",
            message: response,
            position: SnackPosition.TOP,
            backgroundColor: ColorConfig.errorRed);
        _registrationController.isUploading.value = false;
      } else {
        flutterToastMessage(
            title: "Success",
            message: "User registration success",
            position: SnackPosition.TOP,
            backgroundColor: ColorConfig.successGreen);
        _registrationController.isUploading.value = false;
        Get.off(() => const MiddleScreen());
      }
    }

    return Scaffold(
      backgroundColor: ColorConfig.royalBlue,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: RichText(
                  text: TextSpan(
                      text: "Welcome \nto ",
                      style: Theme.of(context).textTheme.headline1,
                      children: [
                    TextSpan(
                      text: "Paw & Love",
                      style: Theme.of(context).textTheme.headline2,
                    )
                  ])),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: CustomeTextInputField(
                  textEditingController:
                      _registrationController.usernameController,
                  isReadOnly: false,
                  isPass: false,
                  lableText: "Username",
                  hintText: " Please Input Username",
                  textInputType: TextInputType.text,
                  textColor: ColorConfig.lightGray),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: CustomeTextInputField(
                  textEditingController:
                      _registrationController.phoneController,
                  isPass: false,
                  isReadOnly: false,
                  lableText: "Phone Number ",
                  hintText: " Please Input Phone Number",
                  textInputType: TextInputType.phone,
                  textColor: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: CustomeTextInputField(
                  textEditingController:
                      _registrationController.emailController,
                  isPass: false,
                  isReadOnly: false,
                  lableText: "Email Address ",
                  hintText: " Please Input Email Address",
                  textInputType: TextInputType.emailAddress,
                  textColor: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: CustomeTextInputField(
                  textEditingController:
                      _registrationController.passwordController,
                  isReadOnly: false,
                  isPass: true,
                  lableText: "Password",
                  hintText: " Please Input Password",
                  textInputType: TextInputType.visiblePassword,
                  textColor: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: CustomeTextInputField(
                  textEditingController:
                      _registrationController.conPasswordController,
                  isReadOnly: false,
                  isPass: true,
                  lableText: "Confirm Password",
                  hintText: " Please Input Confirm Password",
                  textInputType: TextInputType.visiblePassword,
                  textColor: Colors.white),
            ),
            Obx(() => RadioGroup<String>.builder(
                  horizontalAlignment: MainAxisAlignment.spaceEvenly,
                  direction: Axis.horizontal,
                  textStyle: const TextStyle(
                    color: ColorConfig.lightGray,
                  ),
                  activeColor: ColorConfig.darkBlue,
                  groupValue: _registrationController.selectedRole.value,
                  onChanged: (value) => _registrationController
                      .selectedRole.value = value.toString(),
                  items: _registrationController.roletypes,
                  itemBuilder: (item) => RadioButtonBuilder(
                    item,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: CustomeButton(
                getxController: _registrationController,
                buttonText: "Sign Up",
                callbackFunction: clickRegisterButton,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                    child: Text(
                  "Already have a account ? ",
                  style: Theme.of(context).textTheme.bodyText1,
                )),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.off(() => const Login());
                  },
                  child: Text("Sign In",
                      style: Theme.of(context).textTheme.bodyText2),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      )),
    );
  }
}
