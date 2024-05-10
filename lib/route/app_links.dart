import 'package:get/get.dart';

AppLinks get appLinks => Get.find();

class AppLinks {
  static final AppLinks _cache = AppLinks._internal();

  factory AppLinks() {
    return _cache;
  }

  AppLinks._internal();

  static const welcome = "/";
  static const login = "/login";
  static const splash = "/splash";
  static const forgotPassword = "/forgotPassword";
  static const appLanding = "/appLanding";
  static const gallery = "/gallery";
  static const summary = "/summary";
  static const newOffence = "/newOffence";
  static const homeTest = "/homeTest";
  static const manualInput = "/manualInput";



  // static const chatAction = "/user/chat/:key/:action";

  final links = {
    "welcome": welcome,
    "login": login,
    "splash": splash,
    "forgotPassword": forgotPassword,
    "appLanding": appLanding,
    "gallery": gallery,
    "summary": summary,
    "newOffence": newOffence,
    "homeTest": homeTest,
    "manualInput": manualInput,
  };

  String url(String endpoint,
      {Map<String, String>? params, bool parse = true}) {
    var path = links[endpoint]!;
    if (parse) {
      path = parsePath(path, params: params);
    }
    return path;
  }

  String parsePath(String path, {Map<String, String>? params}) {
    if (params != null) {
      params.forEach((key, value) {
        path = path.replaceAll(":$key", value);
      });
    }
    final varPattern = RegExp(r'(?<!:):\w+');
    path = path.replaceAll(varPattern, '');
    final slashPattern = RegExp(r'\/+$');
    path = path.replaceAll(slashPattern, '');
    return path;
  }
}
