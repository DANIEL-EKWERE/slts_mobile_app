import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:slts_mobile_app/screens/user/profile/profile_controller.dart.dart';
import 'package:slts_mobile_app/shared_widgets/app_btn_widget.dart';
import 'package:slts_mobile_app/shared_widgets/generic_widgts.dart';
import 'package:slts_mobile_app/shared_widgets/text_widget.dart';
import 'package:slts_mobile_app/styles/asset_manager.dart';
import 'package:slts_mobile_app/styles/styles.dart';
import 'package:slts_mobile_app/utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final controller = Get.put<ProfileController>(ProfileController());

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate:
                MySliverAppBar(expandedHeight: 150.0, controller: controller),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(
                height: 220,
              ),
              contactInformation(),
              activityLog(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: AppButton(
                  text: AppStrings.logOut,
                  color: red,
                  // isDisabled: true,
                  onTap: () {},
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget contactInformation() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget(
              text: AppStrings.contactInformation,
              style: getBoldStyle(color: greyShade1)),
          SizedBox(
            height: 12.sp,
          ),
          Row(
            children: [
              SvgPicture.asset(ImageAssets.envelope),
              SizedBox(
                width: 10.sp,
              ),
              textWidget(
                  text: '${controller.user.value.email}',
                  style: getRegularStyle()),
            ],
          ),
          SizedBox(
            height: 12.sp,
          ),
          Row(
            children: [
              SvgPicture.asset(ImageAssets.phone),
              SizedBox(
                width: 10.sp,
              ),
              textWidget(
                  text: '${controller.user.value.phoneNumber ?? 'NAN'}',
                  style: getRegularStyle()),
            ],
          ),
        ],
      ),
    );
  }

  Widget activityLog() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      padding: const EdgeInsets.all(15),
      constraints: BoxConstraints(
        maxHeight: 160.sp,
      ),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget(
            text: AppStrings.activityLog,
            style: getBoldStyle(color: greyShade1),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textWidget(
                        text: "11:40 AM",
                        style:
                            getMediumStyle(color: greyShade, fontSize: 11.sp),
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      textWidget(
                          text: 'Captured plate ABC-123',
                          style: getRegularStyle(fontSize: 12.sp)),
                    ],
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textWidget(
                        text: "11:40 AM",
                        style:
                            getMediumStyle(color: greyShade, fontSize: 11.sp),
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      textWidget(
                          text: 'Edited summary for capture XYZ-789',
                          style: getRegularStyle(fontSize: 12.sp)),
                    ],
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textWidget(
                        text: "11:40 AM",
                        style:
                            getMediumStyle(color: greyShade, fontSize: 11.sp),
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      textWidget(
                          text: 'Edited summary for capture XYZ-789',
                          style: getRegularStyle(fontSize: 12.sp)),
                    ],
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textWidget(
                        text: "11:40 AM",
                        style:
                            getMediumStyle(color: greyShade, fontSize: 11.sp),
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      textWidget(
                          text: 'Edited summary for capture XYZ-789',
                          style: getRegularStyle(fontSize: 12.sp)),
                    ],
                  ),
                  SizedBox(
                    height: 12.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final ProfileController controller;

  MySliverAppBar({required this.expandedHeight, required this.controller});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SafeArea(
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          // Center(
          //   child: Opacity(
          //     opacity: shrinkOffset / expandedHeight,
          //     child: const Text(
          //       'Oyindamilola Hamilton',
          //       style: TextStyle(
          //         color: Colors.black,
          //         fontWeight: FontWeight.w700,
          //         fontSize: 23,
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            top: expandedHeight / 4 - shrinkOffset,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: (1 - shrinkOffset / expandedHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  profileAvatar(
                    // imgUrl: ,
                    boxHeight: expandedHeight,
                    // width: MediaQuery.of(context).size.width / 2,
                  ),
                  SizedBox(
                    height: 24.sp,
                  ),
                  textWidget(
                    text:
                        "${controller.user.value.firstname} ${controller.user.value.lastname}",
                    style: getBoldStyle(fontSize: 22.sp),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50.sp,
                        child: textWidget(
                          text: "${AppStrings.agentId}:",
                          style:
                              getMediumStyle(color: greyShade, fontSize: 11.sp),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      SizedBox(
                        width: 100.sp,
                        child: textWidget(
                          text: "${controller.user.value.tenant!.id}",
                          style: getRegularStyle(fontSize: 16.sp),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50.sp,
                        child: textWidget(
                          text: "${AppStrings.role}:",
                          style:
                              getMediumStyle(color: greyShade, fontSize: 11.sp),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      SizedBox(
                        width: 100.sp,
                        child: textWidget(
                          text: "${controller.user.value.role!.name}",
                          style: getRegularStyle(fontSize: 16.sp),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50.sp,
                        child: textWidget(
                          text: "${AppStrings.location}:",
                          style:
                              getMediumStyle(color: greyShade, fontSize: 11.sp),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      SizedBox(
                        width: 100.sp,
                        child: textWidget(
                          text: "${controller.user.value.tenant!.address}",
                          // textOverflow: TextOverflow.visible,
                          style: getRegularStyle(fontSize: 16.sp),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
