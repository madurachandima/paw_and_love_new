import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/controller/seller/seller_dashboard_controller.dart';
import 'package:paw_and_love/screens/seller_and_breeders/dashboard_tabs/new_sell.dart';
import 'package:paw_and_love/screens/seller_and_breeders/dashboard_tabs/your_ads.dart';
import 'package:sizer/sizer.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SellerDashboardController _controller =
        Get.put(SellerDashboardController());
    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              onTap: (value) {
                if (value == 0) {
                  _controller.clearTextFields();
                }
              },
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(
                    child: Text(
                  "New Sell",
                  style: TextStyle(fontSize: 15.sp),
                )),
                Tab(
                    child:
                        Text("Sold Item", style: TextStyle(fontSize: 15.sp))),
                Tab(child: Text("Your Ads", style: TextStyle(fontSize: 15.sp))),
              ],
            ),
            // title: const Text('Tabs Demo'),
          ),
          body: const TabBarView(
            children: [NewSell(), Text("sold item"), YourAds()],
          ),
        ));
  }
}
