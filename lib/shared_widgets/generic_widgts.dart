import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:slts_mobile_app/shared_widgets/text_widget.dart';
import 'package:slts_mobile_app/styles/asset_manager.dart';
import 'package:slts_mobile_app/utils/utils.dart';

import '../styles/styles.dart';

AppBar customAppBar(
    {Widget? title,
    Widget? leading,
    bool? hasLeading = true,
    List<Widget>? actions,
    Color? newTextColor,
    Color? newBackgroundColor,
    Color? newIconColor,
    Color? titleColor,
    bool? autoImplyLeading,
    bool? centerTitle,
    PreferredSizeWidget? bottom,
    void Function()? onTap}) {
  return AppBar(
    elevation: 0.0,
    surfaceTintColor: primaryColor,
    backgroundColor: backgroundColor,
    // backgroundColor: newBackgroundColor ?? whiteOrBlackColor(),
    centerTitle: centerTitle ?? true,
    automaticallyImplyLeading: autoImplyLeading ?? false,
    leading: hasLeading! ? GestureDetector(onTap: onTap, child: leading) : null,
    iconTheme: IconThemeData(
      color: newIconColor,
      // color: newIconColor ?? iconColor(),
    ),
    titleTextStyle: getBoldStyle(
      color: black,
      // color: newTextColor ?? textColor(),
      fontSize: 18,
    ),
    title: title,
    // Text(
    //   title!,
    //   style: getSemiBoldStyle(fontSize: 22.sp,
    //   color: titleColor ?? black),
    // ),
    actions: actions,
    bottom: bottom,
  );
}

Widget centerLoadingIcon({
  double opacity = 0.5,
  double? value,
  double strokeWidth = 4.0,
  Animation<Color?>? valueColor,
}) {
  return Center(
      child: CircularProgressIndicator(
    strokeWidth: strokeWidth,
    color: appColors(),
    value: value,
    valueColor: valueColor,
    backgroundColor: secondaryColor.withOpacity(opacity),
  ));
}

Widget divider({double? thickness, Color? color}) {
  return Divider(
    thickness: thickness ?? 1,
    color: color ?? primaryColor,
  );
}

Widget verticalDivider({double? thickness, Color? color}) {
  return VerticalDivider(
    thickness: thickness ?? 1,
    color: color ?? primaryColor,
    indent: 3,
  );
}

enum ImageSourceType {
  network,
  selected,
}

Widget imageWidget({
  String? localImagePath,
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
}) {
  return Builder(builder: (context) {
    return Image.file(
      File(localImagePath!),
      width: width,
      height: height,
      fit: fit,
    );
  });
}
// if (localImagePath != null && localImagePath.isNotEmpty) {
// print("Image widget: is running in background");

Widget profileAvatar({
  String? imgUrl =
      "https://img.freepik.com/premium-vector/avatar-profile-icon_188544-4755.jpg",
  double? height,
  double? width,
  double? boxHeight,
  double? boxWidth,
  BoxFit fit = BoxFit.cover,
}) {
  return SizedBox(
      height: boxHeight ?? 150,
      width: boxWidth ?? 150,
      child: Builder(builder: (context) {
        return Stack(
          children: [
            imgUrl != null && imgUrl.isNotEmpty
                ? Align(
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                      imageUrl: imgUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        width: width ?? 125.0.w,
                        height: height ?? 125.0.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: ResizeImage(imageProvider,
                                  height: 120, width: 120),
                              fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) => const SizedBox(
                        height: 30,
                        width: 30,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.person,
                        size: 34.sp,
                      ),
                    ))
                : Align(
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                      imageUrl: imgUrl!,
                      imageBuilder: (context, imageProvider) => Container(
                        width: width ?? 100.0.w,
                        height: height ?? 100.0.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) => const SizedBox(
                        height: 30,
                        width: 30,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.person,
                        size: 34.sp,
                      ),
                    )),
            Positioned(
                bottom: 0,
                right: 15,
                child: Image.asset(ImageAssets.appLogoRounded)),
          ],
        );
      }));
}

Widget profileImageWidget({
  required String imgUrl,
  String? localImagePath, // Add this parameter for the local image path
  double? height,
  double? width,
}) {
  return Image(
    image: localImagePath != null
        ? AssetImage(localImagePath)
            as ImageProvider<Object> // Use localImagePath if available
        : NetworkImage(imgUrl), // Fallback to network image URL
    width: width ?? 34.0.w,
    height: height ?? 34.0.h,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      // If there's an error loading the image, display a placeholder
      return Icon(
        Icons.person,
        size: 34.sp,
      );
    },
  );
}

Future<dynamic> infoDialog({
  required String content,
  double? contentHeight,
  void Function()? onTap,
  double? space,
}) async {
  return await Get.dialog(Dialog(
    backgroundColor: Colors.transparent,
    child: Container(
      // width: size.width,
      height: contentHeight,
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              InkWell(
                onTap: onTap,
                // child: SvgPicture.asset(
                //   ImageAssets.closeSmall,
                //   height: 15.sp,
                //   color: black,
                // ),
              ),
              const Spacer(),
              const Spacer(),
            ],
          ),
          textWidget(
            text: content,
            style: getRegularStyle(),
          ),
          SizedBox(
            height: space,
          ),
        ],
      ),
    ),
  ));
}

Widget dropdownWidget({
  required BuildContext context,
  // required String? selectedUserValue,
  required String? hintText,
  required List<String> values,
  required Function onChange,
  String? selectedValue,
  InputDecoration? decoration,
  required String? title,
  Color? iconColor,
  void Function()? onTap,
  String? expectedVariable,
  bool multipleSelection = false,
  void Function(String?)? onSaved,
  Key? key,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      textWidget(
        text: title,
        textOverflow: TextOverflow.visible,
        style: getRegularStyle(fontSize: 12.sp),
      ),
      SizedBox(
        height: 5.sp,
      ),
      SizedBox(
        // height: 55.sp,
        // padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: GestureDetector(
          onTap: onTap,
          child: Material(
            borderOnForeground: false,
            color: Colors.transparent,
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonFormField(
                iconEnabledColor: red,

                isExpanded: true,
                onSaved: onSaved,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return fetchErrorText(
                        expectedTextVariable: expectedVariable ?? '');
                  }
                  return null;
                },
                hint: Text(
                  hintText!,
                  style: getRegularStyle(color: borderColor),
                ),
                value: selectedValue,
                selectedItemBuilder: (context) {
                  return values
                      .map((item) => Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(minWidth: 100),
                            child: Text(
                              item,
                              style: getRegularStyle(),
                            ),
                          ))
                      .toList();
                },
                items: values
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        onTap: () {
                          print("Hello world");
                        },
                        child: multipleSelection
                            ? Row(
                                children: [
                                  Checkbox(
                                    onChanged: (value) {},
                                    value: false,
                                  ),
                                  Text(
                                    item,
                                    style: getRegularStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                item,
                                style: getRegularStyle(
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    )
                    .toList(),
                key: key,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
                // onTap: onTap,
                onChanged: (String? value) => onChange(value),
                icon: Icon(
                  Iconsax.arrow_down_1,
                  color: iconColor ?? borderColor,
                ),
                decoration: decoration ??
                    InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 5.sp, vertical: 13.sp),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: borderColor,
                          width: 1.0.w,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0.r),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: red,
                          width: 1.0.w,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0.r),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: borderColor,
                          width: 1.0.w,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0.r),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: secondaryColor,
                          width: 1.0.w,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0.r),
                        ),
                      ),

                      // filled: true,
                      fillColor: Colors.transparent,
                    ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
