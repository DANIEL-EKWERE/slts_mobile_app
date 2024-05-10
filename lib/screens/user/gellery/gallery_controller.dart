import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slts_mobile_app/screens/models/violations_model.dart';
import 'package:slts_mobile_app/services/api_service.dart';
import 'package:slts_mobile_app/route/app_links.dart';
import 'package:slts_mobile_app/services/logger.dart';
import 'package:slts_mobile_app/services/route_service.dart';
import 'package:slts_mobile_app/utils/constants.dart';
// import 'package:slts_mobile_app/utils/utils.dart';

class GalleryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Logger logger = Logger('GalleryController');
  final animationValue = 0.0.obs;
  RxInt currentIndex = 0.obs;
  PageController controller = PageController();
  RxBool isDone = false.obs;
  // RxBool? isFirstTimeLogin;
  RxBool showPassword = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoading1 = false.obs;
  RxBool isGridView = true.obs;
  final contler = Get.put(ApiService()); // RxBool? isFirstTimeLogin;

  TextEditingController emailOrPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> galleryFormKey = GlobalKey<FormState>();

  GalleryController() {
    init();
  }

  void init() {
    logger.log('Controller initialized');
  }

  @override
  void onInit() async {
    super.onInit();
    logger.log("ONINIT CALLED:::::::::::::");
    contler.getViolations();
    // isFirstTimeLogin.value;
    // isFirstTimeLogin = await storageService.fetch("firstTimeLogin");
  }

  var searchQueries = {
    AppStrings.location,
    AppStrings.status,
    AppStrings.licensePlate
  };
  var galleryOption = {
    AppStrings.editSummary,
    AppStrings.reUpload,
    AppStrings.delete
  };

  void Function(String,Violation)? onSelected(String result,Violation violation) {
    if (result == 'Edit Summary') {
      print("summary called");
      routeService.gotoRoute(AppLinks.summary,arguments: violation);
    } else if (result == 'Re-upload') {
      print('upload called');
    } else {
      print("delete called");
    }
    return null;
  }

  void onChangeView() {
    isGridView.value = !isGridView.value;
  }

  // navigation method
  void routeToForgotPassword() =>
      routeService.gotoRoute(AppLinks.forgotPassword);

  void routeToAppLanding() => routeService.gotoRoute(AppLinks.appLanding);

  @override
  void dispose() {
    super.dispose();
  }
}
