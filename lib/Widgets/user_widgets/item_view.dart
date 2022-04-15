import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Utils/utill.dart';
import 'package:paw_and_love/Widgets/seller/contact_button.dart';
import 'package:sizer/sizer.dart';

class ItemView extends StatelessWidget {
  final snap;

  const ItemView({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                iconTheme:
                    const IconThemeData(color: ColorConfig.textColorDark),
                elevation: 0,
                expandedHeight: 50.h,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: snap['image_url'],
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                const Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
                  child: Text(
                    "Item Name",
                    style: TextStyle(color: ColorConfig.orange),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                  child: Text(
                    snap['item_name'].toString(),
                    style: const TextStyle(color: ColorConfig.textColorDark),
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
                  child: Text(
                    "Price",
                    style: TextStyle(color: ColorConfig.orange),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                  child: Text(
                    " Rs : ${snap['price']}".toString(),
                    style: const TextStyle(color: ColorConfig.textColorDark),
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
                  child: Text(
                    "Seller Name",
                    style: TextStyle(color: ColorConfig.orange),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                  child: Text(
                    snap['name'],
                    style: const TextStyle(color: ColorConfig.textColorDark),
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
                  child: Text(
                    "Contact Number",
                    style: TextStyle(color: ColorConfig.orange),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                  child: Text(
                    snap['phone_number'],
                    style: const TextStyle(color: ColorConfig.textColorDark),
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
                  child: Text(
                    "Address",
                    style: TextStyle(color: ColorConfig.orange),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                  child: Text(
                    snap['address'].toString().trim(),
                    style: const TextStyle(color: ColorConfig.textColorDark),
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
                  child: Text(
                    "Item Description",
                    style: TextStyle(color: ColorConfig.orange),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                  child: Text(
                    snap['description'],
                    style: const TextStyle(color: ColorConfig.textColorDark),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 5),
                  child: ContactButton(
                      buttonText: "Contact Seller",
                      callbackFunction: () async {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: snap['phone_number'],
                        );
                        await urlLauncher(launchUri.toString());
                      },
                      backgroundColor: ColorConfig.orange),
                )
              ]))
            ];
          },
          body: Container()),
    );
  }
}
