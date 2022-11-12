import 'package:get/get.dart';

import '../modules/dzikirCounter/bindings/dzikir_counter_binding.dart';
import '../modules/dzikirCounter/views/dzikir_counter_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/maps/bindings/maps_binding.dart';
import '../modules/maps/views/maps_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DZIKIR_COUNTER;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAPS,
      page: () => MapsDemo(),
      binding: MapsBinding(),
    ),
    GetPage(
      name: _Paths.DZIKIR_COUNTER,
      page: () => const DzikirCounterView(),
      binding: DzikirCounterBinding(),
    ),
  ];
}
