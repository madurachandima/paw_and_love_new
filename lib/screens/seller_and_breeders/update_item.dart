import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';

import '../../Config/color_config.dart';
import '../../Utils/snackbar.dart';
import '../../Utils/utill.dart';
import '../../Widgets/customeCircularProgress.dart';
import '../../Widgets/custome_button.dart';
import '../../Widgets/custome_text_input_field.dart';
import '../../controller/seller/seller_dashboard_controller.dart';

class UpdateItem extends StatelessWidget {
  final snap;

  const UpdateItem({Key? key, this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SellerDashboardController _controller =
        Get.put(SellerDashboardController());

    _controller.setTextFieldValues(
        itemName: snap['item_name'],
        price: snap['price'],
        description: snap['description'],
        address: snap['address'],
        town: snap['city'],
        number: snap['phone_number'],
        type: snap['isAvailable']);

    _createNewItem() async {
      _controller.isUploading.value = true;
      var result = await _controller.updatePost(
          id: snap.id, imageUrl: snap['image_url']);

      if (result != "success") {
        flutterToastMessage(
            title: "Error",
            message: result.toString(),
            position: SnackPosition.TOP,
            backgroundColor: ColorConfig.errorRed);
        _controller.isUploading.value = false;
      } else {
        flutterToastMessage(
            title: "Success",
            message: "Post updated",
            position: SnackPosition.TOP,
            backgroundColor: ColorConfig.successGreen);
        _controller.isUploading.value = false;
        Get.back();
      }
    }

    void selectImage() async {
      var list = await pickImage(ImageSource.gallery);
      if (list != null) {
        _controller.image.value = list[1].toString();
        _controller.imageByte = list[0];
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Text(
                    "Item Name",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: CustomeTextInputField(
                      isReadOnly: false,
                      textEditingController:
                          _controller.itemNameController.value,
                      isPass: false,
                      hintText: "Item Name",
                      lableText: "",
                      textInputType: TextInputType.text,
                      textColor: ColorConfig.orange),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Text(
                    "Item Description",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: CustomeTextInputField(
                      isMultyLineText: true,
                      isReadOnly: false,
                      textEditingController:
                          _controller.descriptionController.value,
                      isPass: false,
                      hintText: "Description",
                      lableText: "",
                      textInputType: TextInputType.number,
                      textColor: ColorConfig.orange),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Text(
                    "City",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: CustomeTextInputField(
                      isReadOnly: true,
                      textEditingController:
                          TextEditingController(text: _controller.city.value),
                      isPass: false,
                      hintText: "Contact Number",
                      lableText: "",
                      textInputType: TextInputType.number,
                      textColor: ColorConfig.orange),
                ),
                //city
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   child: SizedBox(
                //     height: 8.h,
                //     child: Theme(
                //       data: Theme.of(context).copyWith(
                //         canvasColor: Colors.white,
                //         textTheme: const TextTheme(
                //             subtitle1: TextStyle(color: ColorConfig.orange)),
                //         iconTheme: const IconThemeData(
                //           color: ColorConfig.orange,
                //         ),
                //       ),
                //       child: DropdownSearch(
                //
                //         selectedItem:_controller.city.value,
                //         popupBarrierColor: Colors.transparent,
                //         dropdownSearchBaseStyle: TextStyle(
                //             color: ColorConfig.orange, fontSize: 13.sp),
                //         onChanged: (value) =>
                //             _controller.city.value = value.toString(),
                //         dropdownSearchDecoration: InputDecoration(
                //           labelText: "Please Select The City",
                //           labelStyle: TextStyle(
                //               color: ColorConfig.orange,
                //               fontSize: 13.sp,
                //               fontFamily: REGULAR_FONT),
                //           hintText: "City",
                //
                //           hintStyle: TextStyle(
                //               color: ColorConfig.orange,
                //               fontSize: 13.sp,
                //               fontFamily: REGULAR_FONT),
                //           fillColor: ColorConfig.orange,
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(20.0),
                //             borderSide: const BorderSide(
                //               color: ColorConfig.orange,
                //             ),
                //           ),
                //           filled: false,
                //           enabledBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(20.0),
                //             borderSide: const BorderSide(
                //               color: ColorConfig.orange,
                //               width: 2.0,
                //             ),
                //           ),
                //         ),
                //         showSearchBox: true,
                //         mode: Mode.BOTTOM_SHEET,
                //         showSelectedItems: true,
                //         items: cites,
                //
                //       ),
                //     ),
                //   ),
                // ),
                //About
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Text(
                    "Contact Number",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: CustomeTextInputField(
                      isReadOnly: false,
                      textEditingController:
                          _controller.contactNumberController.value,
                      isPass: false,
                      hintText: "Contact Number",
                      lableText: "",
                      textInputType: TextInputType.number,
                      textColor: ColorConfig.orange),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Text(
                    "Address",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: CustomeTextInputField(
                      isMultyLineText: true,
                      isReadOnly: false,
                      textEditingController:
                          _controller.shopAddressController.value,
                      isPass: false,
                      hintText: "Address",
                      lableText: "",
                      textInputType: TextInputType.number,
                      textColor: ColorConfig.orange),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Text(
                    "Item Price",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: CustomeTextInputField(
                      isReadOnly: false,
                      textEditingController: _controller.priceController.value,
                      isPass: false,
                      hintText: "Price",
                      lableText: "",
                      textInputType: TextInputType.number,
                      textColor: ColorConfig.orange),
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                  child: Text(
                    "Item Status",
                    textAlign: TextAlign.left,
                  ),
                ),
                Obx(() => RadioGroup<String>.builder(
                      horizontalAlignment: MainAxisAlignment.spaceEvenly,
                      direction: Axis.horizontal,
                      textStyle: const TextStyle(
                        color: ColorConfig.orange,
                      ),
                      activeColor: ColorConfig.darkBlue,
                      groupValue: _controller.selectedType.value,
                      onChanged: (value) =>
                          _controller.selectedType.value = value.toString(),
                      items: _controller.sellerTypes,
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,
                      ),
                    )),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 30, top: 20, bottom: 10),
                  child: Row(children: [
                    const Text("upload Images"),
                    const Spacer(),
                    Obx(() => InkWell(
                          onTap: () => selectImage(),
                          child: Container(
                              height: 40,
                              width: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent),
                                  color: ColorConfig.orange,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: _controller.isUploading.value
                                  ? SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CustomeCircularProgress(
                                        color: ColorConfig.white,
                                      ),
                                    )
                                  : const Icon(
                                      CupertinoIcons.cloud_upload,
                                      color: ColorConfig.white,
                                    )),
                        ))
                  ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: CustomeButton(
                    getxController: _controller,
                    buttonText: "Update Ads",
                    callbackFunction:
                        _controller.isUploading.value ? null : _createNewItem,
                    backgroundColor: ColorConfig.orange,
                  ),
                )
              ],
            )),
      ),
    );
  }
}
