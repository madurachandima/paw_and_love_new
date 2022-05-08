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
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                  child: Text(
                    snap['clinic_name'].toString(),
                    style: const TextStyle(color: ColorConfig.textColorDark),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                  ),
                  child: Text(
                    "Location",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                  child: Text(
                    snap['clinic_location'].toString(),
                    style: const TextStyle(color: ColorConfig.textColorDark),
                  ),
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
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                  child: Text(
                    snap['clinic_address'].toString(),
                    style: const TextStyle(color: ColorConfig.textColorDark),
                  ),
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
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                  child: Text(
                    snap['clinic_description'].toString(),
                    style: const TextStyle(color: ColorConfig.textColorDark),
                  ),
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
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                  child: Text(
                    snap['clinic_open_days_every'].toString(),
                    style: const TextStyle(color: ColorConfig.textColorDark),
                  ),
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
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                  child: Text(
                    snap['clinic_open_days_except'].toString(),
                    style: const TextStyle(color: ColorConfig.textColorDark),
                  ),
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
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                  child: Text(
                    _returnOpenTime().toString(),
                    style: const TextStyle(color: ColorConfig.textColorDark),
                  ),
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
