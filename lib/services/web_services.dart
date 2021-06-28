import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WebService {
  static Future postCall(
      {@required String url, @required data, headers}) async {
    try {
      var response;
      response = await http.post(Uri.parse(url), headers: headers, body: data);

      print(response.statusCode);
      print(json.decode(response.body));
      // if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.

      return [response.statusCode, json.decode(response.body)];
      // return response;
      // } else {
      //   // If that call was not successful, throw an error.
      //   throw Exception('Failed to load post');
      // }
    } catch (e) {
      print("EXCEPTION ${e}");
    }
  }

  static Future getCall({@required String url, headers}) async {
    try {
      var response;
      response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      // print(response.statusCode);
      // print(json.decode(response.body));
      // if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.

      return [response.statusCode, json.decode(response.body)];
      // return response;
      // } else {
      //   // If that call was not successful, throw an error.
      //   throw Exception('Failed to load post');
      // }
    } catch (e) {
      print("EXCEPTION ${e}");
    }
  }
}
