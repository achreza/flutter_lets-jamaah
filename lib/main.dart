import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialA
      debugShowCheckedModeBanner: false,
      title: "Lets Jamaah
      title: "Application",

      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
