import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:slts_mobile_app/screens/guest/splash/splash_controller.dart';
import 'package:slts_mobile_app/styles/asset_manager.dart';
import 'package:slts_mobile_app/styles/styles.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return Obx(() {
      return Scaffold(
          backgroundColor: primaryColor,
          body:
          //  Stack(
          //   children: [
          //     SvgPicture.asset(ImageAssets.splash),
          //     SafeArea(child: Center(child: Image.asset(ImageAssets.appLogo1)))
          //   ],
          // ),
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(ImageAssets.splash1),fit: BoxFit.cover)),
          ),
          );
    // }
    // );
  }
}
