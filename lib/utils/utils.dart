// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:slts_mobile_app/services/route_service.dart';
import 'package:slts_mobile_app/shared_widgets/app_btn_widget.dart';
import 'package:slts_mobile_app/styles/styles.dart';
import 'package:slts_mobile_app/utils/constants.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../services/logger.dart';
import '../shared_widgets/shimmer_loading/shimmer_loading.dart';

String fetchErrorText({required String expectedTextVariable}) {
  switch (expectedTextVariable) {
    case "email":
      return AppStrings.emailIsRequiredError;
    case "password":
      return AppStrings.passwordIsRequiredError;
    case 'phone':
      return AppStrings.phoneIsRequiredError;
    case 'otp':
      return AppStrings.otpIsRequiredError;
    case 'fullName':
      return AppStrings.fullNameRequiredError;
    case 'field':
      return AppStrings.fieldIsRequiredError;
    case 'gender':
      return AppStrings.selectGenderError;
    case 'bank':
      return AppStrings.selectBankError;
    case 'accountNumber':
      return AppStrings.selectAccountNumberError;
    case 'userName':
      return AppStrings.userNameRequiredError;
    default:
      return AppStrings.isRequiredError;
  }
}

String formatDateTime({required DateTime date}) {
  try {
    // DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('d MMM, h:mma').format(date);
    return formattedDate;
  } catch (e) {
    // Return the original string if parsing fails
    return 'NAN';
  }
}

String displayTimeago(DateTime dateTime) {
  Locale? currentLocale = Get.deviceLocale;
  timeago.setLocaleMessages(currentLocale!.languageCode, timeago.EnMessages());
  String formattedTimeAgo =
      timeago.format(dateTime, locale: '${currentLocale.languageCode}_short');
  return formattedTimeAgo;
}

String getTimeIn12HourFormat(DateTime dateTime) {
  String formattedTime = DateFormat('h:mm a').format(dateTime);
  return formattedTime;
}

// String formatDate(DateTime datetime) {
//   // var formatter = DateFormat('yyyy-MM-dd');
//   var formatter = DateFormat('dd MMM yyyy');
//   return formatter.format(datetime);
// }

// "dd, MMM h:mma"
String extractMonthDay(String dateString) {
  try {
    // Split the input string by whitespace
    List<String> parts = dateString.split(' ');

    // Combine the day of the week, day of the month, and month
    String formattedDate = '${parts[0]} ${parts[1]} ${parts[2]}';

    return formattedDate;
  } catch (e) {
    // Handle the exception or simply return an empty string
    return '';
  }
}

String extractTime(String dateString) {
  try {
    // Split the input string by whitespace
    List<String> parts = dateString.split(' ');

    // Combine the day of the week, day of the month, and month
    String formattedDate = parts[3];

    return formattedDate;
  } catch (e) {
    // Handle the exception or simply return an empty string
    return '';
  }
}



String formatDateTime1(String datetime) {
  // Remove the ordinal indicator ("th") from the day
  String cleanedDate =
      datetime.replaceAllMapped(RegExp(r'(\d+)(st|nd|rd|th)'), (match) {
    return match.group(1)!;
  });

  var formatter = DateFormat('dd, MMMM h:mma');
  DateTime parsedDate = formatter.parse(cleanedDate);
  String formattedDate = DateFormat('dd, MMM h:mma').format(parsedDate);
  return formattedDate;
}

String formatDateTime2(String datetime) {
  // Split the input string by spaces
  List<String> parts = datetime.split(' ');

  // Ensure that there are at least two parts (day and month)
  if (parts.length >= 2) {
    String day = parts[0];
    String monthAbbreviation = parts[1].substring(0, 3);

    // Join the day, comma, abbreviated month, and the rest of the string
    String formattedDate =
        '$day $monthAbbreviation ${parts.sublist(2).join(' ')}';

    return formattedDate;
  }

  // Return the original string if something goes wrong
  return datetime;
}

// rteurns date as example 1 Nov
String formatDate(DateTime datetime) {
  var formatter = DateFormat('dd MMM');
  return formatter.format(datetime);
}

// / rteurns date as example Wed, 1 Nov
String formatDayDate(DateTime datetime) {
  var formatter = DateFormat('E, d MMM');
  return formatter.format(datetime);
}

String formatDateTimeOrTime(DateTime dateTime) {
  final now = DateTime.now();
  final dateFormat = DateFormat('MMM d, y');
  final timeFormat = DateFormat('h:mm a');

  if (dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day) {
    return timeFormat.format(dateTime);
  } else {
    return '${dateFormat.format(dateTime)} ${timeFormat.format(dateTime)}';
  }
}

String formatDateTimeOrTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
 // final timeFormat = DateFormat('h:mm a');
  final dateFormat = DateFormat('d/M/yyyy');
  // final dateFormat = DateFormat('MMM d, y');

  if (dateTime.isAfter(now.subtract(const Duration(days: 7)))) {
    Locale? currentLocale = Get.deviceLocale;
    timeago.setLocaleMessages(
        currentLocale!.languageCode, timeago.EnMessages());
    return '${dateFormat.format(dateTime)}';
    // return timeago.format(dateTime,
    //     allowFromNow: true, locale: '${currentLocale.languageCode}_short');
  } else {
    return '${dateFormat.format(dateTime)}';
    // return '${dateFormat.format(dateTime)} \n${timeFormat.format(dateTime)}';
  }
}

showErrorSnackbar({required String message, String? title, Color? color}) {
  final overlayContext = Get.overlayContext;
  if (overlayContext != null) {
    Get.rawSnackbar(
      snackPosition: SnackPosition.TOP,
      title: title,
      message: message,
      isDismissible: false,
      backgroundColor: color ?? danger,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      borderRadius: 16.0,
      mainButton: GestureDetector(
        onTap: () => routeService.goBack(),
        child: const Icon(
          CupertinoIcons.clear_circled,
          color: white,
        ),
      ),
    );
  } else {
    Logger('Utils').log("overlay context is null");
  }
}

showSuccessSnackbar(
    {required String message, String? title, Color? color, Color? textColor,
    SnackPosition? snackPosition}) {
  final overlayContext = Get.overlayContext;
  if (overlayContext != null) {
    Get.rawSnackbar(
      snackPosition:snackPosition ?? SnackPosition.TOP,
      title: title,
      message: message,
      isDismissible: false,
      backgroundColor: color ?? success,
      duration: const Duration(seconds: 4),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      borderRadius: 16.0,
      mainButton: GestureDetector(
        onTap: () => routeService.goBack(),
        child: const Icon(
          CupertinoIcons.clear_circled,
          color: white,
        ),
      ),
    );
  } else {
    Logger('Utils').log("overlay context is null");
  }
}

/// Custom Alert Dialog
Future<void> showCustomDialog({
  bool barrierDismissible = true,
  String cancelBtnText = 'Cancel',
  String okBtnText = "Let's go",
  String? singleBtnText,
  String? title,
  Color? titleColor,
  Color? messageColor,
  Color? cancelColor,
  Color? okColor,
  String? message,
  Function? onOkPressed,
  Function? singleBtnPressed,
}) async {
  await Get.dialog(
    AlertDialog(
      // backgroundColor: whiteOrBlackColor(),
      // icon: SvgPicture.asset(ImageAssets.featuredIcon),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Text(
        message ?? '',
        // style:
        //     getBoldStyle(color: messageColor ?? textColor(), fontSize: 14.sp),
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: singleBtnText != null
          ? <Widget>[
              AppButton(
                height: 40.h,
                width: 150.w,
                onTap: () async {
                  await singleBtnPressed!();
                },
                // color: okColor ?? calm,
                borderRadius: 8,
                text: singleBtnText,
              ),
            ]
          : <Widget>[
              AppButton(
                width: 100.w,
                height: 40.h,
                onTap: () => Get.back(),
                color: cancelColor ?? danger,
                borderRadius: 8,
                text: cancelBtnText,
              ),
              AppButton(
                width: 100.w,
                height: 40.h,
                onTap: () => onOkPressed!(),
                // color: okColor ?? calm,
                borderRadius: 8,
                text: okBtnText,
              ),
            ],
    ),
    barrierDismissible: barrierDismissible,
  );
}

Widget showShimmerLoader() {
  return ListView.separated(
    itemCount: 5,
    itemBuilder: (context, index) => ShimmerLoading(),
    separatorBuilder: (context, index) => const SizedBox(height: 10),
  );
}
// void openUrl(String url) async {
//   if (!await launchUrl(Uri.parse(url))) {
//     Logger('Utils').debug('msg: Failed to launch $url');
//   }
// }
