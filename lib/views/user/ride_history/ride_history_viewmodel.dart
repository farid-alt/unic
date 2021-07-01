import 'package:flutter/material.dart';
import 'package:unic_app/models/user/driver.dart';
import 'package:unic_app/models/user/ride.dart';
import 'package:unic_app/models/user/user.dart';
import 'package:unic_app/services/web_services.dart';

import '../../../endpoints.dart';

class RideHistoryViewModel extends ChangeNotifier {
  Future getRidehistory;
  RideHistoryViewModel() {
    getRidehistory = _getRideHistoryApi();
  }
  List<Ride> _rides = [
    Ride(
      rideId: 66,
      customer: User(
          email: 'rustamazizov@gmail.com',
          name: 'Rustam',
          surname: 'Azizov',
          phone: '+994552768495',
          id: 1116),
      startAdress: 'Q.Qarayev metro',
      startTime: DateTime(2021, 05, 23, 18, 40),
      endAdress: '28 may 1',
      driver: Driver(
          id: 11,
          name: 'Rustam',
          surname: 'Azizov',
          isMoped: true,
          profilePicAdress:
              'https://static.1tv.ru/uploads/photo/image/2/huge/4062_huge_876c41f50e.jpg',
          rating: 4,
          number: '+994552768495'),
      endTime: DateTime(2021, 05, 23, 19, 05),
      paymentMethod: 'cash'.toUpperCase(),
      rideDate: DateTime(2021, 05, 23),
      ridePrice: 5,
      rideRating: 4.5,
    ),
    Ride(
      rideId: 66,
      customer: User(
          email: 'rustamazizov@gmail.com',
          name: 'Rustam',
          surname: 'Azizov',
          phone: '+994552768495',
          id: 1116),
      startAdress: 'Q.Qarayev metro',
      startTime: DateTime(2021, 05, 23, 18, 40),
      endAdress: '28 may 2',
      driver: Driver(
          id: 11,
          name: 'Rustam',
          surname: 'Azizov',
          isMoped: false,
          profilePicAdress:
              'https://static.1tv.ru/uploads/photo/image/2/huge/4062_huge_876c41f50e.jpg',
          rating: 4,
          number: '+994552768495'),
      endTime: DateTime(2021, 05, 23, 19, 05),
      paymentMethod: 'cash'.toUpperCase(),
      rideDate: DateTime(2021, 05, 23),
      ridePrice: 5,
      rideRating: 4.5,
    ),
    Ride(
      rideId: 66,
      customer: User(
          email: 'rustamazizov@gmail.com',
          name: 'Rustam',
          surname: 'Azizov',
          phone: '+994552768495',
          id: 1116),
      startAdress: 'Q.Qarayev metro',
      startTime: DateTime(2021, 05, 23, 18, 40),
      endAdress: '28 may 3',
      driver: Driver(
          id: 11,
          name: 'Rustam',
          surname: 'Azizov',
          isMoped: false,
          profilePicAdress:
              'https://static.1tv.ru/uploads/photo/image/2/huge/4062_huge_876c41f50e.jpg',
          rating: 4,
          number: '+994552768495'),
      endTime: DateTime(2021, 05, 23, 19, 05),
      paymentMethod: 'cash'.toUpperCase(),
      rideDate: DateTime(2021, 05, 23),
      ridePrice: 5,
      rideRating: 4.5,
    ),
    Ride(
      rideId: 66,
      customer: User(
          email: 'rustamazizov@gmail.com',
          name: 'Rustam',
          surname: 'Azizov',
          phone: '+994552768495',
          id: 1116),
      startAdress: 'Q.Qarayev metro',
      startTime: DateTime(2021, 05, 23, 18, 40),
      endAdress: '28 may 4',
      driver: Driver(
          id: 11,
          name: 'Rustam',
          surname: 'Azizov',
          isMoped: false,
          profilePicAdress:
              'https://static.1tv.ru/uploads/photo/image/2/huge/4062_huge_876c41f50e.jpg',
          rating: 4,
          number: '+994552768495'),
      endTime: DateTime(2021, 05, 23, 19, 05),
      paymentMethod: 'cash'.toUpperCase(),
      rideDate: DateTime(2021, 05, 23),
      ridePrice: 5,
      rideRating: 4.5,
    ),
    Ride(
      rideId: 66,
      customer: User(
          email: 'rustamazizov@gmail.com',
          name: 'Rustam',
          surname: 'Azizov',
          phone: '+994552768495',
          id: 1116),
      startAdress: 'Q.Qarayev metro',
      startTime: DateTime(2021, 05, 23, 18, 40),
      endAdress: '28 may',
      driver: Driver(
          id: 11,
          name: 'Rustam',
          surname: 'Azizov',
          isMoped: false,
          profilePicAdress:
              'https://static.1tv.ru/uploads/photo/image/2/huge/4062_huge_876c41f50e.jpg',
          rating: 4,
          number: '+994552768495'),
      endTime: DateTime(2021, 05, 23, 19, 05),
      paymentMethod: 'cash'.toUpperCase(),
      rideDate: DateTime(2021, 05, 23),
      ridePrice: 5,
      rideRating: 4.5,
    ),
    Ride(
      rideId: 66,
      customer: User(
          email: 'rustamazizov@gmail.com',
          name: 'Rustam',
          surname: 'Azizov',
          phone: '+994552768495',
          id: 1116),
      startAdress: 'Q.Qarayev metro',
      startTime: DateTime(2021, 05, 23, 18, 40),
      endAdress: '28 may',
      driver: Driver(
          id: 11,
          name: 'Rustam',
          surname: 'Azizov',
          isMoped: false,
          profilePicAdress:
              'https://static.1tv.ru/uploads/photo/image/2/huge/4062_huge_876c41f50e.jpg',
          rating: 4,
          number: '+994552768495'),
      endTime: DateTime(2021, 05, 23, 19, 05),
      paymentMethod: 'cash'.toUpperCase(),
      rideDate: DateTime(2021, 05, 23),
      ridePrice: 5,
      rideRating: 4.5,
    ),
  ];

  get rides => _rides;

  _getRideHistoryApi() async {
    var data = await WebService.getCall(
        url: 'http://unik.neostep.az/api/customer/ride-histories?id=$ID',
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $TOKEN'
        });
    if (data[0] == 200) {
      print(data);
      // _rides = data[1]['data']
      //     .map<Ride>(
      //       (val) =>
      //           Ride(
      //            rideId: data[1]['data']['id'],
      //             rideDate: data[1]['data']['date'],
      //             startAdress: data[1]['data']['destinations'][0],
      //             endAdress: data[1]['data']['destinations'][1],
      //             customer: User(
      //               id:
      //             )
      //           ),
      //     )
      //     .toList();
      // _faqs = data[1]['data']
      //     .map<FaqWidgetModel>(
      //       (val) =>
      //           FaqWidgetModel(content: val['content'], title: val['title']),
      //     )
      //     .toList();
    }
  }
}
