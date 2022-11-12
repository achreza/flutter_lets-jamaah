import 'package:get/get.dart';

import '../controllers/nearest_mosque_controller.dart';

class NearestMosqueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NearestMosqueController>(
      () => NearestMosqueController(),
    );
  }
}
