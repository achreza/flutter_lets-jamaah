import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeView extends GetView<HomeController> {
 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: ListView(children: [
        Container(
            margin: const EdgeInsets.all(50),
            alignment: const Alignment(0.0, 0.0),
            child: Column(
              children: [
                const Text(
                  'Kota Malang',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Text(
                  controller.datatanggal,
                  style: const TextStyle(fontSize: 15),
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
                        Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                              title: const Text("Subuh"),
                              leading: const Icon(Icons.alarm),
                              trailing: Text(controller.datasubuh)),
                        ),
                        Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                              title: const Text("Dzuhur"),
                              leading: const Icon(Icons.alarm),
                              trailing: Text(controller.datadzuhur)),
                        ),
                        Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                              title: const Text("Ashar"),
                              leading: const Icon(Icons.alarm),
                              trailing: Text(controller.dataashar)),
                        ),
                        Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                              title: const Text("Maghrib"),
                              leading: const Icon(Icons.alarm),
                              trailing: Text(controller.datamaghrib)),
                        ),
                        Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                              title: const Text("Isya"),
                              leading: const Icon(Icons.alarm),
                              trailing: Text(controller.dataisya)),
                        ),
                      ],
                    ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.get_app_outlined),
        onPressed: () => controller.ambilData(),
      ),
    );
  }
}
