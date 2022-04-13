import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Widgets/customeCircularProgress.dart';
import 'package:paw_and_love/controller/seller/seller_dashboard_controller.dart';
import 'package:sizer/sizer.dart';

import '../../screens/seller_and_breeders/update_item.dart';

class ItemCard extends StatelessWidget {
  final snap;

  const ItemCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => UpdateItem(snap: snap));
      },
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: CachedNetworkImage(
                        imageUrl: snap['image_url'],
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CustomeCircularProgress(
                          color: ColorConfig.orange,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 60.w,
                          child: Text(
                            snap['item_name'].toString(),
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        snap['isAvailable']
                            ? const Text("Status : Available")
                            : const Text('Status : Not Available'),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text("see more..")
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
