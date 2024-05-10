import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:slts_mobile_app/screens/models/violations_model.dart';
import 'package:slts_mobile_app/screens/user/gellery/new_offence/new_offence_controller.dart';
import 'package:slts_mobile_app/shared_widgets/app_btn_widget.dart';
import 'package:slts_mobile_app/shared_widgets/dropdown_widget.dart';
import 'package:slts_mobile_app/shared_widgets/text_input_widgets/normal_text_input_widget.dart';
// import 'package:slts_mobile_app/shared_widgets/text_widget.dart';
import 'package:slts_mobile_app/styles/styles.dart';
import 'package:slts_mobile_app/utils/constants.dart';

class NewOffenceScreen extends StatelessWidget {
  NewOffenceScreen({super.key});

  final controller = Get.put(NewOffenceController());
  final Violation? violation = Get.arguments;
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Obx(() {
        return CustomScrollView(
          slivers: <Widget>[
            appBar(context),
            SliverList(
              delegate: SliverChildListDelegate([
                plateNumber(),
                firstName(),
                lastName(),
                gender(context),
                fine(),
                violation1(),
                violationCode(),
                vehicleMake(),
                vehicleType(context),
                vehicleYear(),
                vin(),
                creator(),
                location(),
                violationType(context),
                additionalComment(),
                button(context),
              ]),
            ),
          ],
        );
      }),
    );
  }

  Widget plateNumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      child: NormalInputTextWidget(
        controller: controller.plateNumberController,
        title: AppStrings.plateNumber,
        hintText: 'KSF - 622AE',
        fontSize: 14.sp,
        filled: true,
        fillColor: grey3,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        readOnly: true,
      ),
    );
  }

  Widget location() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      child: NormalInputTextWidget(
        controller: controller.locationController,
        title: AppStrings.location,
        hintText: 'Ikeja, Lagos',
      ),
    );
  }

  Widget violationType(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      child: dropdownWidget1(
          context: context,
          title: AppStrings.violationType,
          hintText: 'Select options',
          values: controller.violationTypes,
          expectedVariable: 'field',
          onChange: (violation) {
            controller.onSelectViolationType(violation: violation);
          }),
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
        inputFormatters: [
          LengthLimitingTextInputFormatter(100),
        ],
      ),
    );
  }

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

  Widget violation1() {
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

  Widget button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 35),
      child: AppButton(
        text: AppStrings.upload,
        // isDisabled: true,
        onTap: () async{
          print('before function');
         await controller.putViolation();
          print('after function');
        },
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250.0,
      pinned: true,
      leading: GestureDetector(
        onTap: controller.goBack,
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: white,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        // title: Text('Goa', textScaleFactor: 1),
        background: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 1000),
              // height: height * 0.75.sp,
              child: PageView.builder(
                  controller: controller.controller,
                  itemCount: controller.images.length,
                  onPageChanged: (int index) => controller.onPageChanged(index),
                  itemBuilder: (BuildContext context, int index) {
                    final image =
                        controller.violation!.evidences![index].filePath;
                    return Image.network(
                      image,
                      // height: 218.h,
                      // width: width.w,
                      fit: BoxFit.fill,
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
                  controller.images.length,
                  (index) => buildDot(
                    context,
                    currentIndex: controller.currentIndex.value,
                    index: index,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
