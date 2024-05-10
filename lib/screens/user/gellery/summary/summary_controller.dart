import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:slts_mobile_app/route/app_links.dart';
import 'package:slts_mobile_app/screens/models/violations_model.dart';
import 'package:slts_mobile_app/services/logger.dart';
import 'package:slts_mobile_app/services/route_service.dart';
import 'package:slts_mobile_app/styles/asset_manager.dart';
import 'package:slts_mobile_app/utils/constants.dart';
// import 'package:slts_mobile_app/utils/utils.dart';

class SummaryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Logger logger = Logger('SummaryController');
  final animationValue = 0.0.obs;
  RxInt currentIndex = 0.obs;
  PageController controller = PageController();
  RxBool isDone = false.obs;
  // RxBool? isFirstTimeLogin;
  RxBool showPassword = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoading1 = false.obs;
  // RxBool? isFirstTimeLogin;

  TextEditingController emailOrPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> summaryFormKey = GlobalKey<FormState>();

  SummaryController() {
    init();
  }

  void init() {
    logger.log('Controller initialized');
  }

  @override
  void onInit() async {
    super.onInit();
    // isFirstTimeLogin.value;
    // isFirstTimeLogin = await storageService.fetch("firstTimeLogin");
  }

  

  var searchQueries = {AppStrings.location, AppStrings.status, AppStrings.licensePlate};
  var galleryOption = {AppStrings.editSummary, AppStrings.reUpload, AppStrings.delete};

   List<String> images = [
    ImageAssets.platenumber,
    ImageAssets.platenumber,
    ImageAssets.platenumber,
  ];

   void onPageChanged(int value) {
    currentIndex.value = value;
    update();
  }
    void Function(String,Violation)? onSelected(String result, Violation violation) {
    if (result == 'Edit Summary') {
      logger.log("edit summary called");
      routeService.gotoRoute(AppLinks.newOffence, arguments: violation);
    } else if (result == 'Re-upload') {
      logger.log('upload called');
    } else {
      logger.log("delete called");
    }
    return null;
  }

  // navigation method
  void goBack ()=> routeService.goBack();
  void routeToForgotPassword() =>
      routeService.gotoRoute(AppLinks.forgotPassword);

  void routeToAppLanding() => routeService.gotoRoute(AppLinks.appLanding);

  @override
  void dispose() {
    super.dispose();
  }
}
