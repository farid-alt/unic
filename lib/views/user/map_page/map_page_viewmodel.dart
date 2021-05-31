import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:location/location.dart';
import 'dart:ui' as ui;

class MapPageViewModel extends ChangeNotifier {
  Uint8List car1;
  Uint8List car2;
  LocationData _locationData;
  Location location = new Location();
  GoogleMapController _mapController;
  GoogleMapController get mapController => this._mapController;
  final Map<String, Marker> _markers = {};

  MapPageViewModel() {
    location.onLocationChanged.listen((LocationData currentLocation) {
      this._locationData = currentLocation;
    });
    getBytesFromAsset('assets/map_page/car1.png', 70).then((value) {
      car1 = value;
      final marker = Marker(
        // icon: sourceIcon,
        //  icon: BitmapDescriptor.fromBytes(markerIcond),
        icon: BitmapDescriptor.fromBytes(car1),
        markerId: MarkerId('1'),
        position: LatLng(
            _locationData.latitude - 0.0010, _locationData.longitude - 0.0010),
      );
      _markers['1'] = marker;
    });
    getBytesFromAsset('assets/map_page/car2.png', 70)
        .then((value) => car2 = value);
  }
  set mapController(controller) {
    this._mapController = controller;
    notifyListeners();
  }

  Map<String, Marker> get markers => this._markers;

  findMyLocation() {
    return location.getLocation();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  animateToMyPosition() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: 15,
        target: LatLng(locationData.latitude, locationData.longitude))));
  }

  LocationData get locationData => this._locationData;
}
