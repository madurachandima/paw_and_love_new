import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginControler extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isUploading = false.obs;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future userLogin() async {
    String? _email = emailController.text;
    String? _password = passwordController.text;

    if (!GetUtils.isEmail(_email)) {
      return "Email address is invalid or Empyt";
    } else if (_password == "") {
      return "Empty password or Password length should be more than 6 characters";
    }
    try {
      //register user
      UserCredential _cred = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);

      debugPrint(_cred.user!.uid);
      return "success";
    } catch (e) {
      debugPrint(e.toString());
      return "Somthing went to wrong";
    }
  }
}
