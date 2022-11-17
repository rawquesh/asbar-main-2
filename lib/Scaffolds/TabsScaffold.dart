import 'package:asbar/Constants/colors.dart';
import 'package:asbar/Constants/styles.dart';
import 'package:asbar/Providers/MainProvider.dart';
import 'package:asbar/Screens/Tabs/CameraTab.dart';
import 'package:asbar/Screens/Tabs/HomeTab.dart';
import 'package:asbar/Screens/Tabs/ProfileTab.dart';
import 'package:asbar/Screens/Tabs/gallery.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TabsScaffold extends StatelessWidget {
  TabsScaffold({Key? key}) : super(key: key);

  static const id = 'tabs_scaffold';

  final _tabs = [
    HomeTab(),
    CameraTab(),
    MyGallery(),
  ];

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(context);

    return ModalProgressHUD(
      inAsyncCall: mainProvider.showSpinner,
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar:
            mainProvider.bottomTabIndex == 1 ? null : _buildNavigationBar(),
        backgroundColor: kWhite,
        appBar: mainProvider.bottomTabIndex == 1
            ? null
            : AppBar(
                title: Row(children: [
                  SizedBox(
                    width: 5.w,
                  ),
                  Image.asset(
                    'assets/asbar.png',
                    height: 2.2.h,
                    fit: BoxFit.fitHeight,
                  ),
                  Spacer(),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfileTab()));
                      },
                      child: ProfileButton()),
                  SizedBox(
                    width: 5.w,
                  ),
                ]),
                // leadingWidth: 40.w,
                // leading:
                elevation: 2,
                backgroundColor: Colors.white,
              ),
        body: SafeArea(child: _tabs[mainProvider.bottomTabIndex]),
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.h,
      width: 5.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 0.5,
          color: Colors.black.withOpacity(0.2),
        ),
      ),
      child: Icon(
        Icons.person_rounded,
        color: kBlue1,
        size: 4.h,
      ),
    );
  }
}

class _buildNavigationBar extends StatelessWidget {
  const _buildNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15.h,
      decoration: BoxDecoration(color: Colors.white,
          // border: Border(
          // top: BorderSide(width: 1.2, color: kBorderGrey),
          //     ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -1),
              blurRadius: 10,
              color: Colors.black.withOpacity(0.08),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ///Home Tab
          SingleBottomTab(index: 0),

          ///Camera Tab
          SingleBottomTab(index: 1),

          ///Profile Tab
          SingleBottomTab(index: 2),
        ],
      ),
    );
  }
}

class SingleBottomTab extends StatelessWidget {
  SingleBottomTab({Key? key, required this.index}) : super(key: key);
  final int index;

  final List<String> _icons = [
    'assets/svgs/feed.svg',
    '',
    'assets/svgs/gallery.svg',
  ];

  final List _tabNames = ["Home", "Camera", "Profile"];

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(context);
    MainProvider mainProviderFalse =
        Provider.of<MainProvider>(context, listen: false);

    int selectedIndex = mainProvider.bottomTabIndex;

    return InkWell(
      onTap: () {
        mainProviderFalse.changeBottomTabIndex(index);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            if (index == 1) const CameraButton(),
            SvgPicture.asset(
              _icons[index],
              height: 4.h,
              color: index == selectedIndex ? kBlue2 : kBlue1.withOpacity(0.2),
            ),

            // Icon(_icons[index],
            //     color: index == selectedIndex ? kBlue2 : kDarkGrey),
            const SizedBox(width: 12),
            // Text(
            //   _tabNames[index],
            //   style: kMedium13.copyWith(
            //       color: index == selectedIndex ? kBlue2 : kDarkGrey),
            // )
          ],
        ),
      ),
    );
  }
}

class CameraButton extends StatelessWidget {
  const CameraButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 4.h,
      backgroundColor: kBlue1,
      child: CircleAvatar(
        radius: 3.h,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 2.h,
          backgroundColor: Color(0xffcee9ff),
          child: CircleAvatar(
            radius: 0.5.h,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
