import 'package:stacked/stacked.dart';
import 'package:unic_app/models/user/driver.dart';
import 'package:unic_app/models/user/ride.dart';
import 'package:unic_app/models/user/user.dart';

class SupportViewModel extends BaseViewModel {
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
  ];

  get rides => _rides;
}
