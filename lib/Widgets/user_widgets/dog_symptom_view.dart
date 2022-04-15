import 'package:flutter/material.dart';
import 'package:paw_and_love/Config/assets_path.dart';

import 'package:paw_and_love/Utils/styles.dart';
import 'package:paw_and_love/Utils/utill.dart';
import 'package:paw_and_love/model/user/dog_illness_model.dart';

import 'package:sizer/sizer.dart';

import '../../Config/color_config.dart';

class DogSymptomView extends StatelessWidget {
  final DogIllnessModel dogIllnessModel;

  const DogSymptomView({Key? key, required this.dogIllnessModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                elevation: 0,
                iconTheme:
                    const IconThemeData(color: ColorConfig.textColorDark),
                expandedHeight: 50.h,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(dogIllnessModel.name),
                  background: Image.asset(sickDog),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                if (dogIllnessModel.description != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "What is ${dogIllnessModel.name} ?",
                          style: defaultTextStyleSubTopic(),
                        ),
                        const Divider(),
                        Text(
                          dogIllnessModel.description,
                          style: defaultTextStyle(),
                        )
                      ],
                    ),
                  ),
                if (dogIllnessModel.symptoms.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "What are the symptoms of ${dogIllnessModel.name} ?",
                          style: defaultTextStyleSubTopic(),
                        ),
                        const Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: dogIllnessModel.symptoms
                              .map((e) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child:
                                      Text("* $e", style: defaultTextStyle())))
                              .toList(),
                        )
                      ],
                    ),
                  ),
                if (dogIllnessModel.treatment != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "What are the tretments for ${dogIllnessModel.name} ?",
                          style: defaultTextStyleSubTopic(),
                        ),
                        const Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: dogIllnessModel.treatment
                              .map((e) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child:
                                      Text("* $e", style: defaultTextStyle())))
                              .toList(),
                        )
                      ],
                    ),
                  ),
                if (dogIllnessModel.causes != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "What are the reasons for ${dogIllnessModel.name} ?",
                          style: defaultTextStyleSubTopic(),
                        ),
                        const Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: dogIllnessModel.causes
                              .map((e) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child:
                                      Text("* $e", style: defaultTextStyle())))
                              .toList(),
                        )
                      ],
                    ),
                  ),
                if (dogIllnessModel.action != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "What can do for that ?",
                          style: defaultTextStyleSubTopic(),
                        ),
                        const Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: dogIllnessModel.action
                              .map((e) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child:
                                      Text("* $e", style: defaultTextStyle())))
                              .toList(),
                        )
                      ],
                    ),
                  ),
                if (dogIllnessModel.prevent != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "How to prevent the ${dogIllnessModel.name} ?",
                          style: defaultTextStyleSubTopic(),
                        ),
                        const Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: dogIllnessModel.prevent
                              .map((e) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child:
                                      Text("* $e", style: defaultTextStyle())))
                              .toList(),
                        )
                      ],
                    ),
                  ),
                if (dogIllnessModel.source != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Source : ",
                          style: defaultTextStyleSubTopic(),
                        ),
                        const Divider(),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            child: InkWell(
                              onTap: () {
                                urlLauncher(dogIllnessModel.source);
                              },
                              child:
                                  Text("Click here", style: defaultTextStyle()),
                            ))
                      ],
                    ),
                  ),
              ]))
            ];
          },
          body: Container()),
    );
  }
}
