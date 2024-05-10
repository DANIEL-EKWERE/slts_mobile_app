import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:slts_mobile_app/screens/models/violations_model.dart';
// import 'package:slts_mobile_app/screens/user/gellery/gallery_controller.dart';
import 'package:slts_mobile_app/screens/user/gellery/summary/summary_controller.dart';
// import 'package:slts_mobile_app/shared_widgets/rounded_appbar.dart';
// import 'package:slts_mobile_app/shared_widgets/text_input_widgets/normal_text_input_widget.dart';
import 'package:slts_mobile_app/shared_widgets/text_widget.dart';
// import 'package:slts_mobile_app/styles/asset_manager.dart';
import 'package:slts_mobile_app/styles/styles.dart';
import 'package:slts_mobile_app/utils/constants.dart';

class SummaryScreen extends StatelessWidget {
  //final Violation? violation;
  SummaryScreen({super.key});

  final controller = Get.put(SummaryController());
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
            dateAndStatus(),
            licensePlateDetails(),
            agentInformation(),
            additionalSummary(),
          ],
        );
      }),
    );
  }

  Widget dateAndStatus() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((_, int index) {
        return Padding(
          padding: EdgeInsets.only(
              left: 20.sp, right: 20.sp, top: 15.sp, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textWidget(
                  text: (violation!.createdAt.toString().substring(0, 9)),
                  style: getMediumStyle(color: grey1)),
              textWidget(
                  text: AppStrings.uploaded,
                  style: getMediumStyle(color: green).copyWith(
                    fontFamily: 'italic',
                  )),
            ],
          ),
        );
      }, childCount: 1),
    );
  }

  Widget licensePlateDetails() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, int index) {
          return Container(
              margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
              width: 100,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(8.r))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                      text: AppStrings.licensePlateDetails,
                      style: getMediumStyle(color: grey1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          // color: Colors.blueAccent,
                          width: 90.sp,
                          child: textWidget(
                            text: "${AppStrings.plateNumber}:",
                            style: getLightStyle(fontSize: 11.sp)
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          // color: Colors.blueAccent,
                          width: 160.sp,
                          child: textWidget(
                            text: violation!.plateNumber,
                            style: getRegularStyle(),
                          ),
                        ),
                        // Spacer(),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        // color: Colors.blueAccent,
                        width: 90.sp,
                        child: textWidget(
                          text: "${AppStrings.location}:",
                          style: getLightStyle(fontSize: 11.sp)
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        // color: Colors.blueAccent,
                        width: 160.sp,
                        child: textWidget(
                          text: violation!.violationLocation,
                          textOverflow: TextOverflow.visible,
                          style: getRegularStyle(),
                        ),
                      ),
                      // Spacer(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          // color: Colors.blueAccent,
                          width: 90.sp,
                          child: textWidget(
                            text: "${AppStrings.violationStatus}:",
                            style: getLightStyle(fontSize: 11.sp)
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          // color: Colors.blueAccent,
                          width: 160.sp,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              textWidget(
                                text: violation!.violation,
                                textOverflow: TextOverflow.visible,
                                style: getRegularStyle(),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 13.sp, vertical: 3),
                                color: redAccent,
                                child: textWidget(
                                  text: 'Unpaid',
                                  textOverflow: TextOverflow.visible,
                                  style: getMediumStyle(
                                      fontSize: 12.sp, color: red),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Spacer(),
                      ],
                    ),
                  ),
                ],
              ));
        },
        childCount: 1,
      ),
    );
  }

  Widget agentInformation() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, int index) {
          return Container(
              margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
              width: 100,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(8.r))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                      text: AppStrings.agentInformation,
                      style: getMediumStyle(color: grey1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          // color: Colors.blueAccent,
                          width: 90.sp,
                          child: textWidget(
                            text: "${AppStrings.agentId}:",
                            style: getLightStyle(fontSize: 11.sp)
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          // color: Colors.blueAccent,
                          width: 160.sp,
                          child: textWidget(
                            text: violation!.tenantId.toString(),
                            style: getRegularStyle(),
                          ),
                        ),
                        // Spacer(),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        // color: Colors.blueAccent,
                        width: 90.sp,
                        child: textWidget(
                          text: "${AppStrings.agentName}:",
                          style: getLightStyle(fontSize: 11.sp)
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        // color: Colors.blueAccent,
                        width: 160.sp,
                        child: textWidget(
                          text:
                              "${violation!.creator!.firstname} ${violation!.creator!.lastname}",
                          textOverflow: TextOverflow.visible,
                          style: getRegularStyle(),
                        ),
                      ),
                      // Spacer(),
                    ],
                  ),
                ],
              ));
        },
        childCount: 1,
      ),
    );
  }

  Widget additionalSummary() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, int index) {
          return Container(
              margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
              width: 100,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(8.r))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                      text: AppStrings.additionalSummary,
                      style: getMediumStyle(color: grey1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: textWidget(
                      text:
                          """Captured on a busy street during rush hour. The vehicle, a red sedan with license plate ABC-123, was observed making an illegal U-turn at the intersection. The capture includes multiple angles to ensure plate readability. The weather conditions were clear, aiding in a clear image.""",
                      // textAlign: Text,
                      textOverflow: TextOverflow.visible,
                      style: getRegularStyle(fontSize: 12.sp),
                    ),
                  ),
                ],
              ));
        },
        childCount: 1,
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
      actions: [
        PopupMenuButton<String>(
          color: white,
          padding: const EdgeInsets.only(bottom: 2),
          // iconColor: white,
          iconSize: 18.sp,
          position: PopupMenuPosition.under,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.r),
            ),
          ),
          onSelected: (String result,) {
            controller.onSelected(result, violation!);
          },
          itemBuilder: (BuildContext context) {
            return controller.galleryOption.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(
                  choice,
                  style: TextStyle(color: choice == "Delete" ? red : null),
                ),
              );
            }).toList();
          },
        ),
      ],
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
                    final image = violation!.evidences![index].filePath;
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
