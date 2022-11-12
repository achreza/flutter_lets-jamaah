import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lets_jamaah/app/modules/home/controllers/home_controller.dart';

class HomeNavView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller.tabController,
        physics: NeverScrollableScrollPhysics(),
        children: controller.pages,
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.tabIndex.value,
          onTap: controller.changeTab,
          backgroundColor: Colors.grey.shade100,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.mosque),
                label: 'Nearest Mosque',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.circle),
                label: 'Dzikir',
                backgroundColor: Colors.black),
          ],
        ),
      ),
    );
  }
}
