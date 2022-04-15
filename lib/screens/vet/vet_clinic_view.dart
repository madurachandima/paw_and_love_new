import 'package:flutter/material.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Utils/styles.dart';
import 'package:paw_and_love/Utils/utill.dart';
import 'package:paw_and_love/Widgets/custome_text_input_field.dart';
import 'package:sizer/sizer.dart';

class ViewClinic extends StatelessWidget {
  final snap;

  const ViewClinic({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _returnOpenTime() =>
        "Open ${returnFormatedDate(snap['open_time_to'])} To ${returnFormatedDate(snap['close_time_to'])} (24h Format) ";

    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                elevation: 0,
                iconTheme:
                    const IconThemeData(color: ColorConfig.textColorDark),
                expandedHeight: 5.h,
                floating: true,
                pinned: false,
                flexibleSpace: const FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    " View Clinic",
                    style: TextStyle(color: ColorConfig.white),
                  ),
                  // background:Container(),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                  ),
                  child: Text(
                    "Clinic name",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: CustomeTextInputField(
                      isReadOnly: true,
                      textEditingController:
                          TextEditingController(text: snap['clinic_name']),
                      isPass: false,
                      hintText: "",
                      lableText: "Please Enter Dog Name",
                      textInputType: TextInputType.text,
                      textColor: ColorConfig.orange),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                  ),
                  child: Text(
                    "Locaton",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: CustomeTextInputField(
                      isReadOnly: true,
                      textEditingController:
                          TextEditingController(text: snap['clinic_location']),
                      isPass: false,
                      hintText: "",
                      lableText: "",
                      textInputType: TextInputType.text,
                      textColor: ColorConfig.orange),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
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
                      isReadOnly: true,
                      textEditingController:
                          TextEditingController(text: snap['clinic_address']),
                      isPass: false,
                      hintText: "",
                      lableText: "",
                      textInputType: TextInputType.multiline,
                      isMultyLineText: true,
                      textColor: ColorConfig.orange),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                  ),
                  child: Text(
                    "About Clinic",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: CustomeTextInputField(
                      isReadOnly: true,
                      textEditingController: TextEditingController(
                          text: snap['clinic_description']),
                      isPass: false,
                      hintText: "Clinic Description",
                      lableText: "Please Enter Clinic Description",
                      textInputType: TextInputType.multiline,
                      isMultyLineText: true,
                      textColor: ColorConfig.orange),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: Text(
                    "Open Days",
                    style: defaultTextStyleSubTopic(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                  ),
                  child: Text(
                    "Every",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: CustomeTextInputField(
                      isReadOnly: true,
                      textEditingController: TextEditingController(
                          text: snap['clinic_open_days_every']),
                      isPass: false,
                      hintText: "",
                      lableText: "",
                      textInputType: TextInputType.text,
                      textColor: ColorConfig.orange),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                  ),
                  child: Text(
                    "Except",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: CustomeTextInputField(
                      isReadOnly: true,
                      textEditingController: TextEditingController(
                          text: snap['clinic_open_days_except']),
                      isPass: false,
                      hintText: "",
                      lableText: "",
                      textInputType: TextInputType.text,
                      textColor: ColorConfig.orange),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: Text(
                    "Open Time",
                    style: defaultTextStyleSubTopic(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: CustomeTextInputField(
                      isReadOnly: true,
                      textEditingController:
                          TextEditingController(text: _returnOpenTime()),
                      isPass: false,
                      hintText: "",
                      lableText: "",
                      textInputType: TextInputType.text,
                      textColor: ColorConfig.orange),
                ),
              ]))
            ];
          },
          body: Container(
              // color: CupertinoColors.lightBackgroundGray,
              )),
    );
  }
}
