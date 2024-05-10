import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:slts_mobile_app/route/app_links.dart';
import 'package:slts_mobile_app/services/logger.dart';
import 'package:slts_mobile_app/services/route_service.dart';
import 'package:slts_mobile_app/utils/utils.dart';

class ForgotPasswordController extends GetxController {
  Logger logger = Logger('ForgotPasswordController');
  RxBool isLoading = false.obs;

  Duration myDuration = const Duration(days: 5);
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conFirmPasswordController =
      TextEditingController();
  RxBool showPassword = true.obs;
  RxBool showPassword1 = true.obs;
  GlobalKey<FormState> forgotasswordFormKey = GlobalKey<FormState>();
  final FocusNode focus = FocusNode();
  RxString accessToken = ''.obs;

  ForgotPasswordController() {
    init();
  }

  void init() {
    logger.log('Controller initialized');
    load();
  }

  void load() {
    logger.log('Loading');
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    logger.log("reset password init called");
    // Access the arguments using Get.arguments
    // Map<String, dynamic>? arguments = Get.arguments;

    // if (arguments != null) {
    //   accessToken.value = arguments['accessToken'];

    //   // Now you have access to the passed data (emailOrPhone)
    //   logger.log('Received accessToken: $accessToken');
    // }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  void onFocusChange() => update();

  void obscurePassword() {
    showPassword.value = !showPassword.value;
  }

  void obscurePassword1() {
    showPassword1.value = !showPassword1.value;
  }

  @override
  void dispose() {
    super.dispose();
    emailOrPhoneController.dispose();
  }

  void goBack() => routeService.goBack();

 
  void routeToLogin() => routeService.goBack();

  Future<void> requestResetPassword() async {
    if (!forgotasswordFormKey.currentState!.validate()) {
      return;
    }
    isLoading.value = true;

    try {
      // final result = await authService
      //     .requestResetPassword(payload: {"user": emailOrPhoneController.text});

      // if (result.status == "success" || result.status_code == 200) {
      //   await showSuccessSnackbar(message: result.message!);
      //   isLoading.value = false;
      //   await routeService.gotoRoute(AppLinks.verifyOtp, arguments: {
      //     'emailOrPhone': emailOrPhoneController.text,
      //     "isResetPassword": true,
      //   });
      // }
    } catch (e) {
      logger.log("error rrr: $e");
      showErrorSnackbar(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

}
