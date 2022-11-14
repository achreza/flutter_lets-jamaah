import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {

    Widget listPray(String pray, String data) {
      return Card(
        margin: const EdgeInsets.fromLTRB(25, 2, 25, 2),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: HexColor('#C0C0C0'), width: 2),
            ),
          ),
          child: ListTile(
              title: Text(pray,
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(color: HexColor("#684D92")),
                      fontWeight: FontWeight.w700,
                      fontSize: 20)),
              trailing: Text(data,
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(color: HexColor("#684D92")),
                      fontWeight: FontWeight.w700,
                      fontSize: 20))),
    }

    return Scaffold(
      body: Obx(() => ListView(children: [
            Container(
              margin: const EdgeInsets.fromLTRB(25, 21, 25, 21),
              alignment: const Alignment(0.0, 0.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/symbols/logo.png',
                    width: 36,
                    height: 36,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: Text(
                      "Let's Jama'ah",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(color: HexColor("#684D92")),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 21, 25, 21),
              alignment: const Alignment(0.0, 0.0),
              child: Column(
                children: [
                  Text(
                    controller.datatanggal,
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(color: HexColor("#684D92")),
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
            Container(
                height: 131,
                margin: const EdgeInsets.fromLTRB(25, 21, 25, 21),
                alignment: const Alignment(0.0, 0.0),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Image.asset('assets/bg.png').image,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: HexColor("#40789A"),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Upcoming Prayer',
                              style: GoogleFonts.lato(
                                  textStyle:
                                      TextStyle(color: HexColor("#FFFFFF")),
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.upcomingPray(),
                                  style: GoogleFonts.lato(
                                      textStyle:
                                          TextStyle(color: HexColor("#FFFFFF")),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  controller.upcomingTimePray(),
                                  style: GoogleFonts.lato(
                                      textStyle:
                                          TextStyle(color: HexColor("#FFFFFF")),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              controller.upcomingTime(),
                              style: GoogleFonts.lato(
                                  textStyle:
                                      TextStyle(color: HexColor("#FFFFFF")),
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.nowPray(),
                              style: GoogleFonts.lato(
                                  textStyle:
                                      TextStyle(color: HexColor("#FFFFFF")),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            Container(
                margin: const EdgeInsets.fromLTRB(25, 21, 25, 21),
                alignment: const Alignment(0.0, 0.0),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 31),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage:
                                AssetImage('assets/symbols/terbit.png'),
                          ),
                          Text(
                            'Terbit',
                            style: GoogleFonts.lato(
                                textStyle:
                                    TextStyle(color: HexColor("#684D92")),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            controller.dataterbit,
                            style: GoogleFonts.lato(
                                textStyle:
                                    TextStyle(color: HexColor("#684D92")),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage:
                                AssetImage('assets/symbols/imsak.png'),
                          ),
                          Text(
                            'Imsak',
                            style: GoogleFonts.lato(
                                textStyle:
                                    TextStyle(color: HexColor("#684D92")),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            controller.dataimsak,
                            style: GoogleFonts.lato(
                                textStyle:
                                    TextStyle(color: HexColor("#684D92")),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Center(
              child: (controller.progres.value)
                  ? Container(
                      padding: const EdgeInsets.all(100),
                      child: const CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                        color: Colors.blue,
                        strokeWidth: 5,
                      ),
                    )
                  : (controller.error.value)
                      ? Container(
                          margin: const EdgeInsets.all(50),
                          alignment: const Alignment(0.0, 0.0),
                          child: const Text('Gagal load data...'))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            listPray('Shubuh', controller.datasubuh),
                            listPray('Dhuha', controller.datadhuha),
                            listPray('Dzuhur', controller.datadzuhur),
                            listPray('Ashar', controller.dataashar),
                            listPray('Maghrib', controller.datamaghrib),
                            listPray('Isya', controller.dataisya),
                          ],
                        ),
            ),
            SizedBox(
              height: 70,
            ),
          ])),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () => controller.ambilData(),
      ),
    );
  }
}
