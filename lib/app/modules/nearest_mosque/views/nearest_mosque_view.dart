import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_jamaah/app/components/modals/map_sheet.dart';
import 'package:lets_jamaah/app/constants/constant.dart';
import 'package:lets_jamaah/app/data/mosque_model.dart';
import 'package:lets_jamaah/app/modules/home/controllers/home_controller.dart';
import 'package:lets_jamaah/app/modules/nearest_mosque/controllers/nearest_mosque_controller.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../../maps/views/maps_view.dart';
import '../../maps/views/page.dart';

class NearestMosqueView extends GetView<HomeController> {
  RxBool sourceAdded = false.obs;
  RxBool layerAdded = false.obs;

  late MapboxMapController mapController;

  void _onMapCreated(MapboxMapController mapController) async {
    this.mapController = mapController;

    controller.sortMosque();

    controller.listMasjidUrut.forEach((element) {
      addImageSourceFromAsset(
              element.sourceID.toString(), 'assets/dome.png', element)
          .then((value) {
        sourceAdded.value = true;
      });
      addLayer(element.layerID.toString(), element.sourceID.toString());
    });
  }

  LatLngQuad convertToKotak(double latitude, double longitude) {
    final LatLngQuad kotak = LatLngQuad(
        topLeft: LatLng(latitude + 0.0003, longitude - 0.0003),
        topRight: LatLng(latitude + 0.0003, longitude + 0.0003),
        bottomRight: LatLng(latitude - 0.0003, longitude + 0.0003),
        bottomLeft: LatLng(latitude - 0.0003, longitude - 0.0003));
    print("INI VALUE NYA : " + kotak.toString());
    return kotak;
  }

  /// Adds an asset image as a source to the currently displayed style
  Future<void> addImageSourceFromAsset(
      String imageSourceId, String assetName, MosqueModel data) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImageSource(
        imageSourceId, list, convertToKotak(data.latitude, data.longitude));
  }

  Future<void> addLocationSourceFromAsset(String imageSourceId,
      String assetName, double latitude, double longitude) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImageSource(
        imageSourceId, list, convertToKotak(latitude, longitude));
  }

  /// Update an asset image as a source to the currently displayed style
  Future<void> updateImageSourceFromAsset(
      String imageSourceId, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImageSource(
      imageSourceId,
      list,
      const LatLngQuad(
        bottomRight: LatLng(-33.89884564291081, 151.25229835510254),
        bottomLeft: LatLng(-33.89884564291081, 151.20131492614746),
        topLeft: LatLng(-33.934601369931634, 151.20131492614746),
        topRight: LatLng(-33.934601369931634, 151.25229835510254),
      ),
    );
  }

  Future<void> removeImageSource(String imageSourceId) {
    return mapController.removeSource(imageSourceId);
  }

  Future<void> addLayer(String imageLayerId, String imageSourceId) {
    if (layerAdded.value) {
      removeLayer(imageLayerId);
    }
    layerAdded.value = true;
    return mapController.addImageLayer(imageLayerId, imageSourceId);
  }

  Future<void> addLayerBelow(
      String imageLayerId, String imageSourceId, String belowLayerId) {
    if (layerAdded.value) {
      removeLayer(imageLayerId);
    }
    layerAdded.value = true;
    return mapController.addImageLayerBelow(
        imageLayerId, imageSourceId, belowLayerId);
  }

  Future<void> removeLayer(String imageLayerId) {
    layerAdded.value = false;
    return mapController.removeLayer(imageLayerId);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: Stack(
            children: <Widget>[
              controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox(
                      height: 450,
                      child: MapboxMap(
                        dragEnabled: true,
                        zoomGesturesEnabled: true,
                        myLocationEnabled: true,
                        accessToken: MapsDemo.ACCESS_TOKEN,
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(controller.position!.latitude,
                              controller.position!.longitude),
                          zoom: 15.5,
                        ),
                      ),
                    ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                  height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Nearest Mosque",
                        style: GoogleFonts.lato(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ListView.separated(
                          separatorBuilder: (context, index) => Divider(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => ListTile(
                                onTap: () {
                                  controller.openMaps(
                                      controller.listMasjidUrut[index].nama,
                                      controller.listMasjidUrut[index].latitude,
                                      controller
                                          .listMasjidUrut[index].longitude);
                                },
                                leading: Icon(
                                  Icons.mosque,
                                  size: 30,
                                ),
                                title: Text(
                                  controller.listMasjidUrut[index].nama,
                                  style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                subtitle: Text(
                                  controller.listMasjidUrut[index].alamat,
                                  style: subtitleStyle,
                                ),
                                trailing: Text(
                                  (controller.listMasjidUrut[index].distance /
                                              1000)
                                          .toStringAsFixed(2) +
                                      " Km",
                                  style: GoogleFonts.lato(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: controller.listMasjidUrut[index]
                                                  .distance <=
                                              200
                                          ? Colors.green
                                          : Colors.red),
                                ),
                              ),
                          itemCount: 3)
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
