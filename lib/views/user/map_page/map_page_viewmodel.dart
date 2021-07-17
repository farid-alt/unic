import 'dart:convert';
import 'dart:typed_data';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:location/location.dart';
import 'package:unic_app/components/api_keys.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/endpoints.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:ui' as ui;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:unic_app/models/adress.dart';
import 'package:unic_app/models/user/driver.dart';
import 'package:unic_app/services/web_services.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// import 'package:socket_io_client/socket_io_client.dart' as IO;

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
  int _timeOfTrip = 10;
  int _distanceOfTrip = 5;
  String _paymentType = 'Cash';
  String _timeToArriveToYouleft = '2';
  String _timeToArriveToDestination = '5';
  // PolylineResult polylineResult;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  double _ratingToTrip = 0;
  int _tipSelectedIndex = 0;
  // var channel =
  //     IOWebSocketChannel.connect(Uri.parse('ws://165.227.134.30:6001'));
  // IO.Socket socket = IO.io('ws://165.227.134.30:6001');x

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
  double get ratingToTrip => this._ratingToTrip;
  set ratingToTrip(value) {
    this._ratingToTrip = value;
    notifyListeners();
  }

  int get tipSelectedIndex => this._tipSelectedIndex;

  set tipSelectedIndex(value) {
    this._tipSelectedIndex = value;
    print('a');
    notifyListeners();
  }

  bool get detailsOpened => this._detailsOpened;
  set detailsOpened(value) {
    this._detailsOpened = value;
    notifyListeners();
  }

  bool _detailsOpenedOnWay = false;

  bool get detailsOpenedOnWay => this._detailsOpenedOnWay;
  set detailsOpenedOnWay(value) {
    this._detailsOpenedOnWay = value;
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
  String get timeToArrivetToDestination => this._timeToArriveToDestination;

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

  String get timeOfTrip => this._timeOfTrip.toString();
  set timeOfTrip(value) {
    this._timeOfTrip = value;
    notifyListeners();
  }

  String get distanceOfTrip => this._distanceOfTrip.toString();
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
  String generateToken() {
    var jwt = JWT(
      {
        "exp": DateTime.now().add(Duration(seconds: 10)).millisecondsSinceEpoch,
        "custom_data": "some data",
      },
    );
    //secret key is our secret passphrase
    var token = jwt.sign(SecretKey('secret_key'));
    return token;
  }

  MapPageViewModel() {
    // try {
    //   channel.stream.listen((message) {
    //     print(message);
    //   });
    // } catch (e) {
    //   print();
    // }

    print('1');
    try {
      // IO.Socket socket = IO.io('https://unik.neostep.az:6001');
      // socket.onConnect((_) {
      //   print('connect');
      //   socket.emit('msg', 'test');
      // });
      // socket.on('TestEvent', (data) => print(data));
      // socket.onDisconnect((_) => print('disconnect'));
      // socket.on('fromServer', (_) => print(_));
      Echo echo = new Echo({
        'broadcaster': 'socket.io',
        'client': IO.io,
        'host': 'https://unik.neostep.az:6001',
        'auth': {
          'headers': {'Authorization': 'Bearer $TOKEN'}
        }
      });
      // echo.join('your_channel_name').here((users) {
      //   print(users);
      // }).joining((user) {
      //   print(user);
      // }).leaving((user) {
      //   print(user);
      // }).listen('PresenceEvent', (e) {
      //   print(e);
      // });
      // echo.connect();
      // print("ECHO ${}");
      echo.private('user.1').listen('TestEvent', (e) {
        print("EEE $e");
      });
    } catch (e) {
      print("EEEXC $e");
    }
    print('2');
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

  calculateOrder() async {
    print('1');

    List data1 =
        await getLocationOfAdress(adress: "${_firstAdress.nameOfPlace}");
    _firstAdress.lat = data1[0];
    _firstAdress.lng = data1[1];

    print('2');
    // _adresses.forEach((element) async {
    //   print("NAME ${element.nameOfPlace}");
    //   List data2 = await getLocationOfAdress(
    //       adress: "${element.nameOfPlace} ${element.adress}");
    //   element.lat = data2[0];
    //   element.lng = data2[1];
    // });
    for (var i = 0; i < _adresses.length; i++) {
      print("NAME ${_adresses[i].nameOfPlace}");
      List data2 =
          await getLocationOfAdress(adress: "${_adresses[i].nameOfPlace}");
      _adresses[i].lat = data2[0];
      _adresses[i].lng = data2[1];
    }
    print('3');
    print([
      _firstAdress.lat,
      _firstAdress.lng,
      _adresses[0].lat,
      _adresses[0].lng,
    ]);
    List disAndDur = await getDistanceBetweenPoints(
      _firstAdress.lat,
      _firstAdress.lng,
      _adresses[0].lat,
      _adresses[0].lng,
    );
    _distanceOfTrip = disAndDur[0];
    _timeOfTrip = disAndDur[1];
    print('4');
    for (var i = 0; i < _adresses.length; i++) {
      if (i + 1 != _adresses.length) {
        List disAndDur2 = await getDistanceBetweenPoints(
          _adresses[i].lat,
          _adresses[i].lng,
          _adresses[i + 1].lat,
          _adresses[i + 1].lng,
        );
        _distanceOfTrip += disAndDur[0];
        _timeOfTrip += disAndDur[1];
      }
    }
    print('5');

    calculateOrderApi();
    notifyListeners();
  }

  calculateOrderApi() async {
    var data = await WebService.postCall(url: CALCULATE_ORDER, data: {
      'id': '1',
      'car_type': _selectedVehicle == Vehicle.Moped ? '0' : '1',
      'destination_km': //_distanceOfTrip.toString(),
          '5',
      'destination_count': (1 + _adresses.length).toString(),
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
    print(data);
    if (data[0] == 200) {
      _costOfTrip = data[1]['data']['tariffPrice'];
    }
    notifyListeners();
  }

  createOrder({createEditId}) async {
    print('a');
    try {
      print({
        'id': '0',
        'customer_id': '1',
        'car_type': _selectedVehicle == Vehicle.Moped ? '0' : '1',
        'payment_method': _paymentType == 'Cash' ? '0' : '1',
        'destination_km': //_distanceOfTrip.toString(),
            '5',
        'destination_time': _timeOfTrip,
        'destinations': json.encode(List.generate(
            _adresses.length + 1,
            (index) => {
                  "destination": index == 0
                      ? "${_firstAdress.nameOfPlace}"
                      : '${_adresses[index - 1].nameOfPlace}',
                  "order": '$index',
                  "longitude": index == 0
                      ? "${_firstAdress.lng}"
                      : '${_adresses[index - 1].lng}',
                  "latitude": index == 0
                      ? "${_firstAdress.lat}"
                      : '${_adresses[index - 1].lat}',
                })),
      });
      print('b');
      var data = await WebService.postCall(url: CREATE_ORDER, data: {
        'id': '0',
        'customer_id': '1',
        'car_type': _selectedVehicle == Vehicle.Moped ? '0' : '1',
        'payment_method': _paymentType == 'Cash' ? '0' : '1',
        'destination_km': //_distanceOfTrip.toString(),
            '5',
        'destination_time': _timeOfTrip.toString(),
        'destination_count': (_adresses.length + 1).toString(),
        'destinations': json.encode(List.generate(
            _adresses.length + 1,
            (index) => {
                  "destination": index == 0
                      ? "${_firstAdress.nameOfPlace}"
                      : '${_adresses[index - 1].nameOfPlace}',
                  "order": '$index',
                  "longitude": index == 0
                      ? "${_firstAdress.lng}"
                      : '${_adresses[index - 1].lng}',
                  "latitude": index == 0
                      ? "${_firstAdress.lat}"
                      : '${_adresses[index - 1].lat}',
                })),
      }, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $TOKEN'
      });
      print(data);
      if (data[0] == 200) {
        // _costOfTrip = data[1]['data']['tariffPrice'];
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<List> getLocationOfAdress({String adress}) async {
    // try {
    // final query = "$adress";
    print(adress);
    try {
      // print('before');
      List<geo.Location> locations = await geo.locationFromAddress(adress);
      // var addresses = await Geocoder.local.findAddressesFromQuery(adress);
      // print(locations);
      // print('after');
      var first = locations.first;
      print("${first.latitude} : ${first.longitude}");
      return [first.latitude, first.longitude];
    } catch (e) {
      print(e);
    }
    // } catch (e) {
    // print(e);
    // }
  }

  getDistanceBetweenPoints(startLat, startLng, endLat, endLng) async {
    print([startLat, startLng, endLat, endLng]);
    final response = await WebService.getCall(
        url:
            'https://maps.googleapis.com/maps/api/distancematrix/json?origins=${startLat},${startLng}&destinations=${endLat},${endLng}&departure_time=now&key=AIzaSyCpl9GHLXYw-u-VALEYNyDVAueci3mQxuM');

    // print(response[1]['rows'][0]['elements'][0]['duration']['text']);
    print(
        "RESPONSE ${response[1]['rows'][0]['elements'][0]['distance']['text']}");
    return [
      response[1]['rows'][0]['elements'][0]['distance']['value'],
      response[1]['rows'][0]['elements'][0]['duration_in_traffic']['value'],
    ];
  }
}
