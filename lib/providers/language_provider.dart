import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unic_app/endpoints.dart';

class LanguageProvider extends ChangeNotifier {
  int _index = 0;
  setIndex(val) {
    this._index = val;
    notifyListeners();
  }

  int get index => this._index;
  String _language;
  SharedPreferences prefs;

  String get language => _language;
  set language(String lang) {
    _language = lang;
    LANGUAGE = lang;
    _saveToPrefs(_language);
    notifyListeners();
  }

  _initPrefs() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    if (!prefs.containsKey('language')) {
      prefs.setString('language', 'az');
    }
    _language = prefs.getString('language');

    notifyListeners();
  }

  _saveToPrefs(String lang) async {
    await _initPrefs();
    prefs.setString('language', lang);
    notifyListeners();
  }

  LanguageProvider() {
    _language = 'en';
    _loadFromPrefs();
  }
}
