import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:paw_and_love/Services/storage_methods.dart';
import 'package:paw_and_love/Utils/const.dart';
import 'package:paw_and_love/Utils/search_quary_builder.dart';
import 'package:paw_and_love/model/seller/seller_post_model.dart';

class SellerDashboardMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createPost(
      {required sellerName,
      required phoneNumber,
      required city,
      required address,
      required itemName,
      required description,
      required isAvailable,
      required itemImageByte,
      required price,
      required keys}) async {
    if (itemName == "") {
      return "Please Enter Item Name";
    }
    if (description == "") {
      return "Please Enter Description Name";
    }
    if (city == "") {
      return "Please select the city";
    }
    if (phoneNumber == "") {
      return "Please Enter your Phone Number";
    }
    if (!GetUtils.isPhoneNumber(phoneNumber!)) {
      return "Invalid phone number";
    }

    if (address == "") {
      return "Address field is empty";
    }
    if (price == "") {
      return "Price field is empty";
    }
    if (itemImageByte == null || itemImageByte.isEmpty) {
      return "Please upload a  item image";
    }

    try {
      String imageUrl =
          await StorageMethods().uploadImageToStorage("posts", itemImageByte);

      List keyList = [];
      keys.forEach((key) {
        print(key);
        keyList.addAll(SearchQuaryBuilder.searchQuaryBuilder(key));
      });

      print(keyList);
      SellerPostModel _postModel = SellerPostModel(
          phoneNumber: phoneNumber,
          city: city,
          address: address,
          description: description,
          imageUrl: imageUrl,
          isAvailable: isAvailable,
          itemName: itemName,
          sellerName: sellerName,
          uid: FirebaseAuth.instance.currentUser!.uid,
          price: price,
          searchQueryItemName: keyList);

      await _firestore.collection('posts').doc().set(_postModel.toJson());
    } on FirebaseException catch (err) {
      return err.message.toString();
    } catch (e) {
      print(e);
      return ERROR_MESSAGE;
    }
    return "success";
  }

  Future<String> updatePost(
      {required sellerName,
      required phoneNumber,
      required city,
      required address,
      required itemName,
      required description,
      required isAvailable,
      required itemImageByte,
      required price,
      required id,
      required imageUrl}) async {
    if (itemName == "") {
      return "Please Enter Item Name";
    }
    if (description == "") {
      return "Please Enter Description Name";
    }
    if (city == "") {
      return "Please select the city";
    }
    if (phoneNumber == "") {
      return "Please Enter your Phone Number";
    }
    if (!GetUtils.isPhoneNumber(phoneNumber!)) {
      return "Invalid phone number";
    }

    if (address == "") {
      return "Address field is empty";
    }
    if (price == "") {
      return "Price field is empty";
    }
    if (imageUrl == "") {
      if (itemImageByte == null || itemImageByte.isEmpty) {
        return "Please upload a  item image";
      }
    }

    try {
      if (itemImageByte != null) {
        //upload seller ads image to firebase storage
        imageUrl =
            await StorageMethods().uploadImageToStorage("posts", itemImageByte);
      }

      //create seller post model
      SellerPostModel _postModel = SellerPostModel(
          phoneNumber: phoneNumber,
          city: city,
          address: address,
          description: description,
          imageUrl: imageUrl,
          isAvailable: isAvailable,
          itemName: itemName,
          sellerName: sellerName,
          uid: FirebaseAuth.instance.currentUser!.uid,
          price: price,
          searchQueryItemName: SearchQuaryBuilder.searchQuaryBuilder(itemName));

      //save data in firestore
      await _firestore.collection('posts').doc(id).update(_postModel.toJson());

      //handle exceptions
    } on FirebaseException catch (err) {
      return err.message.toString();
    } catch (e) {

      return ERROR_MESSAGE;
    }
    return "success";
  }
}
