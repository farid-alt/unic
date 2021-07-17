import 'dart:collection';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/primary_button.dart';
import 'package:unic_app/views/user/choose_adress_map/choose_adress_map_viewmodel.dart';
import 'package:unic_app/views/user/enter%20promo/enter_promo_viewmodel.dart';

class TakeAdress extends StatefulWidget {
  TakeAdress({this.location});
  String location;
  @override
  _TakeAdressState createState() => _TakeAdressState();
}

class _TakeAdressState extends State<TakeAdress> {
  GoogleMapController _mapController;

  Set<Marker> _markers = HashSet<Marker>();

  bool myPosition = true;

  String adress = '';

  LatLng newMarkerPosition;

  LatLng myPositionGeo;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    TextEditingController _textController = TextEditingController();

    return ViewModelBuilder<TakeAdressViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: size.height,
          width: size.width,
          child: FutureBuilder(
              future: GeolocatorPlatform.instance
                  .getCurrentPosition()
                  .catchError((e) {
                print(e);
              }),
              builder: (context, AsyncSnapshot<Position> snapshot) {
                if (snapshot.hasData) {
                  return Stack(
                    children: [
                      GoogleMap(
                        onCameraIdle: () {
                          Geocoder.local
                              .findAddressesFromCoordinates(Coordinates(
                            newMarkerPosition.latitude,
                            newMarkerPosition.longitude,
                          ))
                              .then((value) {
                            print(value.first.addressLine);
                            setState(() {
                              adress = value.first.addressLine;
                            });
                          });
                        },
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        onCameraMove: ((_position) =>
                            _updatePosition(_position)),
                        markers: _markers,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(snapshot.data.latitude,
                                snapshot.data.longitude),
                            zoom: 15),
                        onMapCreated: (controller) {
                          _mapController = controller;
                          newMarkerPosition = LatLng(
                              snapshot.data.latitude, snapshot.data.longitude);
                          Geocoder.local
                              .findAddressesFromCoordinates(Coordinates(
                                  snapshot.data.latitude,
                                  snapshot.data.longitude))
                              .then((value) {
                            print(value.first.addressLine);
                            setState(() {
                              adress = value.first.addressLine;
                            });
                          });
                          _markers.add(
                            Marker(
                              markerId: MarkerId('1'),
                              position: LatLng(snapshot.data.latitude,
                                  snapshot.data.longitude),
                            ),
                          );
                          setState(() {});
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 100),
                          child: PrimaryButton(
                            color: kPrimaryColor,
                            title: '$adress',
                            size: size,
                            textColor: Colors.white,
                            function: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      )
                    ],
                  );
                }
                return CircularProgressIndicator();
              }),
        ),
      ),
      viewModelBuilder: () => TakeAdressViewModel(),
    );
  }

  void _updatePosition(CameraPosition _position) {
    newMarkerPosition =
        LatLng(_position.target.latitude, _position.target.longitude);
    _markers.clear();

    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      double distanceInMeters = Geolocator.distanceBetween(
          _position.target.latitude,
          _position.target.longitude,
          value.latitude,
          value.longitude);
      print(distanceInMeters);
      if (distanceInMeters > 70) {
        setState(() {
          myPosition = false;

          // print("${first.featureName} : ${first.addressLine}");
        });
      } else {
        setState(() {
          myPosition = true;
        });
      }
    });

    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('1'),
          position:
              LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude)));
    });
  }
}
