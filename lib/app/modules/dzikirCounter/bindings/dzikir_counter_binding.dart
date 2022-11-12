import 'package:get/get.dart';

import '../controllers/dzikir_counter_controller.dart';

class DzikirCounterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DzikirCounterController>(
      () => DzikirCounterController(),
    );
  }
}
