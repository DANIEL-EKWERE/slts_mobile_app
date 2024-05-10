import 'package:get/get.dart';
import 'package:slts_mobile_app/services/logger.dart';

class AppLandingController extends GetxController {
  Logger logger = Logger('PartnerLandingController');

  RxBool isDone = false.obs;

  AppLandingController() {
    logger.log('Controller initialized');
  }
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    // Get.delete<MoreController>();
    // Get.delete<PaymentController>();
    // Get.put<MoreController>(MoreController());
    // Get.delete<PartnerHomeController>();
    // Get.put<PaymentController>(PaymentController());
    // Get.put<PartnerHomeController>(PartnerHomeController());
    super.onInit();
  }
}
