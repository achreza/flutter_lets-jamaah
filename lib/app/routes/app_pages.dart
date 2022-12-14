import 'package:get/get.dart';

import 'package:lets_jamaah/app/modules/home/bindings/home_binding.dart';
import 'package:lets_jamaah/app/modules/home/views/home_nav_view.dart';
import 'package:lets_jamaah/app/modules/home/views/home_view.dart';
import 'package:lets_jamaah/app/modules/maps/bindings/maps_binding.dart';
import 'package:lets_jamaah/app/modules/maps/views/maps_view.dart';
import 'package:lets_jamaah/app/modules/maps/views/place_source.dart';
import 'package:lets_jamaah/app/modules/maps/views/show_directions.dart';
import 'package:lets_jamaah/app/modules/nearest_mosque/bindings/nearest_mosque_binding.dart';
import 'package:lets_jamaah/app/modules/nearest_mosque/views/nearest_mosque_view.dart';
import '../modules/dzikirCounter/bindings/dzikir_counter_binding.dart';
import '../modules/dzikirCounter/views/dzikir_counter_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/maps/bindings/maps_binding.dart';
import '../modules/maps/views/maps_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeNavView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAPS,
      page: () => ShowDirections(),
      binding: MapsBinding(),
    ),
    GetPage(
      name: _Paths.NEAREST_MOSQUE,
      page: () => NearestMosqueView(),
      binding: NearestMosqueBinding(),
    ),
    GetPage(
      name: _Paths.DZIKIR_COUNTER,
      page: () => DzikirCounterView(),
      binding: DzikirCounterBinding(),
    ),
  ];
}
