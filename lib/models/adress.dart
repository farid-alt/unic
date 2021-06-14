import 'dart:ui';

class Adress {
  String nameOfPlace;
  String adress;
  double lng;
  double lat;
  VoidCallback callback;
  Adress({this.lat, this.lng, this.nameOfPlace, this.adress, this.callback});

  factory Adress.fromJson(value) => Adress(
        nameOfPlace: value['structured_formatting']['main_text'],
        adress: value['structured_formatting']['secondary_text'],
      );
}
