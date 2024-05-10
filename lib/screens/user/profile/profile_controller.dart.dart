import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slts_mobile_app/models/user_model.dart';

import 'package:slts_mobile_app/route/app_links.dart';
import 'package:slts_mobile_app/services/logger.dart';
import 'package:slts_mobile_app/services/route_service.dart';
import 'package:slts_mobile_app/services/user_service.dart';
// import 'package:slts_mobile_app/utils/utils.dart';

class ProfileController extends GetxController {
      Rx<UserModel> user = UserModel().obs;
  Logger logger = Logger('ProfileController');
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
  // GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  ProfileController() {
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
    user.value = userService.user.value;
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  void obscurePassword() => showPassword.value = !showPassword.value;
  // update();

  // navigation method
  void routeToForgotPassword() =>
      routeService.gotoRoute(AppLinks.forgotPassword);

  void routeToAppLanding() => routeService.gotoRoute(AppLinks.appLanding);




  @override
  void dispose() {
    super.dispose();
  }
}
