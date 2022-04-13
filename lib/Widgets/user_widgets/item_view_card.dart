import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Widgets/user_widgets/item_view.dart';
import 'package:sizer/sizer.dart';

class ItemViewCard extends StatelessWidget {
  final snap;

  const ItemViewCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => ItemView(snap: snap)),
      child: Card(
        elevation: 5,
        child: SizedBox(
          height: 55.h,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100.w,
                  height: 40.h,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: snap['image_url'],
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(
                          color: ColorConfig.orange,
                          value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 50.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 90.w,
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                  child: Text(snap['item_name'].toString()),
                                ),
                              ],
                            ),
                          ),
                          snap['isAvailable']
                              ? const Text(
                                  '${'In Stocks'}',
                                  style: TextStyle(color: Colors.green),
                                )
                              : const Text('${'Out of Stock'}',
                                  style: TextStyle(color: Colors.red))
                        ],
                      ),
                    ),
                    Text(
                      "Rs ${snap['price']}",
                      style: TextStyle(fontSize: 18.sp),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
