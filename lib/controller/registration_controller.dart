import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

class RegistrationController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conPasswordController = TextEditingController();

  var roletypes = ["User", "Vet", "Seller"];
  var selectedRole = "".obs;
  var isUploading = false.obs;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    passwordController.dispose();
    conPasswordController.dispose();
    super.dispose();
  }

  Future userRegistration() async {
    String? _username = usernameController.text;
    String? _phoneNumber = phoneController.text;
    String? _email = emailController.text;
    String? _password = passwordController.text;
    String? _conPassword = conPasswordController.text;

    if (!GetUtils.isUsername(_username)) {
      return "Username is Empty";
    } else if (!GetUtils.isPhoneNumber(_phoneNumber)) {
      return "Phone number is invalid or Empyt";
    } else if (!GetUtils.isEmail(_email)) {
      return "Email address is invalid or Empyt";
    } else if (_password == "" || _password.length < 6) {
      return "Empty password or Password length should be more than 6 characters";
    } else if (_conPassword == "" || _conPassword.length < 6) {
      return "Empty confirm password or confirm password length should be more than 6 characters";
    } else if (_password != _conPassword) {
      return "Password dosn't matching";
    } else if (selectedRole.value == "") {
      return "Please select your role";
    }
    try {
      //register user
      UserCredential _cred = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);

      await _firestore.collection('users').doc(_cred.user!.uid).set({
        'uid': _cred.user!.uid,
        'username': _username,
        'phone_number': _phoneNumber,
        'email': _email,
        'role': selectedRole.value
      });
      return "success";
    } on FirebaseAuthException catch (err) {
      return err.message;
    } catch (e) {
      return "Somthing went to wrong";
    }
  }
}
