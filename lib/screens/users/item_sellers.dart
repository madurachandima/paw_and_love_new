import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Widgets/custome_button.dart';
import 'package:paw_and_love/Widgets/user_widgets/item_view_card.dart';
import 'package:paw_and_love/controller/users/item_buying_controller.dart';
import 'package:sizer/sizer.dart';

import '../../Widgets/customeCircularProgress.dart';
import '../../Widgets/search_textfield.dart';

class ItemSellers extends StatelessWidget {
  const ItemSellers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ItemBuyingController _controller = Get.put(ItemBuyingController());
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme:
          const IconThemeData(color: ColorConfig.textColorDark),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: SearchTextField(
                hintText: "Search by Name",
                lableText: "Search by Name",
                onTextChange: (value) {
                  _controller.searchQuery.value = value.toString();
                },
                textColor: ColorConfig.orange,
                textEditingController: TextEditingController(),
                textInputType: TextInputType.text,
                callbackFunction: () {},
              ),
            ),
            Obx(() => StreamBuilder(
                  stream: _controller.searchQuery.value.isNotEmpty
                      ? FirebaseFirestore.instance
                          .collection("posts")
                          .where('searchQueryItemName',
                             arrayContains : _controller.searchQuery.value
                                  .toString()
                                  .toUpperCase())
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection("posts")
                          .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? CustomeCircularProgress()
                        : Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return ItemViewCard(snap:snapshot.data!.docs[index]);
                                }),
                          );
                  },
                ))
          ],
        ));
  }
}
