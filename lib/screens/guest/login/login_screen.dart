import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:slts_mobile_app/screens/guest/login/login_controller.dart';
import 'package:slts_mobile_app/shared_widgets/generic_widgts.dart';
import 'package:slts_mobile_app/shared_widgets/app_btn_widget.dart';
import 'package:slts_mobile_app/shared_widgets/text_input_widgets/normal_text_input_widget.dart';
import 'package:slts_mobile_app/shared_widgets/text_input_widgets/password_input_text_widget.dart';
import 'package:slts_mobile_app/shared_widgets/text_widget.dart';
import 'package:slts_mobile_app/styles/asset_manager.dart';
import 'package:slts_mobile_app/styles/styles.dart';
import 'package:slts_mobile_app/utils/constants.dart';

class LoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
   // double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageAssets.loginBg), fit: BoxFit.cover)),
        child: Stack(
          children: [
            SvgPicture.asset(ImageAssets.loginBg2, fit: BoxFit.cover),
            SafeArea(
              child: body(context, width),
            ),
          ],
        ),
      ),
    );
  }

  Widget body(BuildContext context, double width) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 50.sp),
        child: Column(
          children: [
            SizedBox(
              height: 145,
              child: Stack(
                children: [
                  Image.asset(
                    ImageAssets.lastma1,
                  ),
                  Positioned(
                      bottom: 0,
                      right: 8,
                      child: Image.asset(ImageAssets.appLogoRounded)),
                ],
              ),
            ),
            SizedBox(
              height: 60.sp,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: controller.loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget(
                          text: AppStrings.login,
                          style: getBoldStyle(fontSize: 32.sp).copyWith(
                              fontFamily: "Neue", fontWeight: FontWeight.w600)),
                      textWidget(
                          text: AppStrings.welcomeBack,
                          style: getLightStyle(fontSize: 12.sp, color: grey2)
                              .copyWith(fontWeight: FontWeight.w400)),
                      SizedBox(
                        height: 12.sp,
                      ),
                      NormalInputTextWidget(
                        title: '',
                        expectedVariable: "userName",
                        hintText: AppStrings.userNameHint,
                        controller: controller.emailOrPhoneController,
                        filled: true,
                        fillColor: white,
                      ),
                      SizedBox(
                        height: 6.sp,
                      ),
                      PasswordInputTextWidget(
                        title: '',
                        controller: controller.passwordController,
                        expectedVariable: 'password',
                        // suffixIcon: Icon(Icons.remove_red_eye_outlined),
                        icon: !controller.showPassword.value
                            ? Icons.remove_red_eye_outlined
                            : Icons.visibility_off,
                        isObscureValue: controller.showPassword.value,
                        onTap: () => controller.obscurePassword(),
                      ),
                      SizedBox(
                        height: 14.sp,
                      ),
                      forgotPassword(onTap: controller.routeToForgotPassword),
                      SizedBox(
                        height: 40.sp,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          controller.isLoading.value
                              ? centerLoadingIcon()
                              : AppButton(
                                  text: AppStrings.loginButtonText,
                                  width: width,
                                  // onTap: controller.routeToAppLanding,
                                  onTap: controller.processLogin,
                                ),
                          SizedBox(
                            height: 22.sp,
                          ),
                          SizedBox(
                            height: 36.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget forgotPassword({void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          textWidget(
              text: AppStrings.forgotPasswordQ,
              style: getRegularStyle(color: primaryColor).copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: primaryColor)),
        ],
      ),
    );
  }
}
