import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class NearestMosqueController extends GetxController {
  //TODO: Implement NearestMosqueController

  Position? position;

  RxBool isLoading = true.obs;
  @override
  void onInit() {
    loadLokasi();
    super.onInit();
  }

  void loadLokasi() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print(
        "LATITUDE SEKARANG ${position!.latitude}, Longitude Sekaran ${position!.longitude}");
    isLoading.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
