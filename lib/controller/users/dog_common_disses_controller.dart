import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DogCommonDissesController extends GetxController {
  var chatTextController = TextEditingController().obs;
  List<MessageModel> chatMesseges = [];
  var searchQuery = "".obs;

  @override
  void dispose() {
    searchQuery.value = "";
    super.dispose();
  }
}

class MessageModel {
  String? message;
  bool? isSend;
  MessageModel(this.message, this.isSend);
}
