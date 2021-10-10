import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:unic_app/components/api_keys.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/models/user/ride.dart';
import 'package:unic_app/services/web_services.dart';

class RideDetailsViewModel extends ChangeNotifier {
  Ride ride;
  GoogleMapController _mapController;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  RideDetailsViewModel({Ride ride}) {
    this.ride = ride;
    drawPolyline(
      LatLng(ride.startAdressA.lat, ride.startAdressA.lng),
      LatLng(ride.endAdressA.lat, ride.endAdressA.lng),
    );
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

  GoogleMapController get mapController => this._mapController;
  set mapController(controller) {
    this._mapController = controller;
    notifyListeners();
  }

  _addPolyLine({@required LatLng startLatLng}) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: kPrimaryColor,
      points: polylineCoordinates,
      width: 5,
    );
    // _mapController.animateCamera(CameraUpdate.newCameraPosition(
    //     CameraPosition(target: startLatLng, zoom: 12)));
    polylines[id] = polyline;
    notifyListeners();
  }

  sendIssue({rideId, topic, text}) async {
    // print('$_fullname &&& $ID');

    var data = await WebService.postCall(url: SEND_SUPPORT_MESSAGE, data: {
      'customer_id': ID,
      'order_id': rideId.toString(),
      'title': topic,
      'content': text,
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
    if (data[0] == 200) {
      //print(data[1]);
      print('success $data[1]');
    }
    notifyListeners();
    return data[0];
  }
}
