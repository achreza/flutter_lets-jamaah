import 'package:get/get.dart';

class DzikirCounterController extends GetxController {
  //TODO: Implement DzikirCounterController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  //create reset counter
  void reset() => count.value = 0;
}
