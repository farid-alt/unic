import 'package:flutter/material.dart';
import 'package:unic_app/models/user/ride.dart';

class RideHistoryViewModel extends ChangeNotifier {
  List<Ride> _rides = [
    Ride(
      rideId: 66,
      startAdress: 'Q.Qarayev metro',
      endAdress: '28 may',
      paymentMethod: 'cash'.toUpperCase(),
      rideDate: DateTime(2021, 05, 23),
      ridePrice: 5,
      rideRating: 4.5,
    ),
    Ride(
      rideId: 67,
      startAdress: 'To the moon',
      endAdress: 'and back',
      paymentMethod: 'visa'.toUpperCase(),
      rideDate: DateTime(2021, 05, 19),
      ridePrice: 8.7,
      rideRating: 4.5,
    ),
  ];

  get rides => _rides;
}
