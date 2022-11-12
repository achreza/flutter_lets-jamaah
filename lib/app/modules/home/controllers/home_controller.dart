import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_jamaah/app/modules/dzikirCounter/views/dzikir_counter_view.dart';
import 'package:lets_jamaah/app/modules/home/views/home_view.dart';
import 'package:lets_jamaah/app/modules/nearest_mosque/views/nearest_mosque_view.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //TODO: Implement HomeController

  final count = 0.obs;

  final List<Widget> pages = [
    HomeView(),
    NearestMosqueView(),
    DzikirCounterView()
  ];

  final RxInt tabIndex = 0.obs;
  late TabController tabController;

  void changeTab(int index) {
    tabIndex.value = index;
    tabController.animateTo(index);
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: pages.length, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
