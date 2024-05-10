// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:slts_mobile_app/screens/models/violations_model.dart';
// import 'package:slts_mobile_app/screens/user/gellery/new_offence/new_offence_controller.dart';
import 'package:slts_mobile_app/screens/user/home/capture_manual_input/manual_input_controller.dart';
import 'package:slts_mobile_app/services/api_service.dart';
import 'package:slts_mobile_app/services/user_service.dart';
import 'package:slts_mobile_app/shared_widgets/app_btn_widget.dart';
import 'package:slts_mobile_app/shared_widgets/dropdown_widget.dart';
import 'package:slts_mobile_app/shared_widgets/generic_widgts.dart';
import 'package:slts_mobile_app/shared_widgets/text_input_widgets/normal_text_input_widget.dart';
// import 'package:slts_mobile_app/shared_widgets/text_widget.dart';
import 'package:slts_mobile_app/styles/styles.dart';
import 'package:slts_mobile_app/utils/constants.dart';

class ManualInputScreen extends StatelessWidget {
  ManualInputScreen({super.key});

  final controller = Get.put(ManualInputController());
  final contler = Get.put(ApiService());
  final UserService userService = UserService();

  // Future<String> getUserData1() async {
  //   try {
  //     UserModel? user = await userService.getUserData();
  //     if (user != null) {
  //       print('user data retrieved succeddfully');
  //       print('user ${user.tenant!.id}');
  //       return 'user.tenant!.id';
  //       print('user ${user.id}');
  //     } else {
  //       print('no user found');
  //       return '';
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   return '1';
  // }

//   /data/user/0/com.example.slts_mobile_app/cache/abbb525e-60df-4252-9831-6b5725e56b8a6929942484705467457.jpg, /data/user/0/com.example.slts_mobile_app/cache/50032e3c-f83d-41b3-be3e-a0c1bb113db58106175647163920209.jpg
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    // creator: creatorController.text,             marked
    // // ignore: invalid_use_of_protected_member
    // evidence: evidences!.value,                  marked
    // vin: vinController.text,                     marked
    // violationCode: violationCodeController.text,
    // violation: violationController.text,
    // fine: fineController.text,
    // vehicleMake: vehicleMakeController.text,
    // vehicleType: vehicleTypeController.text,
    // vehicleYear: vehicleYearController.text,
    // firstName: firstNameController.text,
    // lastName: lastNameController.text,
    // gender: genderController.text,
    return Scaffold(
      body: Obx(
        () => CustomScrollView(
          slivers: <Widget>[
            appBar(context),
            SliverList(
              delegate: SliverChildListDelegate([
                plateNumber(),
                Visibility(
                  visible: !controller.isStatusCheck.value,
                  child: Column(
                    children: [
                      // adding input fields
                      firstName(),
                      lastName(),
                      gender(context),
                      fine(),
                      violation(),
                      violationCode(),
                      vehicleMake(),
                      vehicleType(context),
                      vehicleYear(),
                      vin(),
                      creator(),
                      // endeing here
                      location(),
                      violationType(context),

                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // controller.evidences!.length >= 3
                      //     ? AbsorbPointer(
                      //         child: AppButton(
                      //           text: controller.evidences!.isEmpty
                      //               ? '${AppStrings.addPhotos} ${controller.evidences!.length}'
                      //               : controller.evidences != null &&
                      //                       controller.evidences!.length < 3
                      //                   ? '${AppStrings.addMorePhotos} ${controller.evidences!.length}' // TODO: ehhehhh
                      //                   : 'Completed ${controller.evidences!.length}',
                      //           width: 130.sp,
                      //           height: 40.sp,
                      //           fontSize: 14.sp,
                      //           onTap: () => controller.obtainImage2(),
                      //         ),
                      //       )
                      //     : AppButton(
                      //         text: controller.evidences!.isEmpty
                      //             ? '${AppStrings.addPhotos} ${controller.evidences!.length}'
                      //             : controller.evidences != null &&
                      //                     controller.evidences!.length < 3
                      //                 ? '${AppStrings.addMorePhotos} ${controller.evidences!.length}' // TODO: ehhehhh
                      //                 : 'Completed',
                      //         width: 130.sp,
                      //         height: 40.sp,
                      //         fontSize: 14.sp,
                      //         onTap: () => controller.obtainImage2(),
                      //       ),
                      additionalComment(),
                    ],
                  ),
                ),
                controller.isStatusCheck.value
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      )
                    : const SizedBox.shrink(),
                button(context),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget plateNumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      child: NormalInputTextWidget(
        title: AppStrings.plateNumber,
        hintText: 'KSF - 622AE',
        fontSize: 14.sp,
        controller: controller.plateNumberController,
        // filled: true,
        // fillColor: grey3,
        // border: const OutlineInputBorder(borderSide: BorderSide.none),
        // enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        // focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        // readOnly: true,
      ),
    );
  }

  Widget location() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      child: NormalInputTextWidget(
        title: AppStrings.location,
        hintText: 'Ikeja, Lagos',
        controller: controller.locationController,
      ),
    );
  }
// TODO: CREATING A NEW WIDGET FOR THE VARIOUS INPUT FIELDS.

  Widget creator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      child: NormalInputTextWidget(
        title: AppStrings.creator,
        hintText: 'creator',
        controller: controller.creatorController,
      ),
    );
  }

  Widget vin() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      child: NormalInputTextWidget(
        title: AppStrings.vin,
        hintText: 'vin',
        controller: controller.vinController,
      ),
    );
  }

  Widget violationCode() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      child: NormalInputTextWidget(
        title: AppStrings.violatinCode,
        hintText: 'violation Code',
        controller: controller.violationCodeController,
      ),
    );
  }

  Widget fine() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      child: NormalInputTextWidget(
        title: AppStrings.fine,
        hintText: 'Fine',
        controller: controller.fineController,
      ),
    );
  }

  Widget violation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      child: NormalInputTextWidget(
        title: AppStrings.violation,
        hintText: 'violation',
        controller: controller.violationController,
      ),
    );
  }

  Widget vehicleMake() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      child: NormalInputTextWidget(
        title: AppStrings.vehicleMake,
        hintText: 'vehicle Make',
        controller: controller.vehicleMakeController,
      ),
    );
  }

  Widget vehicleType(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      child: dropdownWidget1(
          context: context,
          title: AppStrings.vehicleType,
          hintText: 'Select options',
          values: controller.vehicleType,
          expectedVariable: 'field',
          onChange: (vehicle) =>
              controller.onSelectVehicleType(vehicle: vehicle)),
    );
  }

  Widget vehicleYear() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      child: NormalInputTextWidget(
        title: AppStrings.vehicleYear,
        hintText: 'vehicle Year',
        controller: controller.vehicleYearController,
      ),
    );
  }

  Widget firstName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      child: NormalInputTextWidget(
        title: AppStrings.firstName,
        hintText: 'First Name',
        controller: controller.firstNameController,
      ),
    );
  }

  Widget lastName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      child: NormalInputTextWidget(
        title: AppStrings.lastName,
        hintText: 'Last Name',
        controller: controller.lastNameController,
      ),
    );
  }

  Widget gender(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      child: dropdownWidget1(
          context: context,
          title: AppStrings.gender,
          hintText: 'Select options',
          values: controller.gender,
          expectedVariable: 'field',
          onChange: (gender) => controller.onSelectGenderType(gender: gender)),
    );
  }

// TODO: CREATING A NEW WIDGET FOR THE VARIOUS INPUT FIELDS.
  Widget violationType(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      child: dropdownWidget1(
          context: context,
          title: AppStrings.violationType,
          hintText: 'Select options',
          values: controller.violationTypes,
          expectedVariable: 'field',
          onChange: (violation) =>
              controller.onSelectViolationType(violation: violation)),
    );
  }

  Widget additionalComment() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      child: NormalInputTextWidget(
        title: AppStrings.additionalComment,
        hintText: 'write something...',
        fontSize: 14.sp,
        maxLines: 3,
        controller: controller.violationCommentController,
        inputFormatters: [
          LengthLimitingTextInputFormatter(100),
        ],
      ),
    );
  }

  Widget button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 35),
      child: AppButton(
        text: controller.isStatusCheck.value
            ? AppStrings.status
            : AppStrings.upload,
        // isDisabled: true,
        textColor: white,
        // onTap: controller.routeToSummary,
        onTap: () async {
          // if (controller.firstNameController.text.isEmpty) {
          //   Get.snackbar('Error', 'Enter First Name',
          //       backgroundColor: Colors.red, colorText: Colors.white);
          // } else if (controller.lastNameController.text.isEmpty) {
          //   Get.snackbar('Error', 'Enter last Name',
          //       backgroundColor: Colors.red, colorText: Colors.white);
          // } else if (controller.plateNumberController.text.isEmpty) {
          //   Get.snackbar('Error', 'Enter Plate Number',
          //       backgroundColor: Colors.red, colorText: Colors.white);
          // } else if (controller.gender.isEmpty) {
          //   Get.snackbar('Error', 'Select Gender',
          //       backgroundColor: Colors.red, colorText: Colors.white);
          // } else if (controller.fineController.text.isEmpty) {
          //   Get.snackbar('Error', 'Enter Fine',
          //       backgroundColor: Colors.red, colorText: Colors.white);
          // } else if (controller.violationController.text.isEmpty) {
          //   Get.snackbar('Error', 'Enter violation',
          //       backgroundColor: Colors.red, colorText: Colors.white);
          // } else if (controller.violationCodeController.text.isEmpty) {
          //   Get.snackbar('Error', 'Enter violation Code',
          //       backgroundColor: Colors.red, colorText: Colors.white);
          // } else if (controller.vehicleMakeController.text.isEmpty) {
          //   Get.snackbar('Error', 'Enter Vehicle Make',
          //       backgroundColor: Colors.red, colorText: Colors.white);
          // } else if (controller.vehicleType.isEmpty) {
          //   Get.snackbar('Error', 'Enter Vehicle Type',
          //       backgroundColor: Colors.red, colorText: Colors.white);
          // } else if (controller.vehicleYearController.text.isEmpty) {
          //   Get.snackbar('Error', 'Enter Vehicle Year',
          //       backgroundColor: Colors.red, colorText: Colors.white);
          // } else if (controller.vinController.text.isEmpty) {
          //   Get.snackbar('Error', 'Enter Vin',
          //       backgroundColor: Colors.red, colorText: Colors.white);
          // } else if (controller.creatorController.text.isEmpty) {
          //   Get.snackbar('Error', 'Enter creator',
          //       backgroundColor: Colors.red, colorText: Colors.white);
          // } else if (controller.locationController.text.isEmpty) {
          //   Get.snackbar('Error', 'Enter Location',
          //       backgroundColor: Colors.red, colorText: Colors.white);
          // } else if (controller.violationTypes.isEmpty) {
          //   Get.snackbar('Error', 'Enter Violation Type',
          //       backgroundColor: Colors.red, colorText: Colors.white);
          // } else if (controller.violationCommentController.text.isEmpty) {
          //   Get.snackbar('Error', 'Enter violation Comments',
          //       backgroundColor: Colors.red, colorText: Colors.white);
          // } else {
          //   Get.snackbar('Getting reading!!!', 'Sending Violations',
          //       colorText: Colors.white, backgroundColor: Colors.green);
          print('before function');
          controller.addViolation();
          print('after function');
          // var tenant = await getUserData1();
          // print('${userService.getUserData()} calling models');

          // }
        },
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Obx(() => SliverAppBar(
          expandedHeight: controller.isStatusCheck.value ? 100.sp : 250.0.sp,
          backgroundColor: backgroundColor,
          pinned: true,
          leading: GestureDetector(
            onTap: controller.goBack,
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: grey5,
            ),
          ),
          flexibleSpace: controller.isStatusCheck.value
              ? null
              : FlexibleSpaceBar(
                  // title: Text('Goa', textScaleFactor: 1),
                  background: Stack(
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 1000),
                        // height: height * 0.75.sp,
                        child: PageView.builder(
                            controller: controller.controller,
                            itemCount: controller.imagePath?.length,
                            onPageChanged: (int index) =>
                                controller.onPageChanged(index),
                            itemBuilder: (BuildContext context, int index) {
                              final image = controller.imagePath?[index];
                              return imageWidget(
                                localImagePath: image,
                              );
                            }),
                      ),
                      Positioned(
                        bottom: 16,
                        right: 0,
                        left: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            controller.imagePath!.length,
                            (index) => buildDot(
                              context,
                              currentIndex: controller.currentIndex.value,
                              index: index,
                            ),
                          ),
                        ),
                      ),
                      controller.imagePath!.length >= 3
                          ? const SizedBox()
                          : Positioned(
                              right: 24,
                              bottom: 10,
                              child: AppButton(
                                text: controller.imagePath!.isEmpty
                                    ? AppStrings.addPhotos
                                    : controller.imagePath != null &&
                                            controller.imagePath!.length <= 3
                                        ? AppStrings.addMorePhotos
                                        : null,
                                width: 130.sp,
                                height: 40.sp,
                                fontSize: 14.sp,
                                onTap: () => controller.obtainImage(),
                              ),
                            ),
                    ],
                  ),
                ),
        ));
  }

  buildDot(
    BuildContext context, {
    required int index,
    required int currentIndex,
    double? width,
  }) {
    return Container(
      height: 5.h,
      width: currentIndex == index ? 8.w : 8.0.w,
      margin: const EdgeInsets.only(right: 2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentIndex == index ? lightBrown : white,
      ),
    );
  }
}
