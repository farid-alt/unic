import 'dart:ui';

import 'package:geocoder/geocoder.dart';

class Adress {
  String nameOfPlace;
  // String adress;
  double lng;
  double lat;
  VoidCallback callback;
  Adress({this.lat, this.lng, this.nameOfPlace, this.callback});

  factory Adress.fromJson(value) {
    return Adress(
      nameOfPlace: value['description'],
      // adress: value['structured_formatting']['secondary_text'],
    );
  }
}
