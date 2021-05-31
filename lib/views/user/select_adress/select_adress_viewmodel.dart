import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/models/adress.dart';

class SelectAdressViewModel extends BaseViewModel {
  Adress _firstAdress = Adress();
  Adress get firstAdress => this._firstAdress;
  List<Adress> _suggestedAdresses = [
    Adress(nameOfPlace: 'Genclik Mall', adress: 'Ahmed Rajabli'),
    Adress(nameOfPlace: 'Genclik Mall', adress: 'Ahmed Rajabli'),
    Adress(nameOfPlace: 'Genclik Mall', adress: 'Ahmed Rajabli'),
  ];
  set firstAdress(value) {
    this._firstAdress = value;
    notifyListeners();
  }

  List<Adress> _adresses = [Adress()];

  List<Adress> get adresses => this._adresses;

  addAdress() {
    _adresses.add(Adress());
    notifyListeners();
  }

  deleteAdress(index) {
    _adresses.removeAt(index);
    notifyListeners();
  }

  List<Adress> get suggestedAdresses => this._suggestedAdresses;
}
