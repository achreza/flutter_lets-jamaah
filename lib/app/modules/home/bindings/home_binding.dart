import 'package:get/get.dart';
import 'package:lets_jamaah/app/modules/nearest_mosque/controllers/nearest_mosque_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NearestMosqueController>(
      () => NearestMosqueController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
