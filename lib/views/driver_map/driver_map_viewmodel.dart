import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unic_app/components/api_keys.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/models/adress.dart';
import 'package:unic_app/models/user/user.dart';
import 'dart:ui' as ui;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:unic_app/services/web_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
  String _costOfTripPromo;
  String _timeOfTrip = '10';
  String _distanceOfTrip = '15';
  String _paymentType = 'Cash';
  String get paymentType => this._paymentType;
  bool _online = true;
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
  String orderId;
  bool _endTrip1 = false;
  bool _endTrip2 = false;
  bool _endTrip3 = false;
  Future currentOrderFuture;
  int _waitingToSwipe = 20;
  int counter = 0;
  bool get online => this._online;
  StreamSubscription<LocationData> locationStream;
  set online(val) {
    this._online = val;
    changeOnline();
    setPrefs();
    notifyListeners();
  }

  getOnlineFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _online = prefs.getBool('online') ?? true;
    notifyListeners();
  }

  setPrefs() async {
    // _online = !_online;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('online', _online);
  }

  int get waitingToSwipe => this._waitingToSwipe;
  set waitingToSwipe(val) {
    this._waitingToSwipe = val;
    notifyListeners();
  }

  String get costOfTripPromo => this._costOfTripPromo;
  set costOfTripPromo(val) {
    this._costOfTripPromo = val;
  }

  set endTrip1(val) {
    this._endTrip1 = val;
    notifyListeners();
  }

  bool get endTrip1 => this._endTrip1;

  set endTrip2(val) {
    this._endTrip2 = val;
    notifyListeners();
  }

  bool get endTrip2 => this._endTrip2;
  set endTrip3(val) {
    this._endTrip3 = val;
    notifyListeners();
  }

  bool get endTrip3 => this._endTrip3;

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

  drawPolyline(LatLng start, LatLng end) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        GOOGLE_API_KEY,
        PointLatLng(start.latitude, start.longitude),
        PointLatLng(end.latitude, end.longitude),
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

  startCounter() {
    print("START COUNTER");
    _waitingToSwipe = 20;
    Timer.periodic(Duration(seconds: 1), (timer) {
      _waitingToSwipe--;
      notifyListeners();
      if (timer.tick == 20) {
        if (status == StatusOfMapDriver.AcceptTrip) {
          cancelOrder(type: '1');
        }
        timer.cancel();
      }
    });
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
    print("DRIVER ID $DRIVERID");
    _waitingToSwipe = 20;
    currentOrderFuture = getCurrentorder();

    getOnlineFromPrefs();
    // final channel = WebSocketChannel.connect(
    //   Uri.parse('https://unikeco.az:6001'),
    // );
    // channel.sink.add('Hello!');
    Echo echo = new Echo({
      'broadcaster': 'socket.io',
      'client': IO.io,
      'host': 'https://unikeco.az:8443',
      'auth': {
        'headers': {'Authorization': 'Bearer $TOKEN'}
      }
    });
    SharedPreferences.getInstance().then((value) {
      echo.private('user.${value.getString('userId')}').listen('OrderEvent',
          (e) {
        print("DDD $e");
        Map data = e;
        orderId = data['order']['id'].toString();
        // _customer = User();

        switch (data['status']) {
          case 1:
            _status = StatusOfMapDriver.AcceptTrip;
            print('1');
            // _waitingToSwipe = 20;
            startCounter();
            break;
          case 30:
            _status = StatusOfMapDriver.WaitinigForTrip;
            print('3');
            break;
          // case 4:
          //   _status = StatusOfMapDriver.TripFinished;
          //   print('4');
          //   break;
          // case 10:
          //   _status = StatusOfMapDriver.SearchingDriver;
          //   print('10');
          //   break;
          // case 40:
          //   print('40');
          //   _status = StatusOfMapDriver.Start;
          //   //TODO TOAST NO DRIVER
          //   break;
        }
        notifyListeners();
      });
    });
    locationStream =
        location.onLocationChanged.listen((LocationData currentLocation) {
      this._locationData = currentLocation;
      counter++;
      if (counter % 30 == 0) {
        print('position send driver $ID');
        sendPosition(
            latitude: currentLocation.latitude,
            longitude: currentLocation.longitude);
      }
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

  @override
  dispose() {
    super.dispose();
    locationStream.cancel();
  }

  Map<String, Marker> get markers => this._markers;

  findMyLocation() {
    return location.getLocation();
  }

  openWaze() {}

  void launchWaze() async {
    var url;
    var fallbackUrl;
    if (_status == StatusOfMapDriver.SwipeToTakeCustomer) {
      url = "waze://?ll=${firstAdress.lat},${firstAdress.lat}";
      fallbackUrl =
          'https://waze.com/ul?ll=${firstAdress.lat},${firstAdress.lat}&navigate=yes';
    } else {
      url = "waze://?ll=${adresses[0].lat},${adresses[0].lng}";
      fallbackUrl =
          'https://waze.com/ul?ll=${adresses[0].lat},${adresses[0].lng}&navigate=yes';
    }

    try {
      bool launched =
          await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

  getCurrentOrder() async {
    var data = await WebService.getCall(
        url: 'https://unikeco.az/api/order/current-driver-order?id=$DRIVERID',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $TOKEN'
        });
    print(data);
    if (data[0] == 200) {
      if (data[1]['data']['status'] != -1) {
        try {
          orderId = data[1]['data']['id'].toString();
          _timeOfTrip = data[1]['data']['destination_time'];
          _distanceOfTrip = data[1]['data']['destination_km'];
          _costOfTrip = data[1]['data']['tariff_price'];
          _costOfTripPromo = data[1]['data']['destination_price'];
          _costOfTripPromo = data[1]['data']['destination_price'];
          _firstAdress = Adress(
            nameOfPlace: data[1]['data']['destinations'][0]['destination'],
            lat: double.parse(data[1]['data']['destinations'][0]['latitude']),
            lng: double.parse(data[1]['data']['destinations'][0]['longitude']),
          );
          for (var i = 1; i < data[1]['data']['destinations'].length; i++) {
            _adresses.add(Adress(
                nameOfPlace: data[1]['data']['destinations'][i]['destination'],
                lat: double.parse(
                    data[1]['data']['destinations'][i]['latitude']),
                lng: double.parse(
                    data[1]['data']['destinations'][i]['longitude'])));
          }
          // _driver = Driver(
          //     id: data[1]['data']['driver']['id'],
          //     lat: double.parse(data[1]['data']['driver']['latitude']),
          //     lng: double.parse(data[1]['data']['driver']['longitude']),
          //     profilePicAdress: data[1]['data']['driver']['image'],
          //     fullname: data[1]['data']['driver']['user']['full_name'],
          //     email: data[1]['data']['driver']['user']['email'],
          //     isMoped: data[1]['data']['driver']['car_type'] == null
          //         ? true
          //         : data[1]['data']['driver']['car_type'] == 0
          //             ? true
          //             : false,
          //     number: data[1]['data']['driver']['user']['phone'],
          //     vehicleNumberId: '${data[1]['data']['driver']['car_number']}',
          //     rating:
          //         double.parse(data[1]['data']['driver']['rating'].toString())
          //     //TODO ADD VEHICLE NUMBER
          //     );
          // _markers.clear();
          // addMarker(
          //     id: _driver.id.toString(),
          //     latitude: _driver.lat,
          //     longitude: _driver.lng);
        } catch (e) {
          print("DRIVER EXC $e");
        }
      }
      switch (data[1]['data']['status']) {
        case 2:
          _status = StatusOfMapDriver.SwipeToTakeCustomer;

          print('2');
          break;
        case 3:
          _status = StatusOfMapDriver.SwipeToEndTrip;
          print('3');
          break;
        case 4:
          _status = StatusOfMapDriver.TripEnded;
          print('4');
          _markers.clear();
          polylines.clear();
          break;
        // case 10:
        //   _status = StatusOfMap.SearchingDriver;
        //   print('10');
        //   break;
        case 40:
          print('40');
          _status = StatusOfMapDriver.WaitinigForTrip;
          //TODO TOAST NO DRIVER
          break;
      }
    }
    notifyListeners();
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
      // nameOfPlace: 'Koroglu',
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

  cancelOrder({type}) async {
    // print({
    //   'id': '1',
    //   'order_id': orderId,
    //   'type': type,
    //   // 'driver_id':'1'
    // });
    var data = await WebService.postCall(url: CANCEL_ORDER_DRIVER, data: {
      'id': '1',
      'order_id': orderId,
      'type': type,
      'driver_id': DRIVERID
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
    print(data);
    _status = StatusOfMapDriver.WaitinigForTrip;
    notifyListeners();
  }

  sendPosition({longitude, latitude}) async {
    // print({
    //   'id': '1',
    //   'order_id': orderId,
    //   'type': type,
    //   // 'driver_id':'1'
    // });
    var data = await WebService.postCall(url: DRIVER_POSITION, data: {
      'id': DRIVERID,
      'latitude': latitude.toString(),
      'longitude': longitude.toString()
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
    print(data);
    // _status = StatusOfMapDriver.WaitinigForTrip;
    notifyListeners();
  }

  acceptOrder() async {
    var data = await WebService.postCall(url: ACCEPT_ORDER, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    }, data: {
      // 'id': '1',
      'driver_id': DRIVERID,
      'order_id': orderId
    });
    print(data);
    if (data[0] == 200) {
      polylines.clear();
      drawPolyline(
        LatLng(locationData.latitude, locationData.longitude),
        LatLng(firstAdress.lat, firstAdress.lng),
      );
    }
  }

  pickUpCustomer() async {
    var data = await WebService.postCall(url: PICK_UP, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    }, data: {
      'driver_id': DRIVERID,
      // 'driver_id': _user.id.toString(),
      'order_id': orderId
    });
    print(data);
    if (data[0] == 200) {
      polylines.clear();
      drawPolyline(
        LatLng(firstAdress.lat, firstAdress.lng),
        LatLng(adresses[0].lat, adresses[0].lng),
      );
    }
  }

  completeOrder() async {
    var data = await WebService.postCall(url: COMPLETE_ORDER, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    }, data: {
      'driver_id': DRIVERID,
      // 'driver_id': _user.id.toString(),
      'order_id': orderId
    });
    print(data);
    polylines.clear();
    notifyListeners();
    // if (data[0] == 200) {
    //   _user = Driver.fromJson(data[1]['data']['driver']);
    // }
  }

  changeOnline() async {
    var data = await WebService.postCall(url: CHANGE_ONLINE, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    }, data: {
      'id': DRIVERID,
      // 'driver_id': _user.id.toString(),
      'is_online': _online == true ? '1' : '0'
    });
    print(data);
    // if (data[0] == 200) {
    //   _user = Driver.fromJson(data[1]['data']['driver']);
    // }
  }

  getCurrentorder() async {
    var data = await WebService.getCall(
      url: 'https://unikeco.az/api/order/current-driver-order?id=$DRIVERID',
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $TOKEN'},
    );
    print("CURRRENT ORDER ${data}");
    if (data[0] == 200 && data[1]['data'] != null) {
      try {
        _customer = User(
          name: data[1]['data']['customer']['user']['full_name'],
          phone: data[1]['data']['customer']['user']['phone'],
          profilePicAdress: data[1]['data']['customer']['image'],
        );

        orderId = data[1]['data']['id'].toString();
        _timeOfTrip = data[1]['data']['destination_time'];
        _distanceOfTrip = data[1]['data']['destination_km'];
        _costOfTrip = data[1]['data']['tariff_price'];
        _costOfTripPromo = data[1]['data']['destination_price'];

        _firstAdress = Adress(
          nameOfPlace: data[1]['data']['destinations'][0]['destination'],
          lat: double.parse(data[1]['data']['destinations'][0]['latitude']),
          lng: double.parse(data[1]['data']['destinations'][0]['longitude']),
        );
        for (var i = 1; i < data[1]['data']['destinations'].length; i++) {
          _adresses.add(Adress(
              nameOfPlace: data[1]['data']['destinations'][i]['destination'],
              lat: double.parse(data[1]['data']['destinations'][i]['latitude']),
              lng: double.parse(
                  data[1]['data']['destinations'][i]['longitude'])));
        }
        switch (data[1]['data']['status']) {
          case 1:
            _status = StatusOfMapDriver.AcceptTrip;
            print('1');
            startCounter();
            break;
          case 2:
            _status = StatusOfMapDriver.SwipeToTakeCustomer;
            polylines.clear();
            drawPolyline(
              LatLng(locationData.latitude, locationData.longitude),
              LatLng(firstAdress.lat, firstAdress.lng),
            );
            break;
          case 3:
            _status = StatusOfMapDriver.SwipeToEndTrip;

            polylines.clear();
            drawPolyline(
              LatLng(firstAdress.lat, firstAdress.lng),
              LatLng(adresses[0].lat, adresses[0].lng),
            );

            break;
          case 30:
            _status = StatusOfMapDriver.WaitinigForTrip;
            print('3');
            break;
          // case 4:
          //   _status = StatusOfMapDriver.TripFinished;
          //   print('4');
          //   break;
          // case 10:
          //   _status = StatusOfMapDriver.SearchingDriver;
          //   print('10');
          //   break;
          // case 40:
          //   print('40');
          //   _status = StatusOfMapDriver.Start;
          //   //TODO TOAST NO DRIVER
          //   break;

        }
      } catch (e) {
        print("CURRENT ORDER EXCEPTION $e");
      }
    }
  }
  // cancelOrder() async {
  //   var data = await WebService.postCall(url: CANCEL_ORDER, headers: {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $TOKEN'
  //   }, data: {
  //     // 'id': '1',
  //     'driver_id': '1',
  //     'order_id': '15',
  //     'type': '0'
  //   });
  //   print(data);
  //   // if (data[0] == 200) {
  //   //   _user = Driver.fromJson(data[1]['data']['driver']);
  //   // }
  // }
}
