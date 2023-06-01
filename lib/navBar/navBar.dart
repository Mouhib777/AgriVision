import 'package:agri_vision/constant/constant.dart';
import 'package:agri_vision/screens/camera.dart';
import 'package:agri_vision/screens/homeScreen.dart';
import 'package:agri_vision/screens/notificationScreen.dart';
import 'package:agri_vision/screens/profileScreen.dart';
import 'package:agri_vision/screens/treeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
//import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class navBar extends StatelessWidget {
  static const String id = 'main-screen';
  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);
    List<Widget> _buildScreens() {
      return [
        homeScreen(),
        treeScreen(),
        cameraScreen(),
        notificationScreen(),
        ProfileScreen(),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          iconSize: 32,
          icon: Image.asset('assets/images/icons/home.png'),
          // title: ("Home"),
          activeColorPrimary: primaryColor,

          inactiveColorPrimary: Colors.black,
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset('assets/images/icons/tree.png'),
          // title: ("My Ordre"),
          activeColorPrimary: primaryColor,
          inactiveColorPrimary: Colors.black,
        ),
        PersistentBottomNavBarItem(
          iconSize: 35,
          icon: Image.asset('assets/images/icons/camera.png'),

          //title: ("Favorites"),
          activeColorPrimary: primaryColor,
          inactiveColorPrimary: Colors.yellow,
        ),
        PersistentBottomNavBarItem(
          iconSize: 32,
          icon: Icon(CupertinoIcons.chat_bubble_2),
          // title: ("Chat"),
          activeColorPrimary: primaryColor,
          inactiveColorPrimary: Colors.black,
        ),
        PersistentBottomNavBarItem(
          iconSize: 32,
          icon: Icon(CupertinoIcons.profile_circled),
          // title: ("Chat"),
          activeColorPrimary: primaryColor,
          inactiveColorPrimary: Colors.black,
        ),
      ];
    }

    return Scaffold(
        body: PersistentTabView(
      context,
      navBarHeight: 70,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,

      //, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), topLeft: Radius.circular(25)),

        //border: Border.all(color: Colors.black26)
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style15, // Choose the nav bar style with this property.
    ));
  }
}
