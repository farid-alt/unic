import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:unic_app/models/adress.dart';
import 'package:unic_app/models/user/user.dart';
import 'dart:ui' as ui;

enum StatusOfMapDriver {
  WaitinigForTrip,
  AcceptTrip,
  SwipeToTakeCustomer,
  SwipeToEndTrip,
  TripEnded
}
enum Vehicle { Moped, Motorcycle }

class DriverMapViewModel extends ChangeNotifier {
  StatusOfMapDriver _status = StatusOfMapDriver.WaitinigForTrip;
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
  String get paymentType => this._paymentType;

  String _timeToArriveToYouleft = '2';
  String _timeToArriveToDestination = '5';
  // PolylineResult polylineResult;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  double _ratingToTrip = 0;
  int _tipSelectedIndex = 0;
  String get timeToArrivetToYouLeft => this._timeToArriveToYouleft;
  String get timeToArrivetToDestination => this._timeToArriveToDestination;
  bool _endTrip = false;
  set endTrip(val) {
    this._endTrip = val;
    notifyListeners();
  }

  bool get endTrip => this._endTrip;

  bool detailsOpened = false;
  set changeDetails(val) {
    detailsOpened = val;
    notifyListeners();
  }

  String get costOfTrip => this._costOfTrip;
  String get timeOfTrip => this._timeOfTrip;
  String get distanceOfTrip => this._distanceOfTrip;

  set status(value) {
    this._status = value;
    notifyListeners();
  }

  User _customer = User(
      profilePicAdress:
          'https://widgetwhats.com/app/uploads/2019/11/free-profile-photo-whatsapp-4.png',
      name: 'John',
      surname: 'Jonathan',
      phone: '+994553660475');

  User get customer => this._customer;

  StatusOfMapDriver get status => this._status;
  DriverMapViewModel() {
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

  final Map<String, Marker> _markers = {};
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
    _mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: 15,
        target: LatLng(locationData.latitude, locationData.longitude))));
  }

  GoogleMapController get mapController => this._mapController;

  LocationData get locationData => this._locationData;
  Adress _firstAdress = Adress(
    nameOfPlace: 'Koroglu',
  );
  Adress get firstAdress => this._firstAdress;

  set firstAdress(value) {
    this._firstAdress = value;
    notifyListeners();
  }

  List<TextEditingController> controllers = [TextEditingController()];
  List<Adress> _adresses = [
    Adress(
      nameOfPlace: 'Ehmedli',
    )
  ];

  List<Adress> get adresses => this._adresses;
  set adresses(value) {
    this._adresses = value;
  }
}
