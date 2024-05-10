// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:slts_mobile_app/screens/models/violations_model.dart';
import 'package:slts_mobile_app/screens/user/gellery/gallery_controller.dart';
import 'package:slts_mobile_app/services/api_service.dart';
// import 'package:slts_mobile_app/shared_widgets/rounded_appbar.dart';
import 'package:slts_mobile_app/shared_widgets/text_input_widgets/normal_text_input_widget.dart';
import 'package:slts_mobile_app/shared_widgets/text_widget.dart';
import 'package:slts_mobile_app/styles/asset_manager.dart';
import 'package:slts_mobile_app/styles/styles.dart';
import 'package:slts_mobile_app/utils/constants.dart';

class GalleryScreen extends StatelessWidget {
  GalleryScreen({super.key});

  final controller = Get.put(GalleryController());
  final contler = Get.put(ApiService());
  final ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(),
      body: body(width, height),
    );
  }

  Widget body(double width, double height) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(
          left: 24.sp,
          right: 24.sp,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NormalInputTextWidget(
              title: '',
              filled: true,
              fillColor: white,
              hintStyle: getRegularStyle(color: cyan),
              hintText: AppStrings.search,
              prefixIcon: Transform.scale(
                scale: 0.3,
                child: SvgPicture.asset(
                  ImageAssets.search,
                  height: 10.sp,
                  width: 10.sp,
                ),
              ),
              onChanged: (value) {},
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: primaryColorLight,
                  width: 1.0.w,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0.r),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(
                    text: '${AppStrings.sort}:',
                    style: getRegularStyle(),
                  ),
                  SizedBox(
                    width: 7.sp,
                  ),
                  Expanded(
                    child: filterCard(
                      title: AppStrings.mostRecent,
                      icon: PopupMenuButton<String>(
                        color: white,
                        iconSize: 18.sp,
                        position: PopupMenuPosition.under,
                        surfaceTintColor: white,
                        // constraints: BoxConstraints.tightFor(height: 120.sp,
                        // width: 138.sp),
                        onSelected: (result) {
                          if (result == 'Location') {
                            print("location called");
                          } else if (result == 'Status') {
                            print('status called');
                          } else {
                            print("License plate called");
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return controller.searchQueries.map((String choice) {
                            return PopupMenuItem<String>(
                              // height: 20,
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 15.sp,
                          color: black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.sp,
                  ),
                  Expanded(
                    child: filterCard(
                      title: AppStrings.filter,
                      icon: SvgPicture.asset(
                        ImageAssets.filter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: !controller.isGridView.value
                    ? Column(
                        children: [
                          // ignore: unused_local_variable
                          for (var i in List.generate(10, (index) => index))
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              // height: 100,
                              width: width.sp,
                              color: primaryColorLight,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6.r),
                                      topRight: Radius.circular(6.r),
                                    ),
                                    child: Image.asset(
                                      ImageAssets.platenumber,
                                      fit: BoxFit.fitWidth,
                                      height: 150.sp,
                                      width: width.sp,
                                    ),
                                  ),
                                  Container(
                                    width: width,
                                    height: 50.sp,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 0),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: black,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(6.r),
                                          bottomRight: Radius.circular(6.r),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, bottom: 8, left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  textWidget(
                                                      text: 'KSF - 622 AE---',
                                                      style: getMediumStyle(
                                                          fontSize: 12.sp,
                                                          color: white)),
                                                  Row(
                                                    children: [
                                                      textWidget(
                                                          text: 'Today',
                                                          style: getMediumStyle(
                                                              fontSize: 12.sp,
                                                              color: white)),
                                                      SizedBox(
                                                        width: 10.sp,
                                                      ),
                                                      SizedBox(
                                                        width: 4.sp,
                                                        height: 4.sp,
                                                        child: const DecoratedBox(
                                                            decoration:
                                                                BoxDecoration(
                                                                    color:
                                                                        white,
                                                                    shape: BoxShape
                                                                        .circle)),
                                                      ),
                                                      SizedBox(
                                                        width: 10.sp,
                                                      ),
                                                      textWidget(
                                                          text: '11:56 AM',
                                                          style: getMediumStyle(
                                                              fontSize: 12.sp,
                                                              color: white)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      )
                    : GridView.builder(
                        // scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // number of items in each row
                          mainAxisSpacing: 8.0, // spacing between rows
                          crossAxisSpacing: 8.0, // spacing between columns
                        ),
                        padding: const EdgeInsets.all(
                            8.0), // padding around the grid
                        itemCount: contler
                            .violationLists.length, // total number of items
                        itemBuilder: (context, index) {
                          final violation = contler.violationLists[index];
                          // print(contler
                          //     .violationList[index].evidences[0].filePath);
                          // return ElevatedButton(
                          //     onPressed: () {
                          //       contler.getViolations();
                          //     },
                          //     child: Text(
                          //         '${contler.violationList.value.length}'));
                          // return gridCard(
                          //   width,
                          //   //   boxWidth: 160.sp,
                          //   // boxHeight: 175.sp,
                          //   // imageHeight: 120.sp
                          // );b
                          return gridCard(
                              width: width,
                              plateNumber: violation.plateNumber,
                              image: violation.evidences![0].filePath,
                              createdAt: (violation.createdAt!.toString())
                                  .substring(0, 9),
                              violation: violation);
                        },
                      ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget filterCard(
      {required String title, required Widget icon, double? rightPadding}) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: 13, right: rightPadding ?? 13),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2.r)),
        border: Border.all(
          color: primaryColorLight,
          width: 1.0.w,
        ),
        color: white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: textWidget(text: title, style: getRegularStyle())),
          // const SizedBox(
          //   width: 8,
          // ),
          icon,
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      leadingWidth: 120.sp,
      leading: Padding(
        padding: const EdgeInsets.only(left: 24, top: 15),
        child: textWidget(
            text: AppStrings.gallery,
            textOverflow: TextOverflow.visible,
            style: getBoldStyle(fontSize: 22.sp)),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24, top: 10),
          child: InkWell(
              onTap: controller.onChangeView,
              child: SvgPicture.asset(ImageAssets.gridSquare)),
        )
      ],
    );
  }

  Widget gridCard(
      {required double width,
      required String? image,
      required String plateNumber,
      required String createdAt,
      required Violation violation}

      // {
      // double? boxWidth,
      // double? boxHeight,
      // double? imageHeight,
      // }
      ) {
    return SizedBox(
      width: 160.sp,
      height: 175.sp,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6.r),
              topRight: Radius.circular(6.r),
            ),
            child: Image.network(
              image!,
              fit: BoxFit.fitHeight,
              height: 110.sp,
              width: width.sp,
            ),
          ),
          Expanded(
            child: Container(
              width: width,
              height: 53.sp,
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
                  padding: const EdgeInsets.only(top: 4, bottom: 5, left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textWidget(
                              //  text: 'KSF - 622 AE',
                              text: plateNumber,
                              style: getMediumStyle(
                                  fontSize: 10.sp, color: white)),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                textWidget(
                                    text: createdAt,
                                    textOverflow: TextOverflow.visible,
                                    style: getMediumStyle(
                                        fontSize: 10.sp, color: grey1)),
                                SizedBox(
                                  width: 5.sp,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: SizedBox(
                                    width: 3.sp,
                                    height: 3.sp,
                                    child: const DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: white,
                                            shape: BoxShape.circle)),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.sp,
                                ),
                                textWidget(
                                    text: '11:56 AM',
                                    textOverflow: TextOverflow.visible,
                                    style: getMediumStyle(
                                        fontSize: 10.sp, color: grey1)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: PopupMenuButton<String>(
                          color: white,
                          padding: const EdgeInsets.only(bottom: 2),
                          // iconColor: white,
                          iconSize: 18.sp,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.r),
                            ),
                          ),
                          onSelected: (String result) {
                            controller.onSelected(result, violation);
                          },
                          itemBuilder: (BuildContext context) {
                            return controller.galleryOption
                                .map((String choice) {
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
