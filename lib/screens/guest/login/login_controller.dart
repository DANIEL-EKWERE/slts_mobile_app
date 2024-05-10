import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slts_mobile_app/models/auth/authorization_model.dart';
import 'package:slts_mobile_app/models/auth/login_model.dart';
import 'package:slts_mobile_app/models/auth/token_model.dart';
import 'package:slts_mobile_app/models/user_model.dart';

import 'package:slts_mobile_app/route/app_links.dart';
import 'package:slts_mobile_app/services/api_service.dart';
// import 'package:slts_mobile_app/services/auth_service.dart';
// import 'package:slts_mobile_app/services/db_service.dart';
import 'package:slts_mobile_app/services/device_service.dart';
import 'package:slts_mobile_app/services/logger.dart';
import 'package:slts_mobile_app/services/route_service.dart';
import 'package:slts_mobile_app/services/token_service.dart';
import 'package:slts_mobile_app/services/user_service.dart';
import 'package:slts_mobile_app/utils/utils.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Logger logger = Logger('LoginController');
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
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  LoginController() {
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

  @override
  void onReady() async {
    // TODO: implement onReady
    await deviceService.getCurrentPosition();
    super.onReady();
  }

  void obscurePassword() => showPassword.value = !showPassword.value;
  // update();

  // navigation method
  void routeToForgotPassword() =>
      routeService.gotoRoute(AppLinks.forgotPassword);

  void routeToAppLanding() => routeService.gotoRoute(AppLinks.appLanding);

  // List<UserModel> parseUserList(List<dynamic> list) {
  //   return List<UserModel>.from(
  //     list.map((item) => UserModel.fromJson(item)),
  //   );
  // }

  // Future<bool?> firstTimeLoginCheck() async {
  //   bool? value = await storageService.fetch('firstTimeLogin');
  //   if (value == null || value == true) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<void> processLogin() async {
    if (!loginFormKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    try {
      final response = await apiService.post(
        endpoint: '/auth/login',
        body: LoginRequestModel(
          email: emailOrPhoneController.text,
          password: passwordController.text,
        ).toJson(),
      );

      logger.log(response.toString());

      if (response['reqSuccess']) {
        if (response['reqResponse'].toString().contains('errorCode')) {
          showErrorSnackbar(
            title: response['Error'],
            message: response['reqResponse']['description'],
          );
        } else {
          await handleSuccessfulLogin(response);
        }
      } else {
        showErrorSnackbar(
          title: response['reqMessage'],
          message: response['reqResponse'],
        );
      }
    } catch (e) {
      logger.log("error rrr: $e");
      showErrorSnackbar(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handleSuccessfulLogin(Map<String, dynamic> response) async {
    TokenModel tokenModel = tokenModelFromJson(response['reqResponse']);
    await tokenService.saveTokensData(tokenModel);

    final authResponse = await getAuthorization();
    if (authResponse['reqSuccess']) {
      logger.log("User authorization:: ${authResponse['reqResponse']}");
      await handleSuccessfulAuthorization(authResponse);
    } else {
      showErrorSnackbar(
        title: 'Error',
        message: authResponse['reqResponse'],
      );
    }

    showSuccessSnackbar(message: response['reqMessage']);
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<Map<String, dynamic>> getAuthorization() async {
    try {
      final authResponse = await apiService.getRequest('/authorizations');
      if (authResponse.toString().contains('errorCode')) {
        return {
          "reqSuccess": false,
          "reqResponse": authResponse["description"]
        };
      } else {
        logger.log("User authorization:: ${authResponse}");
        var value = jsonDecode(authResponse);
        AuthorizationModel authorizationModel =
            AuthorizationModel.fromJson(value);

        final userResponse = await apiService.getRequest(
            "/${authorizationModel.tenant!.id}/profiles/${authorizationModel.id}");
        var user = jsonDecode(userResponse);
        UserModel userModel = UserModel.fromJson(user);
        userService.setCurrentUser(user);
        await userService.saveUserData(userModel);
        logger.log("Success");

        return {"reqSuccess": true, "reqResponse": authResponse};
      }
    } catch (e) {
      logger.log("Error:: ${e.toString()}");
      return {"reqSuccess": true, "reqResponse": "Error: $e"};
    }
  }

  Future<void> handleSuccessfulAuthorization(
      Map<String, dynamic> authResponse) async {
    if (authResponse['reqSuccess']) {
      var value = jsonDecode(authResponse['reqResponse']);
      AuthorizationModel authorizationModel =
          AuthorizationModel.fromJson(value);

      final userResponse = await apiService.getRequest(
          "/${authorizationModel.tenant!.id}/profiles/${authorizationModel.id}");
      var user = jsonDecode(userResponse);
      UserModel userModel = UserModel.fromJson(user);
      userService.setCurrentUser(user);
      await userService.saveUserData(userModel);
      // login time
      await captureLoginTime();
      logger.log("Success");
      routeService.offAllNamed(AppLinks.appLanding);
    } else {
      showErrorSnackbar(
        title: 'Error',
        message: authResponse['reqResponse'],
      );
    }
  }

  // Function to capture the login time
  Future<void> captureLoginTime() async {
    final DateTime loginTime = DateTime.now();
    final String formattedLoginTime = formatDateTime(date: loginTime);

    // Save the login time to storage
    await userService.saveData('last_login', formattedLoginTime);
  }

  void dispose() {
    super.dispose();
  }
}
