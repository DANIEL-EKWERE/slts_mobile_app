import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slts_mobile_app/helpers/i_text_recognizer.dart';
import 'package:slts_mobile_app/helpers/ml_kit_text_recognizer.dart';

import 'package:slts_mobile_app/route/app_links.dart';
import 'package:slts_mobile_app/screens/models/recognition_response_model.dart';
import 'package:slts_mobile_app/screens/models/violations_model.dart';
import 'package:slts_mobile_app/services/device_service.dart';
import 'package:slts_mobile_app/services/logger.dart';
import 'package:slts_mobile_app/services/route_service.dart';
import 'package:slts_mobile_app/services/user_service.dart';
import 'package:slts_mobile_app/utils/constants.dart';
import 'package:slts_mobile_app/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Logger logger = Logger('HomeController');

  RxBool isDone = false.obs;
  // RxBool? isFirstTimeLogin;
  RxBool isLoading = false.obs;
  Rx<bool> newOffence = false.obs;
  // RxBool? isFirstTimeLogin;
  ITextRecognizer recognizer = MLKitTextRecognizer();
  Rx<RecognitionResponse>? recognitionResponse =
      RecognitionResponse(imgPath: '', recognizedText: '').obs;
  // Rx<UserModel> user = UserModel().obs;

  TextEditingController textController = TextEditingController();

  ImagePicker? picker = ImagePicker();
  Rx<String>? imagePath = ''.obs;

  HomeController() {
    init();
  }

  void init() {
    logger.log('Controller initialized');
  }

  @override
  void onInit() async {
    super.onInit();
    Map<String, dynamic>? arguments = Get.arguments;

    if (arguments != null) {
      // isLoading.value = true;
    }
  }

  RxString? loginTime = ''.obs;
  RxString? currentAddress = ''.obs;
  @override
  void onReady() async {
    // TODO: implement onReady
    loginTime!.value = await getLoginTime();
    currentAddress!.value = deviceService.currentAddress!.value;
    logger.log("User addrss:: ${currentAddress!.value}");
    final isPermissionGranted = await deviceService.handleLocationPermission();
    if (isPermissionGranted) {
      await deviceService.getUserPosition();
    }
    super.onReady();
  }

  var galleryOption = {
    AppStrings.editSummary,
    AppStrings.reUpload,
    AppStrings.delete
  };

  void Function(String,Violation)? onSelected(String result, Violation violation) {
    if (result == 'Edit Summary') {
      print("summary called");
      routeService.gotoRoute(AppLinks.summary,arguments: violation);
    // Get.toNamed('/summary',arguments: violation);
    } else if (result == 'Re-upload') {
      print('upload called');
    } else {
      print("delete called");
    }
    return null;
  }

  // navigation method

  void routeToAppLanding() => routeService.gotoRoute(AppLinks.appLanding);
  void routeToManualInput({bool? isStatusCheck}) {
    Get.back();
    routeService.gotoRoute(AppLinks.manualInput,
        arguments: {"isStatusCheck": isStatusCheck});
  }

  Future<void> obtainImage({required bool isNewOffence}) async {
    newOffence.value = isNewOffence;
    Get.back();
    try {
      final file = await picker?.pickImage(source: ImageSource.camera);
      if (file != null) {
        isLoading.value = true;
        logger.log("image:: ${imagePath?.value}");
        await processImage(file.path);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> processImage(String imgPath) async {
    try {
      final recognizedText = await recognizer.processImage(imgPath);
      logger.log("recognized text:: $recognizedText");

      // Use a regular expression to match the desired pattern
      RegExp pattern = RegExp(r'^[A-Z]{3}-?[A-Z\d]{5}$', multiLine: true);
      Match? match = pattern.firstMatch(recognizedText);

      if (match != null) {
        // Text matches the desired pattern
        String matchedText = match.group(0)!;

        recognitionResponse?.value = RecognitionResponse(
          imgPath: imgPath,
          recognizedText: matchedText,
        );

        logger.log("response::${recognitionResponse?.value.recognizedText}");

        if (recognitionResponse?.value != null) {
          if (newOffence.value) {
            routeService.gotoRoute(AppLinks.newOffence,
                arguments: recognitionResponse!.value);
          } else {
            final isPreviousOffender = hasOffenceRecord();
            if (isPreviousOffender) {
              routeService.gotoRoute(AppLinks.summary);
            } else {
              showErrorSnackbar(message: "User has no previous offence");
            }
          }
        } else {
          logger.log("No data");
        }
      } else {
        // Text doesn't match the desired pattern
        logger.log("Text does not match the desired pattern");
        logger.log(recognizedText.toString());
        showErrorSnackbar(message: "cannot detect plate number");
      }
    } finally {
      isLoading.value = false;
    }
  }

  bool hasOffenceRecord() {
    return false;
  }

// Function to retrieve and display login time on the home page
  Future<String> getLoginTime() async {
    // Retrieve login time from storage
    var time = await userService.getData('last_login');
    if (time != null) {
      // If login time is available, return formatted login time

      return time;
    } else {
      // If login time is not available, return default message
      return 'NAN';
    }
  }

  @override
  void dispose() {
    super.dispose();

    if (recognizer is MLKitTextRecognizer) {
      (recognizer as MLKitTextRecognizer).dispose();
    }
  }
}
