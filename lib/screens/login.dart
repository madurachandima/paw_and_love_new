import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/controller/login_controller.dart';
import 'package:paw_and_love/middle_screen.dart';
import 'package:paw_and_love/screens/register.dart';
import 'package:paw_and_love/Config/color_config.dart';

import 'package:paw_and_love/Utils/snackbar.dart';
import 'package:paw_and_love/Widgets/custome_button.dart';
import 'package:paw_and_love/Widgets/custome_text_input_field.dart';
import 'package:sizer/sizer.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginControler _loginControler = Get.put(LoginControler());
    void clickRegisterButton() async {
      _loginControler.isUploading.value = true;
      String response = await _loginControler.userLogin();
      if (response != "success") {
        flutterToastMessage(
            title: "Error",
            message: response,
            position: SnackPosition.TOP,
            backgroundColor: ColorConfig.errorRed);
        _loginControler.isUploading.value = false;
      } else {
        _loginControler.isUploading.value = false;
        Get.off(() => const MiddleScreen());
      }
    }

    return Scaffold(
      backgroundColor: ColorConfig.royalBlue,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
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
                textEditingController: _loginControler.emailController,
                isReadOnly: false,
                isPass: false,
                lableText: "Email Address ",
                hintText: " Please Input Email Address",
                textInputType: TextInputType.emailAddress,
                textColor: ColorConfig.lightGray,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: CustomeTextInputField(
                  textEditingController: _loginControler.passwordController,
                  isReadOnly: false,
                  isPass: true,
                  lableText: "Password",
                  hintText: " Please Input Password",
                  textInputType: TextInputType.visiblePassword,
                  textColor: ColorConfig.lightGray),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: CustomeButton(
                getxController: _loginControler,
                buttonText: "Sign in",
                callbackFunction: clickRegisterButton,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                    child: Text(
                  "Don't have a account ? ",
                  style: Theme.of(context).textTheme.bodyText1,
                )),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.off(() => const Register());
                  },
                  child: Text("Sign up",
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
