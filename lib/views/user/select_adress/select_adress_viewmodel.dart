import 'package:flutter/material.dart';

class SelectAdressViewModel extends ChangeNotifier {
  TextEditingController _firstAdressController = TextEditingController();
  TextEditingController get firstAdressController =>
      this._firstAdressController;
  List<TextEditingController> _adresses;

  List<TextEditingController> get adresses => this._adresses;
}
