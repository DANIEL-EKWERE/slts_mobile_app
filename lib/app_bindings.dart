import 'package:get/get.dart';
import 'package:slts_mobile_app/services/api_service.dart';
import 'package:slts_mobile_app/services/db_service.dart';
import 'package:slts_mobile_app/services/device_service.dart';
import 'package:slts_mobile_app/services/route_service.dart';
import 'package:slts_mobile_app/services/token_service.dart';
import 'package:slts_mobile_app/services/user_service.dart';
import 'route/app_links.dart';
import 'services/logger.dart';

class AppBinding extends Bindings {
  Logger logger = Logger('AppBinding');

  @override
  void dependencies() {
    logger.log('loading dependencies');
    Get.put(AppLinks());
    Get.put(RouteService());
    Get.put(ApiService());
    Get.put(TokenService());
    Get.put(DatabaseService());
    Get.put(UserService());
    Get.put(DeviceService());
  }
}
