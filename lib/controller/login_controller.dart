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

    //Validate the user inputs
    if (!GetUtils.isEmail(_email)) {
      return "Email address is invalid or Empty";
    } else if (_password == "") {
      return "Empty password or Password length should be more than 6 characters";
    }
    try {
      //log in with firebase auth
      UserCredential _cred = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);

      debugPrint(_cred.user!.uid);
      emailController.clear();
      passwordController.clear();
      return "success";

      //handle the exception
    } on FirebaseAuthException catch (err) {
      return err.message.toString();
    } catch (e) {
      debugPrint(e.toString());
      return "Something went to wrong";
    }
  }
}
