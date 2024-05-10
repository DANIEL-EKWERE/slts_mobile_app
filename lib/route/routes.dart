import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:slts_mobile_app/route/app_links.dart';
import 'package:slts_mobile_app/screens/app_landing/app_landing_page.dart';
import 'package:slts_mobile_app/screens/guest/forgot_password/forgot_password_screen.dart';
import 'package:slts_mobile_app/screens/guest/login/login_screen.dart';
import 'package:slts_mobile_app/screens/guest/splash/splash_screen.dart';
import 'package:slts_mobile_app/screens/user/gellery/new_offence/new_offence_screen.dart';
import 'package:slts_mobile_app/screens/user/gellery/gallery_screen.dart';
import 'package:slts_mobile_app/screens/user/gellery/summary/summary_screen.dart';
import 'package:slts_mobile_app/screens/user/home/capture_manual_input/manual_input_screen.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: AppLinks.splash,
      page: () => const SplashScreen(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: AppLinks.login,
      page: () => const LoginScreen(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: AppLinks.forgotPassword,
      page: () => ForgotPasswordScreen(),
    ),
    GetPage(
      name: AppLinks.appLanding,
      page: () => AppLanding(),
    ),
    GetPage(
      name: AppLinks.gallery,
      page: () => GalleryScreen(),
    ),
    GetPage(
      name: AppLinks.summary,
      page: () => SummaryScreen(),
    ),
    GetPage(
      name: AppLinks.newOffence,
      page: () => NewOffenceScreen(),
    ),
    GetPage(
      name: AppLinks.manualInput,
      page: () => ManualInputScreen(),
    ),
    // GetPage(name: AppLinks.homeTest,
    //  page: ()=> HomeTest())
  ];
}
