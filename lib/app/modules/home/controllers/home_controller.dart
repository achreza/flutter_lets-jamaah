import 'package:get/get.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  RxBool progres = false.obs;
  RxBool error = false.obs;
  late String datasubuh;
  late String datadzuhur;
  late String dataashar;
  late String datamaghrib;
  late String dataisya;
  late String datatanggal;

  void ambilData() async {
    progres.value = true;

    var tanggalSekarang = DateTime.now();
    var formatTanggal = DateFormat('yyyy-MM-dd');
    String formatTanggalSekarang = formatTanggal.format(tanggalSekarang);

    try {
      // mensimulasikan request network
      http.Response response = await http.get(Uri.parse(
          'https://api.banghasan.com/sholat/format/json/jadwal/kota/775/tanggal/$formatTanggalSekarang'));
      Map data = jsonDecode(response.body);
      String subuh = data['jadwal']['data']['subuh'];
      String dzuhur = data['jadwal']['data']['dzuhur'];
      String ashar = data['jadwal']['data']['ashar'];
      String maghrib = data['jadwal']['data']['maghrib'];
      String isya = data['jadwal']['data']['isya'];
      String tanggal = data['jadwal']['data']['tanggal'];

      datasubuh = subuh;
      datadzuhur = dzuhur;
      dataashar = ashar;
      datamaghrib = maghrib;
      dataisya = isya;
      datatanggal = tanggal;
      progres.value = false;
      error.value = false;
    } catch (e) {
      progres.value = false;
      error.value = true;
    }
  }

  @override
  void onInit() {
    
    super.onInit();
    progres.value = false;
    error.value = false;
    datasubuh = '00:00';
    datadzuhur = '00:00';
    dataashar = '00:00';
    datamaghrib = '00:00';
    dataisya = '00:00';
    datatanggal = 'Hari, tanggal';
  }
}
