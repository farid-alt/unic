import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/models/adress.dart';
import 'package:http/http.dart' as http;

class SelectAdressViewModel extends BaseViewModel {
  int activeTextfield;
  Adress _firstAdress = Adress();
  Adress get firstAdress => this._firstAdress;
  final TextEditingController textEditingController1 = TextEditingController();

  set firstAdressName(value) {
    this._firstAdress.nameOfPlace = value;
    _firstAdress.callback = () => notifyListeners();
    notifyListeners();
  }

  List<Adress> _suggestedAdresses = [];
  set firstAdress(value) {
    this._firstAdress = value;
    notifyListeners();
  }

  List<TextEditingController> controllers = [TextEditingController()];
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

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyCpl9GHLXYw-u-VALEYNyDVAueci3mQxuM";
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&country=az';
    var response = await http.get(Uri.parse(request));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      // List predictions = json.decode(response.body)['predictions'];
      _suggestedAdresses = parseSuggestions(json.decode(response.body));
      notifyListeners();
      // setState(() {
      //   _placeList = json.decode(response.body)['predictions'];
      //   print(_placeList);
      // });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  List<Adress> parseSuggestions(Map data) {
    // final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    try {
      return data['predictions']
          .map<Adress>((json) => Adress.fromJson(json))
          .toList();
    } catch (e) {
      print(e);
    }
  }
}
