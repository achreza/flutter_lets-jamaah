import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_jamaah/app/constants/constant.dart';
import 'package:map_launcher/map_launcher.dart';

class MapsSheet {
  static show({
    required Function(AvailableMap map) onMapTap,
  }) async {
    final availableMaps = await MapLauncher.installedMaps;

    Get.bottomSheet(Wrap(
      children: [
        SingleChildScrollView(
          child: Container(
            height: 120,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(12),
                  child: Text(
                    "Please select available maps below",
                    style: titleStyle,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: availableMaps.length,
                  itemBuilder: (context, index) {
                    final map = availableMaps[index];
                    return ListTile(
                      leading: SvgPicture.asset(
                        map.icon,
                        height: 30.0,
                        width: 30.0,
                      ),
                      title: Text(map.mapName,
                          style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
                      onTap: () {
                        onMapTap(map);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
