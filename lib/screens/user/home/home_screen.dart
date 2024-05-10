import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:slts_mobile_app/screens/models/violations_model.dart';
import 'package:slts_mobile_app/screens/user/home/home_controller.dart';
import 'package:slts_mobile_app/screens/user/profile/profile_controller.dart.dart';
// import 'package:slts_mobile_app/services/device_service.dart';
import 'package:slts_mobile_app/shared_widgets/generic_widgts.dart';
import 'package:slts_mobile_app/shared_widgets/rounded_appbar.dart';
import 'package:slts_mobile_app/shared_widgets/text_widget.dart';
import 'package:slts_mobile_app/styles/asset_manager.dart';
import 'package:slts_mobile_app/styles/styles.dart';
import 'package:slts_mobile_app/utils/constants.dart';
import 'package:slts_mobile_app/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put(HomeController());
  final userController = Get.put(ProfileController());
  final contler = Get.put(ApiService());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //  double height = MediaQuery.of(context).size.height;

    return Obx(() {
      return Scaffold(
        appBar: RoundedAppBar(
          name: userController.user.value.lastname,
          lastLogin: controller.loginTime!.value,
          location: controller.currentAddress?.value ?? 'unknown',
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: 24.sp,
            right: 24.sp,
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 24.sp,
                    ),
                    activityCards(),
                    SizedBox(
                      height: 24.sp,
                    ),
                    quickActionsTitle(),
                    // SizedBox(
                    //   height: 8.sp,
                    // ),
                    actionButtons(context: context),
                    SizedBox(
                      height: 24.sp,
                    ),
                    recentCaptures(),

                    SizedBox(
                      height: 300.sp,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          final controller = contler.violationLists[index];
                          return galleryCard(
                              width: width,
                              plateNumber: controller.plateNumber,
                              image: controller.evidences![0].filePath,
                              createdAt: (controller.createdAt!.toString())
                                  .substring(0, 9),
                                  violation: controller);
                        },
                        separatorBuilder: (context, _) => SizedBox(
                          width: 8.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              controller.isLoading.isTrue
                  ? Stack(
                      children: [
                        const Opacity(
                          opacity: 0.5,
                          child: ModalBarrier(
                              dismissible: false, color: Colors.white60),
                        ),
                        Center(
                          child: Center(
                            child: centerLoadingIcon(
                                strokeWidth: 10.sp,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    primaryColor)),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: SizedBox(
            height: 45.sp,
            width: 45.sp,
            child: FloatingActionButton(
              heroTag: 'home',
              shape: RoundedRectangleBorder(
                  // side: BorderSide(),
                  borderRadius: BorderRadius.circular(100)),
              splashColor: Colors.green[200],
              backgroundColor: primaryColor,
              onPressed: () {},
              child: SvgPicture.asset(
                ImageAssets.camera,
                // ignore: deprecated_member_use
                color: white,
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget galleryCard(
      {required double width,
      required String image,
      required String plateNumber,
      required String createdAt,
     required Violation violation}) {
    return SizedBox(
      width: 210.sp,
      height: 200.sp,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6.r),
              topRight: Radius.circular(6.r),
            ),
            child: Image.network(
              image,
              fit: BoxFit.fitWidth,
              height: 150.sp,
              width: width.sp,
            ),
          ),
          Container(
            width: width,
            height: 50.sp,
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(6.r),
                  bottomRight: Radius.circular(6.r),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidget(
                            text: plateNumber,
                            style:
                                getMediumStyle(fontSize: 12.sp, color: white)),
                        Row(
                          children: [
                            textWidget(
                                text: createdAt,
                                style: getMediumStyle(
                                    fontSize: 12.sp, color: white)),
                            SizedBox(
                              width: 10.sp,
                            ),
                            SizedBox(
                              width: 4.sp,
                              height: 4.sp,
                              child: const DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: white, shape: BoxShape.circle)),
                            ),
                            SizedBox(
                              width: 10.sp,
                            ),
                            textWidget(
                                text: '11:56 AM',
                                style: getMediumStyle(
                                    fontSize: 12.sp, color: white)),
                          ],
                        ),
                      ],
                    ),
                    PopupMenuButton<String>(
                      color: white,
                      padding: const EdgeInsets.only(bottom: 2),
                      //  iconColor: white,
                      iconSize: 18.sp,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.r),
                        ),
                      ),
                      onSelected:  (String result) {
                        controller.onSelected(result, violation);
                      },
                      itemBuilder: (BuildContext context) {
                        return controller.galleryOption.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(
                              choice,
                              style: TextStyle(
                                  color: choice == "Delete" ? red : null),
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Row activityCards() {
    return Row(
      children: [
        homeCard(
          iconUrl: ImageAssets.camera,
          title: AppStrings.totalCaptures,
          count: 250.toString(),
        ),
        SizedBox(
          width: 8.sp,
        ),
        homeCard(
          iconUrl: ImageAssets.hourGlass,
          title: AppStrings.pendingUploads,
          count: 250.toString(),
        ),
      ],
    );
  }

  Widget quickActionsTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          textWidget(
            text: AppStrings.quickActions,
            textOverflow: TextOverflow.visible,
            // textAlign: TextAlign.center,
            style: getBoldStyle(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Widget recentCaptures() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          textWidget(
            text: AppStrings.recentCaptures,
            textOverflow: TextOverflow.visible,
            // textAlign: TextAlign.center,
            style: getBoldStyle(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Row actionButtons({required BuildContext context}) {
    return Row(
      children: [
        actionsCard(
          iconUrl: ImageAssets.note,
          title: AppStrings.status,
          containerColor: lightRed,
          // onTap: () => controller.obtainImage(isNewOffence: false)),
          onTap: () {
            showDialog(
                context: context,
                builder: (_) {
                  return SimpleDialog(
                    title: const Text('Select options'),
                    children: <Widget>[
                      SimpleDialogOption(
                        onPressed: () =>
                            controller.obtainImage(isNewOffence: false),
                        child: Row(
                          children: [
                            const Icon(Iconsax.camera, color: grey4),
                            SizedBox(
                              width: 20.w,
                            ),
                            const Text('Camera '),
                          ],
                        ),
                      ),
                      const Divider(
                        color: grey4,
                      ),
                      SimpleDialogOption(
                        onPressed: () =>
                            controller.routeToManualInput(isStatusCheck: true),
                        child: Row(
                          children: [
                            const Icon(
                              Iconsax.magicpen,
                              color: grey4,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            const Text('Manual Input '),
                          ],
                        ),
                      ),
                      const Divider(
                        color: grey4,
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          Get.back();
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Iconsax.gallery_remove,
                              color: grey4,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            const Text('Cancel'),
                          ],
                        ),
                      ),
                    ],
                  );
                });
          },
        ),
        SizedBox(
          width: 8.sp,
        ),
        // Capture
        actionsCard(
            iconUrl: ImageAssets.camera,
            title: AppStrings.capture,
            containerColor: primaryColorLight,
            // onTap: ()=> controller.obtainImage(isNewOffence: true)),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return SimpleDialog(
                      title: const Text('Select options'),
                      children: <Widget>[
                        SimpleDialogOption(
                          onPressed: () =>
                              controller.obtainImage(isNewOffence: true),
                          child: Row(
                            children: [
                              const Icon(Iconsax.camera, color: grey4),
                              SizedBox(
                                width: 20.w,
                              ),
                              const Text('Camera '),
                            ],
                          ),
                        ),
                        const Divider(
                          color: grey4,
                        ),
                        SimpleDialogOption(
                          onPressed: controller.routeToManualInput,
                          child: Row(
                            children: [
                              Icon(
                                Iconsax.magicpen,
                                color: grey4,
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              const Text('Manual Input '),
                            ],
                          ),
                        ),
                        const Divider(
                          color: grey4,
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Get.back();
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Iconsax.gallery_remove,
                                color: grey4,
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              const Text('Cancel'),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            }),
      ],
    );
  }

  Widget homeCard({
    required String iconUrl,
    required String title,
    required String count,
  }) {
    return Expanded(
      child: Container(
        // height: 150.sp,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.all(
            Radius.circular(8.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(iconUrl),
            SizedBox(
              height: 10.sp,
            ),
            textWidget(
              text: title,
              textOverflow: TextOverflow.visible,
              // textAlign: TextAlign.center,
              style: getBoldStyle(fontSize: 14.sp),
            ),
            SizedBox(
              height: 10.sp,
            ),
            textWidget(
              text: count,
              textOverflow: TextOverflow.visible,
              // textAlign: TextAlign.start,
              style: getBoldStyle(fontSize: 24.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget actionsCard(
      {required String iconUrl,
      required String title,
      required Color containerColor,
      required void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 52.sp,
        width: 48.sp,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          color: containerColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconUrl,
                height: 20.sp,
              ),
              SizedBox(
                height: 2.sp,
              ),
              textWidget(
                text: title,
                textOverflow: TextOverflow.visible,
                // textAlign: TextAlign.center,
                style: getLightStyle(
                  fontSize: 8.sp,
                ).copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
