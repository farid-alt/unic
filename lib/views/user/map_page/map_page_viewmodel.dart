import 'dart:async';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unic_app/components/api_keys.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/models/user/user.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:ui' as ui;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:unic_app/models/adress.dart';
import 'package:unic_app/models/user/driver.dart';
import 'package:unic_app/services/web_services.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// import 'package:socket_io_client/socket_io_client.dart' as IO;

// switch ($status) {
//             case 0:
//                 $message = "Sifariş yaradıldı";
//                 $color = 'light';
//                 break;
//             case 1:
//                 $message = "Sürücü qəbul elədi";
//                 $color = 'secondary';
//                 break;
//             case 2:
//                 $message = "Sürücü müştərini götürdü";
//                 $color = 'primary';
//                 break;
//             case 3:
//                 $message = "Sifariş tamamlandı";
//                 $color = 'success';
//                 break;
//             case 10:
//                 $message = "Sürücü imtina elədi";
//                 $color = 'warning';
//                 break;
//             case 20:
//                 $message = "Sürücü 20 saniyə keçdi imtina elədi";
//                 $color = 'warning';
//                 break;
//             case 30:
//                 $message = "Müştəri imtina elədi";
//                 $color = 'danger';
//                 break;
//             default:
//                 $message = "Naməlum status";
//                 $color = 'light';
//         }
enum StatusOfMap {
  Start,
  ApplyYourTrip,
  SearchingDriver,
  DriverComes,
  YouAreOnWay,
  TripFinished
}
enum Vehicle { Moped, Motorcycle }

class MapPageViewModel extends ChangeNotifier {
  String orderId;
  User _user = User();
  StatusOfMap _status = StatusOfMap.Start;
  Uint8List car1;
  Uint8List car2;
  LocationData _locationData;
  Location location = new Location();
  Adress yourAdress;
  GoogleMapController _mapController;
  Vehicle _selectedVehicle = Vehicle.Moped;
  String _costOfTrip = '';
  String _costOfTripPromo = '';
  int _timeOfTrip = 10;
  int _distanceOfTrip = 5;
  String _paymentType = 'Cash';
  int _timeToArriveToYouleft = 0;
  int _timeToArriveToDestination = 0;
  // PolylineResult polylineResult;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  double _ratingToTrip = 0;
  int _tipSelectedIndex = 0;
  Future currentStatusFuture;
  String comment = '';
  // var channel =
  //     IOWebSocketChannel.connect(Uri.parse('ws://165.227.134.30:6001'));
  // IO.Socket socket = IO.io('ws://165.227.134.30:6001');x
  User get user => this._user;
  int counter = 0;
  List _cars = [];
  @override
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
  StreamSubscription<LocationData> locationStream;
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
    _addPolyLine(startLatLng: LatLng(start.latitude - 0.06, start.longitude));
  }

  _addPolyLine({@required LatLng startLatLng}) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: kPrimaryColor,
      points: polylineCoordinates,
      width: 5,
    );
    _mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: startLatLng, zoom: 12)));
    polylines[id] = polyline;
    notifyListeners();
  }

  Driver get driver => this._driver;
  String get timeToArrivetToYouLeft =>
      (this._timeToArriveToYouleft / 60).toStringAsFixed(0);
  String get timeToArrivetToDestination =>
      (this._timeToArriveToDestination / 60).toStringAsFixed(0);

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

  String get costOfTripPromo => this._costOfTripPromo;
  set costOfTripPromo(value) {
    this._costOfTripPromo = value;
    notifyListeners();
  }

  String get timeOfTrip => (this._timeOfTrip / 60).toStringAsFixed(0);
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
  @override
  void dispose() {
    super.dispose();
    locationStream.cancel();
  }

  MapPageViewModel() {
    // try {
    //   channel.stream.listen((message) {
    //     print(message);
    //   });
    // } catch (e) {
    //   print();
    // }
// switch ($status) {
//             case 0:
//                 $message = "Sifariş yaradıldı";
//                 $color = 'light';
//                 break;
//             case 1:
//                 $message = "Sürücü qəbul elədi";
//                 $color = 'secondary';
//                 break;
//             case 2:
//                 $message = "Sürücü müştərini götürdü";
//                 $color = 'primary';
//                 break;
//             case 3:
//                 $message = "Sifariş tamamlandı";
//                 $color = 'success';
//                 break;
//             case 10:
//                 $message = "Sürücü imtina elədi";
//                 $color = 'warning';
//                 break;
//             case 20:
//                 $message = "Sürücü 20 saniyə keçdi imtina elədi";
//                 $color = 'warning';
//                 break;
//             case 30:
//                 $message = "Müştəri imtina elədi";
//                 $color = 'danger';
//                 break;
//             default:
//                 $message = "Naməlum status";
//                 $color = 'light';
//         }
    getCreditCardsApi();
    currentStatusFuture = getCurrentOrder();
    getProfileFuture = getProfileApi();
    print('1');
    try {
      Echo echo = new Echo({
        'broadcaster': 'socket.io',
        'client': IO.io,
        'host': 'https://unikeco.az:8443',
        'auth': {
          'headers': {'Authorization': 'Bearer $TOKEN'}
        }
      });
      // echo.private('driver-location.3').listen('DriverLocation', (e) {
      //   print("POSITION: $e");
      // });
      SharedPreferences.getInstance().then((value) {
        echo.private('user.${value.getString('userId')}').listen('OrderEvent',
            (e) {
          print("EEE $e");
          Map data = e;
          switch (data['status']) {
            case 2:
              _status = StatusOfMap.DriverComes;
              _driver = Driver(
                  id: data['driver']['id'],
                  lat: double.parse(data['driver']['latitude']),
                  lng: double.parse(data['driver']['longitude']),
                  profilePicAdress: data['driver']['image'],
                  fullname: data['driver']['user']['full_name'],
                  email: data['driver']['user']['email'],
                  isMoped: data['driver']['car_type'] == null
                      ? true
                      : data['driver']['car_type'] == 0
                          ? true
                          : false,
                  number: data['driver']['user']['phone'],
                  vehicleNumberId: '${data['driver']['car_number']}',
                  rating: double.parse(data['driver']['rating'].toString())
                  //TODO ADD VEHICLE NUMBER
                  );
              orderId = data['order']['id'].toString();
              _markers.clear();
              addMarker(
                  id: _driver.id.toString(),
                  latitude: _driver.lat,
                  longitude: _driver.lng);

              // polylines.clear();
              // drawPolyline(LatLng(_driver.lat, _driver.lng),
              //     LatLng(locationData.latitude, locationData.longitude));

              //  Driver(
              //     name: data['driver']['user']['full_name'],
              //     email: data['driver']['user']['email'],
              //     isMoped: data['driver']['car_type'] == null
              //         ? true
              //         : data['driver']['car_type'] == 0
              //             ? true
              //             : false,
              //     number: data['phone'],
              //     vehicleNumberId: 'TEST',
              //     rating: data['rating']
              //     //TODO ADD VEHICLE NUMBER
              //     );
              print('2');
              break;
            case 3:
              _status = StatusOfMap.YouAreOnWay;
              // getDistanceBetweenPoints(
              //         locationData.latitude,
              //         locationData.longitude,
              //         _adresses[0].lat,
              //         _adresses[0].lng)
              //     .then((val) {
              //   // _distanceOfTrip=val[0];
              //   _timeToArriveToDestination = val[1];
              // });

              print('3');
              break;
            case 4:
              _status = StatusOfMap.TripFinished;
              print('4');
              _markers.clear();
              polylines.clear();
              polylineCoordinates.clear();
              break;
            case 10:
              _status = StatusOfMap.SearchingDriver;
              print('10');
              break;
            case 40:
              print('40');
              _status = StatusOfMap.Start;
              //TODO TOAST NO DRIVER
              break;
          }

          notifyListeners();
        });
        echo
            .private('driver-location.${value.getString('userId')}')
            .listen('DriverLocationEvent', (e) {
          Map data = e;
          print("LOCATION LIVE $data");
          print(data['latitude']);
          print(data['latitude'].runtimeType);
          markers.clear();
          final marker = Marker(
              // icon: sourceIcon,
              //  icon: BitmapDescriptor.fromBytes(markerIcond),
              icon: BitmapDescriptor.fromBytes(car1),
              markerId: MarkerId('${_driver.id.toString()}'),
              position: LatLng(
                double.parse(e['latitude']),
                double.parse(e['longitude']),
              ));
          _markers['${_driver.id.toString()}'] = marker;
          if (_status == StatusOfMap.YouAreOnWay) {
            getDistanceBetweenPoints(locationData.latitude,
                    locationData.longitude, _adresses[0].lat, _adresses[0].lng)
                .then((val) {
              // _distanceOfTrip=val[0];
              _timeToArriveToDestination = val[1];
            });
          } else {
            getDistanceBetweenPoints(locationData.latitude,
                    locationData.longitude, _driver.lat, _driver.lng)
                .then((val) {
              // _distanceOfTrip=val[0];
              _timeToArriveToYouleft = val[1];
            });
          }

          // markers[_driver.id.toString()] = Marker(
          //     markerId: MarkerId(_driver.id.toString()),
          //     position: LatLng(double.parse(e['user']['latitude']),
          //         double.parse(e['user']['longitude'])));

          notifyListeners();
        });
      });
    } catch (e) {
      print("EEEXC $e");
    }
    print('2');
    // var channel =
    //     IOWebSocketChannel.connect(Uri.parse('https://unikeco.az:6001'));
    // channel.sink.add('received!');
    // channel.stream.listen((message) {
    //   channel.sink.add('received!');
    //   // channel.sink.close(status.goingAway);
    // });
    // IO.Socket socket = IO.io('http://unik.neostep.az:6001');
    // socket.onConnect((_) {
    //   print('connect');
    // });
    // socket.on('event', (data) => print(data));
    // socket.onDisconnect((_) => print('disconnect'));
    // socket.on('fromServer', (_) => print(_));
    // socket.emit('LocationDriver', ['3', '5', '1']);
    locationStream =
        location.onLocationChanged.listen((LocationData currentLocation) {
      if (counter % 15 == 0) {
        this._locationData = currentLocation;
      }
      counter++;
    });
    getBytesFromAsset('assets/map_page/car1.png', 70).then((value) {
      car1 = value;
      getNearestVehicles();
      //  final marker = Marker(
      //   // icon: sourceIcon,
      //   //  icon: BitmapDescriptor.fromBytes(markerIcond),
      //   icon: BitmapDescriptor.fromBytes(car1),
      //   markerId: MarkerId('1'),
      //   position: LatLng(
      //       _locationData.latitude - 0.0090, _locationData.longitude - 0.0090),
      // );
      // _markers['1'] = marker;
    });
    // getBytesFromAsset('assets/map_page/car2.png', 70)
    //     .then((value) => car2 = value);
  }

  set mapController(controller) {
    this._mapController = controller;
    notifyListeners();
  }

  Map<String, Marker> get markers => this._markers;

  findMyLocation() {
    return location.getLocation();
  }

  getCreditCardsApi() async {
    var data = await WebService.getCall(
        url: 'https://unikeco.az/api/customer/credit-cards?id=$ID',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $TOKEN'
        });
    print(data);
    if (data[0] == 200) {
      try {
        _paymentType =
            data[1]['data']['active'].toString() == '0' ? 'Cash' : 'Card';
      } catch (e) {
        print("EXCEPTION CARD $e");
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
  List<Adress> _adresses = [];

  List<Adress> get adresses => this._adresses;
  set adresses(value) {
    this._adresses = value;
  }

  sendReview() async {
    var data = await WebService.postCall(url: SEND_REVIEW_CUSTOMER, data: {
      // 'id': '1',
      'order_id': orderId,
      'rating': ratingToTrip.toString(),
      'tip': (tipSelectedIndex * 5).toString(),
      'message': comment
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
    print(data);
    _status = StatusOfMap.Start;
    notifyListeners();
  }

  cancelOrder() async {
    var data = await WebService.postCall(url: CANCEL_ORDER_CUSTOMER, data: {
      'id': ID,
      'order_id': orderId
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
    print(data);
    _status = StatusOfMap.Start;
    notifyListeners();
  }

  calculateOrder() async {
    try {
      print('1');
      print(_firstAdress.nameOfPlace);
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
      polylines.clear();
      polylineCoordinates.clear();
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

      polylines.clear();
      polylineCoordinates.clear();
      print("FIRST ADRESS ${_adresses[0].nameOfPlace}");
      drawPolyline(
          LatLng(
            _firstAdress.lat,
            _firstAdress.lng,
          ),
          LatLng(
            _adresses[0].lat,
            _adresses[0].lng,
          ));
      for (var i = 0; i < _adresses.length; i++) {
        if (i + 1 != _adresses.length) {
          drawPolyline(
              LatLng(_adresses[i].lat, _adresses[i].lng),
              LatLng(
                _adresses[i + 1].lat,
                _adresses[i + 1].lng,
              ));
        }
      }
      List data = await calculateOrderApi();

      notifyListeners();
      return 200;
    } catch (e) {
      print("EXCEPTION calculate $e");
      return 100;
    }
  }

  Future<List> calculateOrderApi() async {
    print('calculate api start');
    var data = await WebService.postCall(url: CALCULATE_ORDER, data: {
      'id': ID,
      'car_type': _selectedVehicle == Vehicle.Moped ? '0' : '1',
      'destination_km': //_distanceOfTrip.toString(),
          '2',
      'destination_count': (1 + _adresses.length).toString(),
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
    print("CALCULATE API $data");
    if (data[0] == 200) {
      _costOfTrip = data[1]['data']['tariffPrice'].toString();
      _costOfTripPromo = data[1]['data']['price'].toString();
    }
    print('calculate api done');
    return data;
  }

  getNearestVehicles() async {
    var data = await WebService.getCall(
        url:
            'https://unikeco.az/api/driver/live-location?latitude=${_locationData.latitude}&longitude=${_locationData.longitude}',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $TOKEN'
        });
    print(data);
    if (data[0] == 200) {
      print("LIVE TAXI EXIST");
      try {
        for (var i = 0; i < data[1]['data']['drivers'].length; i++) {
          addMarker(
              id: i.toString(),
              latitude: double.parse(data[1]['data']['drivers'][i]['latitude']),
              longitude:
                  double.parse(data[1]['data']['drivers'][i]['longitude']));
        }

        // data[1]['data']['drivers'].forEach((key, value) {});
      } catch (e) {
        print("LIVE TAXI $e");
      }
    }
    notifyListeners();
  }

  addMarker({String id, double latitude, double longitude}) {
    final marker = Marker(
      // icon: sourceIcon,
      //  icon: BitmapDescriptor.fromBytes(markerIcond),
      icon: BitmapDescriptor.fromBytes(car1),
      markerId: MarkerId('$id'),
      position: LatLng(
        latitude,
        longitude,
      ),
    );
    _markers['$id'] = marker;
  }

  getCurrentOrder() async {
    var data = await WebService.getCall(
        url: 'https://unikeco.az/api/order/current-customer-order?id=$ID',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $TOKEN'
        });
    print(data);
    if (data[0] == 200) {
      if (data[1]['data']['status'] != -1) {
        try {
          orderId = data[1]['data']['id'].toString();
          _timeOfTrip = int.parse(data[1]['data']['destination_time']);
          _distanceOfTrip = int.parse(data[1]['data']['destination_km']);
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
          _driver = Driver(
              id: data[1]['data']['driver']['id'],
              lat: double.parse(data[1]['data']['driver']['latitude']),
              lng: double.parse(data[1]['data']['driver']['longitude']),
              profilePicAdress: data[1]['data']['driver']['image'],
              fullname: data[1]['data']['driver']['user']['full_name'],
              email: data[1]['data']['driver']['user']['email'],
              isMoped: data[1]['data']['driver']['car_type'] == null
                  ? true
                  : data[1]['data']['driver']['car_type'] == 0
                      ? true
                      : false,
              number: data[1]['data']['driver']['user']['phone'],
              vehicleNumberId: '${data[1]['data']['driver']['car_number']}',
              rating:
                  double.parse(data[1]['data']['driver']['rating'].toString())
              //TODO ADD VEHICLE NUMBER
              );
          _markers.clear();
          addMarker(
              id: _driver.id.toString(),
              latitude: _driver.lat,
              longitude: _driver.lng);
        } catch (e) {
          print("DRIVER EXC $e");
        }
      }
      switch (data[1]['data']['status']) {
        case 2:
          _status = StatusOfMap.DriverComes;

          print('2');
          break;
        case 3:
          _status = StatusOfMap.YouAreOnWay;
          print('3');
          break;
        case 4:
          _status = StatusOfMap.TripFinished;
          print('4');
          _markers.clear();
          polylines.clear();
          polylineCoordinates.clear();
          break;
        case 10:
          _status = StatusOfMap.SearchingDriver;
          print('10');
          break;
        case 40:
          print('40');
          _status = StatusOfMap.Start;
          //TODO TOAST NO DRIVER
          break;
      }
    }
    notifyListeners();
  }

  createOrder({createEditId}) async {
    print('a');
    try {
      print({
        'id': '0',
        'customer_id': ID,
        'car_type': _selectedVehicle == Vehicle.Moped ? '0' : '1',
        'payment_method': _paymentType == 'Cash' ? '0' : '1',
        'destination_km': _distanceOfTrip.toString(),
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
        'customer_id': ID,
        'car_type': _selectedVehicle == Vehicle.Moped ? '0' : '1',
        'payment_method': _paymentType == 'Cash' ? '0' : '1',
        'destination_km': (_distanceOfTrip * 1000).toString(),
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
      print("CREATE ORDER API $data");
      if (data[0] == 200) {
        // _costOfTrip = data[1]['data']['tariffPrice'];
      }
      return data;
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
        "RESPONSE DISTANCE AND TIME ${response[1]['rows'][0]['elements'][0]['duration_in_traffic']['value']}");
    return [
      response[1]['rows'][0]['elements'][0]['distance']['value'],
      response[1]['rows'][0]['elements'][0]['duration_in_traffic']['value'],
    ];
  }

  Future getProfileFuture;
  getProfileApi() async {
    var data = await WebService.getCall(url: GET_USER, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
    print(data);

    if (data[0] == 200) {
      print(data);
      try {
        _user = User(
          name: data[1]['data']['customer']['user']['full_name'],
          surname: ' ',
          profilePicAdress: data[1]['data']['customer']['image'],
          id: data[1]['data']['customer']['user']['id'],
          // email: data[1]['data']['customer']['user']['email'],
          homeAdress: data[1]['data']['customer']['home_address'] == null
              ? Adress()
              : Adress(
                  nameOfPlace: data[1]['data']['customer']['home_address'],
                  lat: double.parse(
                      data[1]['data']['customer']['home_address_latitude']),
                  lng: double.parse(
                      data[1]['data']['customer']['home_address_longitude']),
                ),
          workAdress: data[1]['data']['customer']['work_address'] == null
              ? Adress()
              : Adress(
                  nameOfPlace: data[1]['data']['customer']['work_address'],
                  lat: double.parse(
                      data[1]['data']['customer']['work_address_latitude']),
                  lng: double.parse(
                      data[1]['data']['customer']['work_address_longitude']),
                ),
          lastAdress: data[1]['data']['customer']['last_address'] == null
              ? Adress()
              : Adress(
                  nameOfPlace: data[1]['data']['customer']['last_address'],
                  lat: double.parse(
                      data[1]['data']['customer']['last_address_latitude']),
                  lng: double.parse(
                      data[1]['data']['customer']['last_address_longitude']),
                ),
          // phone: data[1]['data']['user']['phone']
        );
        print('USER OUT');
      } catch (e) {
        print("USER EXC $e");
      }
      // _faqs = data[1]['data']
      //     .map<FaqWidgetModel>(
      //       (val) =>
      //           FaqWidgetModel(content: val['content'], title: val['title']),
      //     )
      //     .toList();

    }
  }
}
