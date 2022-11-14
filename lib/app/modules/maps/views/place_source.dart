import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_jamaah/app/constants/constant.dart';
import 'package:lets_jamaah/app/data/mosque_model.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'maps_view.dart';
import 'page.dart';

class PlaceSourcePage extends ExamplePage {
  PlaceSourcePage() : super(const Icon(Icons.place), 'Place source');

  @override
  Widget build(BuildContext context) {
    return const PlaceSymbolBody();
  }
}

class PlaceSymbolBody extends StatefulWidget {
  const PlaceSymbolBody();

  @override
  State<StatefulWidget> createState() => PlaceSymbolBodyState();
}

class PlaceSymbolBodyState extends State<PlaceSymbolBody> {
  PlaceSymbolBodyState();

  static const SOURCE_ID = 'masjid1_source';
  static const LAYER_ID = 'masjid1_layer';

  static const SOURCE_ID2 = 'masjid2_source';
  static const LAYER_ID2 = 'masjid2_layer';

  static const SOURCE_ID3 = 'masjid3_source';
  static const LAYER_ID3 = 'masjid3_layer';

  bool sourceAdded = false;
  bool layerAdded = false;
  late MapboxMapController controller;

  void _onMapCreated(MapboxMapController controller) {
    this.controller = controller;

    addImageSourceFromAsset(SOURCE_ID, 'assets/dome.png', listMasjid[0])
        .then((value) {
      setState(() => sourceAdded = true);
    });
    addLayer(LAYER_ID, SOURCE_ID);

    addImageSourceFromAsset(SOURCE_ID2, 'assets/dome.png', listMasjid[1])
        .then((value) {
      setState(() => sourceAdded = true);
    });
    addLayer(LAYER_ID2, SOURCE_ID2);

    addImageSourceFromAsset(SOURCE_ID3, 'assets/dome.png', listMasjid[2])
        .then((value) {
      setState(() => sourceAdded = true);
    });
    addLayer(LAYER_ID3, SOURCE_ID3);
  }

  @override
  void dispose() {
    super.dispose();
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
    return controller.addImageSource(
        imageSourceId, list, convertToKotak(data.latitude, data.longitude));
  }

  /// Update an asset image as a source to the currently displayed style
  Future<void> updateImageSourceFromAsset(
      String imageSourceId, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return controller.addImageSource(
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
    return controller.removeSource(imageSourceId);
  }

  Future<void> addLayer(String imageLayerId, String imageSourceId) {
    if (layerAdded) {
      removeLayer(imageLayerId);
    }
    setState(() => layerAdded = true);
    return controller.addImageLayer(imageLayerId, imageSourceId);
  }

  Future<void> addLayerBelow(
      String imageLayerId, String imageSourceId, String belowLayerId) {
    if (layerAdded) {
      removeLayer(imageLayerId);
    }
    setState(() => layerAdded = true);
    return controller.addImageLayerBelow(
        imageLayerId, imageSourceId, belowLayerId);
  }

  Future<void> removeLayer(String imageLayerId) {
    setState(() => layerAdded = false);
    return controller.removeLayer(imageLayerId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            SizedBox(
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
      ),
    );
  }
}
