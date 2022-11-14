import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_jamaah/app/constants/constant.dart';
import 'package:lets_jamaah/app/data/mosque_model.dart';
import 'package:lets_jamaah/app/modules/nearest_mosque/controllers/nearest_mosque_controller.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../../maps/views/maps_view.dart';
import '../../maps/views/page.dart';

class NearestMosqueView extends GetView<NearestMosqueController> {
  static const SOURCE_PERSON = 'person_source';
  static const LAYER_PERSON = 'person_layer';

  static const SOURCE_ID = 'masjid1_source';
  static const LAYER_ID = 'masjid1_layer';

  static const SOURCE_ID2 = 'masjid2_source';
  static const LAYER_ID2 = 'masjid2_layer';

  static const SOURCE_ID3 = 'masjid3_source';
  static const LAYER_ID3 = 'masjid3_layer';

  RxBool sourceAdded = false.obs;
  RxBool layerAdded = false.obs;
  late MapboxMapController mapController;

  void _onMapCreated(MapboxMapController mapController) async {
    this.mapController = mapController;

    // addLocationSourceFromAsset(SOURCE_PERSON, 'assets/person.png',
    //         controller.position!.latitude, controller.position!.longitude)
    //     .then((value) {
    //   sourceAdded.value = true;
    // });
    // addLayer(LAYER_PERSON, SOURCE_PERSON);

    addImageSourceFromAsset(SOURCE_ID, 'assets/dome.png', listMasjid[0])
        .then((value) {
      sourceAdded.value = true;
    });
    addLayer(LAYER_ID, SOURCE_ID);

    addImageSourceFromAsset(SOURCE_ID2, 'assets/dome.png', listMasjid[1])
        .then((value) {
      sourceAdded.value = true;
    });
    addLayer(LAYER_ID2, SOURCE_ID2);

    addImageSourceFromAsset(SOURCE_ID3, 'assets/dome.png', listMasjid[2])
        .then((value) {
      sourceAdded.value = true;
    });
    addLayer(LAYER_ID3, SOURCE_ID3);
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
    return Scaffold(
        body: Obx(
      () => Stack(
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
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(-7.951346, 112.607515),
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
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => ListTile(
                          leading: Icon(Icons.mosque),
                          title: Text(
                            listMasjid[index].nama,
                            style: titleStyle,
                          ),
                          subtitle: Text(
                            listMasjid[index].alamat,
                            style: subtitleStyle,
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.directions),
                            onPressed: () {},
                          )),
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
