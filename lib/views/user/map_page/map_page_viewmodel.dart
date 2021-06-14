import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:location/location.dart';
import 'package:unic_app/components/api_keys.dart';
import 'package:unic_app/components/colors.dart';
import 'dart:ui' as ui;

import 'package:unic_app/models/adress.dart';
import 'package:unic_app/models/user/driver.dart';

enum StatusOfMap {
  Start,
  ApplyYourTrip,
  SearchingDriver,
  DriverComes,
  YouAreOnWay,
}
enum Vehicle { Moped, Motorcycle }

class MapPageViewModel extends ChangeNotifier {
  StatusOfMap _status = StatusOfMap.Start;
  Uint8List car1;
  Uint8List car2;
  LocationData _locationData;
  Location location = new Location();
  GoogleMapController _mapController;
  Vehicle _selectedVehicle = Vehicle.Moped;
  String _costOfTrip = '5';
  String _timeOfTrip = '10';
  String _distanceOfTrip = '15';
  String _paymentType = 'Cash';
  String _timeToArriveToYouleft = '2';
  // PolylineResult polylineResult;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Driver _driver = Driver(
      isMoped: true,
      profilePicAdress:
          'https://widgetwhats.com/app/uploads/2019/11/free-profile-photo-whatsapp-4.png',
      name: 'John',
      surname: 'Jonathan',
      rating: 4,
      vehicleNumberId: '123awq1',
      number: '+994553660475');
  bool _detailsOpened = false;

  bool get detailsOpened => this._detailsOpened;
  set detailsOpened(value) {
    this._detailsOpened = value;
    notifyListeners();
  }

  drawPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        GOOGLE_API_KEY,
        PointLatLng(
            _locationData.latitude - 0.0190, _locationData.longitude - 0.1090),
        PointLatLng(_locationData.latitude, _locationData.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: kPrimaryColor,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
    notifyListeners();
  }

  Driver get driver => this._driver;
  String get timeToArrivetToYouLeft => this._timeToArriveToYouleft;

  String get paymentType => this._paymentType;

  set paymentType(value) {
    this._paymentType = value;
    notifyListeners();
  }

  String get costOfTrip => this._costOfTrip;
  set costOfTrip(value) {
    this._costOfTrip = value;
    notifyListeners();
  }

  String get timeOfTrip => this._timeOfTrip;
  set timeOfTrip(value) {
    this._timeOfTrip = value;
    notifyListeners();
  }

  String get distanceOfTrip => this._distanceOfTrip;
  set distanceOfTrip(value) {
    this._distanceOfTrip = value;
    notifyListeners();
  }

  Vehicle get selectedVehicle => this._selectedVehicle;
  set selectedVehicle(value) {
    this._selectedVehicle = value;
    notifyListeners();
  }

  GoogleMapController get mapController => this._mapController;
  final Map<String, Marker> _markers = {};

  set status(value) {
    this._status = value;
    notifyListeners();
  }

  StatusOfMap get status => this._status;

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
            _locationData.latitude - 0.0090, _locationData.longitude - 0.0090),
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

  /////////////
  Adress _firstAdress = Adress();
  Adress get firstAdress => this._firstAdress;

  set firstAdress(value) {
    this._firstAdress = value;
    notifyListeners();
  }

  List<TextEditingController> controllers = [TextEditingController()];
  List<Adress> _adresses = [Adress()];

  List<Adress> get adresses => this._adresses;
  set adresses(value) {
    this._adresses = value;
  }
}
