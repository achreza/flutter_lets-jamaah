import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/dzikir_counter_controller.dart';

class DzikirCounterView extends GetView<DzikirCounterController> {
  DzikirCounterView({Key? key}) : super(key: key);

  var controller = Get.put<DzikirCounterController>(
    DzikirCounterController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
            child: Text(
              'Dzikir Counter',
              style: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                controller.increment();
              },
              child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                padding: EdgeInsets.all(8),
                //rounded corner
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 246, 238, 252),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.touch_app_outlined,
                            size: 16, color: Colors.black45),
                        Text("Tap this area to increase counter",
                            style: GoogleFonts.lato(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                            )),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 241, 224, 252),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Obx(() => Text(
                                controller.count.value.toString(),
                                style: GoogleFonts.lato(
                                  fontSize: 64,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                      ),
                    ),
                    //rounded border Container
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          //create rounded border container
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                controller.reset();
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(50, 8, 50, 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF5E1599)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Reset",
                  style: GoogleFonts.lato(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
