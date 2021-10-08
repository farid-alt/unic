import 'package:flutter/material.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/services/web_services.dart';

class RideDetailsViewModel extends ChangeNotifier {
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
