import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:slts_mobile_app/screens/guest/forgot_password/forgot_password_controller.dart';
// import 'package:slts_mobile_app/screens/guest/login/login_controller.dart';
import 'package:slts_mobile_app/shared_widgets/generic_widgts.dart';
import 'package:slts_mobile_app/shared_widgets/app_btn_widget.dart';
import 'package:slts_mobile_app/shared_widgets/text_input_widgets/normal_text_input_widget.dart';
// import 'package:slts_mobile_app/shared_widgets/text_input_widgets/password_input_text_widget.dart';
import 'package:slts_mobile_app/shared_widgets/text_widget.dart';
import 'package:slts_mobile_app/styles/asset_manager.dart';
import 'package:slts_mobile_app/styles/styles.dart';
import 'package:slts_mobile_app/utils/constants.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  ForgotPasswordScreen({super.key});

  final controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
   //double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(
        onTap: controller.goBack,
        leading: const Padding(
          padding: EdgeInsets.only(left: 30),
          child: Icon(Icons.arrow_back_ios),
        ),
        title: textWidget(
            text: AppStrings.forgotPassword,
            style: getSemiBoldStyle(fontSize: 22.sp)),
      ),
      body: body(context, width),
    );
  }

  Widget body(BuildContext context, double width) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.sp, vertical: 30.sp),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30.sp),
              height: 225.sp,
              width: 225.sp,
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: white),
              child: Center(
                child: SvgPicture.asset(ImageAssets.lock),
              ),
            ),
            SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: controller.forgotasswordFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWidget(
                        text: AppStrings.enterUserNameBelow,
                        textAlign: TextAlign.center,
                        textOverflow: TextOverflow.visible,
                        style: getRegularStyle(color: black1)),
                    NormalInputTextWidget(
                      title: '',
                      expectedVariable: "userName",
                      hintText: AppStrings.userNameHint,
                      controller: controller.emailOrPhoneController,
                      filled: true,
                      fillColor: white,
                    ),
                   
                    SizedBox(
                      height: 100.sp,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        controller.isLoading.value
                            ? centerLoadingIcon()
                            : AppButton(
                                text: AppStrings.sendResetLink,
                                width: width,
                                onTap: () {},
                              ),
                        SizedBox(
                          height: 20.sp,
                        ),
                        backToLogin(onTap: controller.goBack),
                        SizedBox(
                          height: 36.sp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget backToLogin({void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: textWidget(
          text: AppStrings.backToLogin,
          style: getMediumStyle(color: primaryColor, fontSize: 16.sp).copyWith(
              decoration: TextDecoration.underline,
              decorationColor: primaryColor)),
    );
  }
}
