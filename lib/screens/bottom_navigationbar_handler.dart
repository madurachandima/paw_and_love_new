import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Utils/const.dart';
import 'package:paw_and_love/screens/home.dart';
import 'package:paw_and_love/screens/seller_and_breeders/requested_purched_item.dart';
import 'package:paw_and_love/screens/users/dog_profiles.dart';
import 'package:paw_and_love/screens/users/user_requested_appointments.dart';
import 'package:paw_and_love/screens/vet/appointmentRequest.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomNavigationbarHandler extends StatelessWidget {
  final String? role;

  const BottomNavigationbarHandler({Key? key, required this.role})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PersistentTabController tabController =
        PersistentTabController(initialIndex: 0);

    List<Widget> _buildScreens() {
      return [
        Home(role: role),
        role == USER_ROLE
            ? const UserRequestedAppointments()
            : role == SELLER_ROLE
                ? const RequestedPurchasedItem()
                : const AppointmentRequest(),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.home),
          title: ("Home"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.notifications_active_outlined),
          title: ("Requests"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }

    return Scaffold(
      backgroundColor: ColorConfig.white,
      appBar: AppBar(),
      body: Home(role: role),
      bottomNavigationBar: PersistentTabView(
        context,
        controller: tabController,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        // Default is Colors.white.
        handleAndroidBackButtonPress: true,
        // Default is true.
        resizeToAvoidBottomInset: true,
        // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true,
        // Default is true.
        hideNavigationBarWhenKeyboardShows: true,
        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style1, // Choose the nav bar style with this property.
      ),
    );
  }
}
