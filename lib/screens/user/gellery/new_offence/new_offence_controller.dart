import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import 'package:slts_mobile_app/route/app_links.dart';
import 'package:slts_mobile_app/screens/models/violations_model.dart';
import 'package:slts_mobile_app/services/api_service.dart';
import 'package:slts_mobile_app/services/logger.dart';
import 'package:slts_mobile_app/services/route_service.dart';
import 'package:slts_mobile_app/styles/asset_manager.dart';
import 'package:slts_mobile_app/styles/styles.dart';
import 'package:slts_mobile_app/utils/constants.dart';
import 'package:slts_mobile_app/utils/utils.dart';
// import 'package:slts_mobile_app/utils/utils.dart';

class NewOffenceController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Logger logger = Logger('NewOffenceController');
  final animationValue = 0.0.obs;
  RxInt currentIndex = 0.obs;
  PageController controller = PageController();
  RxBool isDone = false.obs;
  // RxBool? isFirstTimeLogin;
  RxBool showPassword = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoading1 = false.obs;
  // RxBool? isFirstTimeLogin;
  final Violation? violation = Get.arguments;

  TextEditingController plateNumberController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController fineController = TextEditingController();
  TextEditingController violationController = TextEditingController();
  TextEditingController violationCodeController = TextEditingController();
  TextEditingController vehicleMakeController = TextEditingController();
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController vehicleYearController = TextEditingController();
  TextEditingController vinController = TextEditingController();
  TextEditingController creatorController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController violationTypeController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  GlobalKey<FormState> offenceFormKey = GlobalKey<FormState>();

  RxString selectedViolation = ''.obs;
  RxString selectedGender = ''.obs;
  RxString selectedVehicle = ''.obs;
  RxList<String>? imagePath = <String>[].obs;
  final contler = Get.put(ApiService());
  NewOffenceController() {
    init();
  }

  void init() {
    logger.log('Controller initialized');
  }

  @override
  void onInit() async {
    super.onInit();
    plateNumberController.text = violation!.plateNumber;
    firstNameController.text = violation!.firstName;
    lastNameController.text = violation!.lastName;
    selectedGender.value = violation!.gender.toString();
    fineController.text = violation!.fine.toString();
    selectedViolation.value = violation!.violationType;
    violationController.text = violation!.violation;
    violationCodeController.text = violation!.violationCode;
    vehicleMakeController.text = violation!.vehicleMake;
    selectedVehicle.value = violation!.vehicleType;
    vehicleYearController.text = violation!.vehicleYear;
    vinController.text = violation!.vin;
    creatorController.text = violation!.creator!.id;
    locationController.text = violation!.violationLocation.toString();
    violationTypeController.text = violation!.violationType;
    GlobalKey<FormState> offenceFormKey = GlobalKey<FormState>();

    // isFirstTimeLogin.value;
    // isFirstTimeLogin = await storageService.fetch("firstTimeLogin");
  }

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

  List<String> violationTypes = [
    AppStrings.overspeeding,
    AppStrings.illegalPacking,
    AppStrings.recklessDriving,
  ];

  Future<void> putViolation() async {
    showSuccessSnackbar(
        snackPosition: SnackPosition.TOP,
        message: 'calling put violatopn controller',
        color: red);
    contler.putViolations(
      creator: creatorController,
      fine: fineController,
      vehicleMake: vehicleMakeController,
      vehicleType: vehicleTypeController,
      vehicleYear: vehicleYearController,
      firstName: firstNameController,
      lastName: lastNameController,
      violation: violationController,
      violationCode: violationCodeController,
      violationLocation: locationController,
      vin: vinController,
      gender: genderController,
      plateNumber: plateNumberController,
    );
  }

  void onPageChanged(int value) {
    currentIndex.value = value;
    update();
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

  // navigation method
  void goBack() => routeService.goBack();
  void routeToForgotPassword() =>
      routeService.gotoRoute(AppLinks.forgotPassword);

  void routeToAppLanding() => routeService.gotoRoute(AppLinks.appLanding);

  @override
  void dispose() {
    super.dispose();
  }
}
