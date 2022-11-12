import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_jamaah/app/data/mosque_model.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

final LatLng uinMalang = LatLng(-7.951346, 112.607515);

final List<MosqueModel> listMasjid = [
  MosqueModel("Masjid Al Tarbiyah", "Jl. Ini", "mastar_source", "mastar_layer",
      -7.95003345300165, 112.60686048198788),
  MosqueModel("Masjid Ulul Albab", "Jl. ini", "masul_source", "masul_layer",
      -7.952832811952779, 112.60769879487789),
  MosqueModel("Masjid Darut Tauhid", "Jl. ini", "masdar_source", "masdar_layer",
      -7.949973729384694, 112.60831773067143)
];

final titleStyle = GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold);
final subtitleStyle = GoogleFonts.lato(fontSize: 12);
