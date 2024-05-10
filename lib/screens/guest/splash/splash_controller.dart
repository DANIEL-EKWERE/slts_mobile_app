import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slts_mobile_app/route/app_links.dart';
import 'package:slts_mobile_app/services/logger.dart';
import 'package:slts_mobile_app/services/route_service.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Logger logger = Logger('SplashController');
  final animationValue = 0.0.obs;
  late AnimationController _animationController;

  SplashController() {
    init();
  }

  void init() async {
    logger.log('SplashController initialized');
    initAnimation();
    // deviceService.getDeviceInfo();
  }

    @override
  void onInit() {

    logger.log("Init called");
    super.onInit();
  }



  void initAnimation() {
    logger.log("animation started");
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    final animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves
          .elasticIn, // Use a different curve for the desired animation effect
    );

    animation.addListener(() {
      animationValue.value = animation.value;
    });

    // Start the animation when the controller is initialized
    _animationController.forward();

    // listen to animation completion and navigate to the login screen
    _animationController.addListener(() {
      logger.log("animation completed");
      if (_animationController.status == AnimationStatus.completed) {
        logger.log("msg: animation completed");

        Future.delayed(const Duration(seconds: 1), () async {
          routeService.gotoRoute(AppLinks.login);
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
