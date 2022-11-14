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
  late String dataterbit;
  late String dataimsak;
  late String datadhuha;
  late String datatanggal;
  late int jam;
  late int menit;

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
      String dhuha = data['jadwal']['data']['dhuha'];
      String terbit = data['jadwal']['data']['terbit'];
      String imsak = data['jadwal']['data']['imsak'];
      String tanggal = data['jadwal']['data']['tanggal'];

      datasubuh = subuh;
      datadzuhur = dzuhur;
      dataashar = ashar;
      datamaghrib = maghrib;
      dataisya = isya;
      datadhuha = dhuha;
      dataterbit = terbit;
      dataimsak = imsak;
      datatanggal = tanggal;
      progres.value = false;
      error.value = false;
    } catch (e) {
      progres.value = false;
      error.value = true;
    }
  }

  String nowPray() {
    DateTime date = DateTime.now();
    jam = date.hour;
    menit = date.minute;

    if (jam >= int.parse(datasubuh.substring(0, 2)) &&
        jam <= int.parse(datadhuha.substring(0, 2))) {
      if (jam == int.parse(datadhuha.substring(0, 2)) &&
          menit >= int.parse(datadhuha.substring(3, 5))) {
        return 'Dhuha';
      }
      return 'Shubuh';
    }
    if (jam >= int.parse(datadhuha.substring(0, 2)) &&
        jam <= int.parse(datadzuhur.substring(0, 2))) {
      if (jam == int.parse(datadzuhur.substring(0, 2)) &&
          menit >= int.parse(datadzuhur.substring(3, 5))) {
        return 'Dzuhur';
      }
      return 'Dhuha';
    } else if (jam >= int.parse(datadzuhur.substring(0, 2)) &&
        jam <= int.parse(dataashar.substring(0, 2))) {
      if (jam == int.parse(dataashar.substring(0, 2)) &&
          menit >= int.parse(dataashar.substring(3, 5))) {
        return 'Ashar';
      }
      return 'Dzuhur';
    } else if (jam >= int.parse(dataashar.substring(0, 2)) &&
        jam <= int.parse(datamaghrib.substring(0, 2))) {
      if (jam == int.parse(datamaghrib.substring(0, 2)) &&
          menit >= int.parse(datamaghrib.substring(3, 5))) {
        return 'Maghrib';
      }
      return 'Ashar';
    } else if (jam >= int.parse(datamaghrib.substring(0, 2)) &&
        jam <= int.parse(dataisya.substring(0, 2))) {
      if (jam == int.parse(dataisya.substring(0, 2)) &&
          menit >= int.parse(dataisya.substring(3, 5))) {
        return 'Isya';
      }
      return 'Maghrib';
    } else if (jam >= int.parse(dataisya.substring(0, 2)) ||
        jam <= int.parse(datasubuh.substring(0, 2))) {
      if (jam == int.parse(datasubuh.substring(0, 2)) &&
          menit >= int.parse(datasubuh.substring(3, 5))) {
        return 'Shubuh';
      }
      return 'Isya';
    } else {
      return 'Tidak Ada';
    }
  }

  String upcomingPray() {
    DateTime date = DateTime.now();
    jam = date.hour;
    menit = date.minute;

    if (nowPray() == 'Shubuh') {
      return 'Dhuha';
    } else if (nowPray() == 'Dhuha') {
      return 'Dzuhur';
    } else if (nowPray() == 'Dzuhur') {
      return 'Ashar';
    } else if (nowPray() == 'Ashar') {
      return 'Maghrib';
    } else if (nowPray() == 'Maghrib') {
      return 'Isya';
    } else if (nowPray() == 'Isya') {
      return 'Shubuh';
    } else {
      return 'Tidak Ada';
    }
  }

  String upcomingTime() {
    DateTime date = DateTime.now();
    jam = date.hour;
    menit = date.minute;
    DateTime timeDzuhur = DateFormat('HH:mm').parse(datadzuhur);
    DateTime timeAshar = DateFormat('HH:mm').parse(dataashar);
    DateTime timeMaghrib = DateFormat('HH:mm').parse(datamaghrib);
    DateTime timeIsya = DateFormat('HH:mm').parse(dataisya);
    DateTime timeShubuh = DateFormat('HH:mm').parse(datasubuh);
    DateTime timeDhuha = DateFormat('HH:mm').parse(datadhuha);
    DateTime timeNow = DateFormat('HH:mm').parse('$jam:$menit');

    if (nowPray() == 'Shubuh') {
      Duration distance = timeDhuha.difference(timeNow);
      return '${distance.inHours} Hours and ${distance.inMinutes % 60} Minutes to go';
    } else if (nowPray() == 'Dhuha') {
      Duration distance = timeDzuhur.difference(timeNow);
      return '${distance.inHours} Hours and ${distance.inMinutes % 60} Minutes to go';
    } else if (nowPray() == 'Dzuhur') {
      Duration distance = timeAshar.difference(timeNow);
      return '${distance.inHours} Hours and ${distance.inMinutes % 60} Minutes to go';
    } else if (nowPray() == 'Ashar') {
      Duration distance = timeMaghrib.difference(timeNow);
      return '${distance.inHours} Hours and ${distance.inMinutes % 60} Minutes to go';
    } else if (nowPray() == 'Maghrib') {
      Duration distance = timeIsya.difference(timeNow);
      return '${distance.inHours} Hours and ${distance.inMinutes % 60} Minutes to go';
    } else if (nowPray() == 'Isya') {
      Duration distance = timeShubuh.difference(timeNow);
      return '${distance.inHours} Hours and ${distance.inMinutes % 60} Minutes to go';
    } else {
      return 'Tidak Ada';
    }
  }

  String upcomingTimePray() {
    if (upcomingPray() == 'Shubuh') {
      return datasubuh;
    } else if (upcomingPray() == 'Dhuha') {
      return datadhuha;
    } else if (upcomingPray() == 'Dzuhur') {
      return datadzuhur;
    } else if (upcomingPray() == 'Ashar') {
      return dataashar;
    } else if (upcomingPray() == 'Maghrib') {
      return datamaghrib;
    } else if (upcomingPray() == 'Isya') {
      return dataisya;
    } else {
      return 'Tidak Ada';
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
    datadhuha = '00:00';
    dataimsak = '00:00';
    dataterbit = '00:00';
    datatanggal = 'Hari, tanggal';
  }
}
