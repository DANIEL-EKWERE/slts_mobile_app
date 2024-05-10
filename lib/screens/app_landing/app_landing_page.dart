// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:slts_mobile_app/screens/app_landing/app_landing_controller.dart';
import 'package:slts_mobile_app/screens/user/gellery/gallery_screen.dart';
import 'package:slts_mobile_app/screens/user/home/home_screen.dart';
import 'package:slts_mobile_app/screens/user/profile/profile_screen.dart';
import 'package:slts_mobile_app/styles/asset_manager.dart';
import 'package:slts_mobile_app/styles/styles.dart';
import 'package:slts_mobile_app/utils/constants.dart';

class AppLanding extends StatelessWidget {
  AppLanding({super.key});

  final AppLandingController controller = Get.put(
    AppLandingController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() => bottomNavBar(context, controller)),
      body: Obx(() => IndexedStack(
            index: controller.tabIndex.value,
            children:  [
              HomeScreen(),
              GalleryScreen(),
              ProfileScreen(),
            ],
          )),
    );
  }

  Widget bottomNavBar(
      BuildContext context, AppLandingController landingPageController) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: ClipRRect(
          borderRadius:  BorderRadius.only(
        topRight: Radius.circular(24.r),
        topLeft: Radius.circular(24.r),
                ),
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: landingPageController.changeTabIndex,
            currentIndex: landingPageController.tabIndex.value,
            backgroundColor: white,
            unselectedItemColor: black,
            selectedItemColor: primaryColor,
            unselectedLabelStyle: getRegularStyle(fontSize: 12, color: black)
                .copyWith(fontWeight: FontWeight.w400),
            selectedLabelStyle: getRegularStyle(fontSize: 13, color: primaryColor)
                .copyWith(fontWeight: FontWeight.w400),
            items: [
              BottomNavigationBarItem(
                // icon: Icon(Icons.camera),
               icon: Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: SvgPicture.asset(
                    ImageAssets.home,
                    height: 24.sp,
                    width: 24.sp,
                    color: landingPageController.tabIndex.value == 0
                        ? primaryColor
                        : null,
                  ),
                ),
                label: AppStrings.home,
                backgroundColor: backgroundColor,
              ),
              BottomNavigationBarItem(
                icon: 
                 Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: SvgPicture.asset(
                    ImageAssets.image,
                    height: 24.sp,
                    width: 24.sp,
                    color: landingPageController.tabIndex.value == 1
                        ? primaryColor
                        : black,
                  ),
                ),
                label: AppStrings.gallery,
                backgroundColor: backgroundColor,
              ),
              BottomNavigationBarItem(
                icon: 

                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: SvgPicture.asset(
                    ImageAssets.user,
                    height: 24.sp,
                    width: 24.sp,
                    color: landingPageController.tabIndex.value == 2
                        ? primaryColor
                        : null,
                  ),
                ),
                label: AppStrings.profile,
                backgroundColor: backgroundColor,
              ),
            ],
          ),
        ));
  }
}
