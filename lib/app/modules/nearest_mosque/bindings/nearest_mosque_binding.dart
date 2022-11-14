import 'package:get/get.dart';
import 'package:lets_jamaah/app/modules/home/controllers/home_controller.dart';

import '../controllers/nearest_mosque_controller.dart';

class NearestMosqueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
