import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lets_jamaah/app/data/mosque_model.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

final LatLng uinMalang = LatLng(-7.951346, 112.607515);

final List<MosqueModel> listMasjid = [
  MosqueModel(
      "Masjid At Tarbiyah",
      "Dinoyo, Kec. Lowokwaru, Kota Malang, Jawa Timur 65149",
      "mastar_source",
      "mastar_layer",
      -7.95003345300165,
      112.60686048198788,
      0),
  MosqueModel(
      "Masjid Ulul Albab",
      "Dinoyo, Kec. Lowokwaru, Kota Malang, Jawa Timur 65149",
      "masul_source",
      "masul_layer",
      -7.952832811952779,
      112.60769879487789,
      0),
  MosqueModel(
      "Masjid Darut Tauhid",
      "Jl. Sunan Ampel I No.4, Dinoyo, Kec. Lowokwaru, Kota Malang, Jawa Timur 65149",
      "masdar_source",
      "masdar_layer",
      -7.949973729384694,
      112.60831773067143,
      0),
  MosqueModel(
      "Masjidil Halal",
      "Jl. Kyai Parseh Jaya No.97, Bumiayu, Kec. Kedungkandang, Kota Malang, Jawa Timur 65135",
      "masjidilhalal",
      "masjidilhalal",
      -8.005132384211043,
      112.63841434138351,
      0),
  MosqueModel(
      "Utsman bin Affan Mosque",
      "Jl. Sunan Kalijaga No.8, Dinoyo, Kec. Lowokwaru, Kota Malang, Jawa Timur 65149",
      "utsbafn",
      "utsbafn",
      -7.9537335020699995,
      112.60666890916549,
      0),
  MosqueModel(
      "Hubbul Wathon Mosque",
      "Jl. Sunan Muria II No.Blok C, Dinoyo, Kec. Lowokwaru, Kota Malang, Jawa Timur 65145 ",
      "hbw",
      "hbw",
      -7.953797255820017,
      112.60577841569496,
      0),
  MosqueModel(
      "Al A'raf Mosque",
      "Ketawanggede, Kec. Lowokwaru, Kota Malang, Jawa Timur 65145 ",
      "aamsq",
      "aamsq",
      -7.952034858211732,
      112.61111170885488,
      0),
  MosqueModel(
      "Masjid Bahrul Ulum",
      "Jl. Fakultas Perikanan dan Ilmu Kelautan, Ketawanggede, Kec. Lowokwaru, Kota Malang, Jawa Timur 65145 ",
      "msjbrl",
      "msjbrl",
      -7.953011609864311,
      112.61111170885488,
      0),
  MosqueModel(
      "Rois Dahlan Mosque",
      "Jl. Kerto Raharjo No.89a, Ketawanggede, Kec. Lowokwaru, Kota Malang, Jawa Timur 65144",
      "rsdhln",
      "rsdhln",
      -7.948443397486542,
      112.60944269375386,
      0),
  MosqueModel(
      "Masjid Nurusshobah",
      "Jl. Kertosentono No.11, Ketawanggede, Kec. Lowokwaru, Kota Malang, Jawa Timur 65144",
      "msjdnrss",
      "msjdnrss",
      -7.94757182488046,
      112.6089571620901,
      0),
];

final titleStyle = GoogleFonts.lato(
    fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor);
final subtitleStyle = GoogleFonts.lato(fontSize: 12);

final primaryColor = HexColor("#684D92");
