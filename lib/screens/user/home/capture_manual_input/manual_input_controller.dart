// import 'dart:convert';

// ignore_for_file: avoid_print

// import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slts_mobile_app/models/violations/add_violations.dart';

import 'package:slts_mobile_app/route/app_links.dart';
import 'package:slts_mobile_app/services/api_service.dart';
import 'package:slts_mobile_app/services/db_service.dart';
import 'package:slts_mobile_app/services/logger.dart';
import 'package:slts_mobile_app/services/route_service.dart';
import 'package:slts_mobile_app/styles/asset_manager.dart';
import 'package:slts_mobile_app/styles/styles.dart';
import 'package:slts_mobile_app/utils/constants.dart';

// import 'package:slts_mobile_app/utils/utils.dart';
// import 'dart:io' as io;
import 'package:uuid/uuid.dart';

import '../../../../utils/utils.dart';

class ManualInputController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Logger logger = Logger('ManualInputController');
  var uuid = const Uuid();
  final animationValue = 0.0.obs;
  RxInt currentIndex = 0.obs;
  PageController controller = PageController();
  // RxBool? isFirstTimeLogin;
  RxBool isLoading = false.obs;
  ApiService contler = Get.put(ApiService());
  GlobalKey<FormState> offenceFormKey = GlobalKey<FormState>();
  TextEditingController plateNumberController = TextEditingController();
  TextEditingController violationCommentController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  // new fields
  TextEditingController vinController = TextEditingController();
  TextEditingController violationCodeController = TextEditingController();
  TextEditingController fineController = TextEditingController();
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController vehicleMakeController = TextEditingController();
  TextEditingController vehicleYearController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController creatorController = TextEditingController();
  TextEditingController violationController = TextEditingController();

  ImagePicker? picker = ImagePicker();
  ImagePicker? picker2 = ImagePicker();
  RxString selectedViolation = ''.obs;
  RxString selectedGender = ''.obs;
  RxString selectedVehicle = ''.obs;
  RxList<String>? imagePath = <String>[].obs;
  // added evidences
  RxList<String>? evidences = <String>[].obs;
  final Map<String, dynamic>? arguments = Get.arguments;
  RxBool isStatusCheck = false.obs;

  List<AddViolations> pendingUploads = [];

  ManualInputController() {
    init();
  }

  void init() {
    logger.log('Controller initialized');
  }

  @override
  void onInit() async {
    logger.log("we're here");
    super.onInit();

    if (arguments != null) {
      isStatusCheck.value = arguments?['isStatusCheck'] ?? false;
    }
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    pendingUploads = await databaseService.getPendingUploads('hello');
    // compute((message) => databaseService.getPendingUploads('hello'), 'done');
    if (pendingUploads.isNotEmpty) {
      logger.log("pending uploads:: ${pendingUploads.length}");
      logger.log("pending uploads:: ${pendingUploads.first.comment}");
      logger.log("pending uploads:: ${pendingUploads.first.evidences.first}");
    }
    super.onReady();
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

  List<String> images = [
    ImageAssets.platenumber,
    ImageAssets.platenumber,
    ImageAssets.platenumber,
  ];

  List<String> gender = [
    AppStrings.male,
    AppStrings.female,
    AppStrings.nonBinary,
  ];

  List<String> vehicleType = [
    AppStrings.motor,
    AppStrings.car,
    AppStrings.motorcycle,
    AppStrings.lorry,
    AppStrings.truck,
  ];

  List<String> violationTypes = [
    AppStrings.overspeeding,
    AppStrings.illegalPacking,
    AppStrings.recklessDriving,
  ];

  void onPageChanged(int value) {
    currentIndex.value = value;
    update();
  }

  // navigation method
  void goBack() => routeService.goBack();
  void routeToForgotPassword() =>
      routeService.gotoRoute(AppLinks.forgotPassword);

  void routeToAppLanding() => routeService.gotoRoute(AppLinks.appLanding);
  void routeToSummary() => routeService.gotoRoute(AppLinks.summary);

  Future<void> obtainImage() async {
    // newOffence.value = isNewOffence;
    try {
      final file = await picker?.pickImage(source: ImageSource.camera);
      if (file != null) {
        isLoading.value = true;
        // ignore: invalid_use_of_protected_member
        logger.log("image:: ${imagePath?.value}");
        imagePath?.add(file.path);
        update();
        // await processImage(file.path);
      }
    } catch (e) {
      logger.log("error: $e");
    }
  }

  Future<void> obtainImage2() async {
    // newOffence.value = isNewOffence;
    try {
      final file = await picker2?.pickImage(source: ImageSource.camera);
      if (file != null) {
        isLoading.value = true;
        // ignore: invalid_use_of_protected_member
        logger.log("image:: ${evidences?.value}");
        evidences?.add(file.path);
        update();
        // await processImage(file.path);
      }
    } catch (e) {
      logger.log("error: $e");
    }
  }

  void onSelectViolationType({required String violation}) {
    selectedViolation.value = violation;
    logger.log("violation: $violation ${selectedViolation.value}");
  }

  void onSelectGenderType({required String gender}) {
    selectedGender.value = gender;
    logger.log("Gender: $gender ${selectedGender.value}");
  }

  void onSelectVehicleType({required String vehicle}) {
    selectedVehicle.value = vehicle;
    logger.log("VehicleType: $vehicle ${selectedVehicle.value}");
  }

  final box = GetStorage();

  List<AddViolations> getBoxKeys() {
    final List<String> keys = box
        .getKeys()
        .where((key) => key.toString().startsWith('violation_'))
        .toList();
    final List<AddViolations> violationsKeyList = [];

    for (final key in keys) {
      final Map<String, dynamic>? data = box.read(key);
      if (data != null) {
        violationsKeyList.add(AddViolations.fromMap(data));
      }
    }

    return violationsKeyList;
  }
Future<void> addViolation() async{
  showSuccessSnackbar(
          snackPosition: SnackPosition.TOP, message: 'calling add violatopn controller', color: red);
contler.postViolations2(creator: creatorController, fine: fineController,vehicleMake: vehicleMakeController,
vehicleType: vehicleTypeController,vehicleYear: vehicleYearController,firstName: firstNameController,lastName: lastNameController,violation: violationController,violationCode: violationCodeController,violationLocation: locationController,vin: vinController,gender: genderController,plateNumber: plateNumberController,evidences: imagePath
);
}


 

  Future<void> addViolation1() async {
    print('post violation stage 1');
    final violation = AddViolations(
      // ignore: invalid_use_of_protected_member
      evidences: imagePath!.value,
      plateNumber: plateNumberController.text,
      violationLocation: locationController.text,
      violationType: selectedViolation.value,
      comment: violationCommentController.text,
      // adding this fields
      //  creator: creatorController.text,
      // ignore: invalid_use_of_protected_member
      //  evidence: evidences!.value,
      vin: vinController.text,
      violationCode: violationCodeController.text,
      violation: violationController.text,
      fine: fineController.text,
      vehicleMake: vehicleMakeController.text,
      vehicleType: vehicleTypeController.text,
      vehicleYear: vehicleYearController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      gender: genderController.text,
    );
    final uploads1 = await databaseService.getPendingUploads('para');
    logger.log("uploads::  ${uploads1.length}");

    final insertedkey = await databaseService.insertPendingUpload(violation);
    final uploads2 = await databaseService.getPendingUploads('para');
    logger.log("Key:: $insertedkey");
    logger.log("uploads::  ${uploads2.length}");

    // if API call is successful
    contler.postViolation1(
        body: violation as Map<String, dynamic>, endpoint: '/1/violations');
    print('$violation calling the violations');
    if (true) {
      final List<String> keys = box
          .getKeys()
          .where((key) => key.toString().startsWith('violation_'))
          .toList();
      final List<AddViolations> violationsList = [];

      for (final key in keys) {
        final Map<String, dynamic>? data = box.read(key);
        if (data != null) {
          violationsList.add(AddViolations.fromMap(data));
        }
      }
      List<String> uploadedKey =
          keys.where((key) => key.toString() == insertedkey).toList();
      print(uploadedKey);
      box.remove(uploadedKey.first);
    }

    final uploads = await databaseService.getPendingUploads('para');
    logger.log("uploads::  ${uploads.length}");

    // make api call
    // send violation to remote, if success, delete current violation from database
    // if failure it remains in the database
    print('it ends here##################');
    //TODO: THIS IS WHERE TO MAKE THE API CALL TO POST VIOLATIONS.
  }

  @override
  void dispose() {
    super.dispose();
  }
}
