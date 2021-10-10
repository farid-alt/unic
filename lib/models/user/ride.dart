import 'package:unic_app/models/adress.dart';
import 'package:unic_app/models/user/driver.dart';
import 'package:unic_app/models/user/user.dart';

class Ride {
  User customer;
  Driver driver;
  String startAdress;
  DateTime startTime;
  String endAdress;
  DateTime endTime;
  DateTime rideDate;
  double rideRating;
  String ridePrice;
  // int driverId;
  // String driverName;
  // String driverSurname;
  // String driverPhoto;
  // double driverRating;
  // String driverNumber;
  String paymentMethod;
  String tarrifPrice;
  int rideId;
  Adress startAdressA;
  Adress endAdressA;
  Ride(
      {
      //   this.driverId,
      // this.driverName,
      this.rideId,
      this.driver,
      this.customer,
      // this.driverNumber,
      // this.driverPhoto,
      // this.driverRating,
      // this.driverSurname,
      this.endAdress,
      this.endTime,
      this.paymentMethod,
      this.rideDate,
      this.ridePrice,
      this.rideRating,
      this.startAdress,
      this.tarrifPrice,
      this.startAdressA,
      this.endAdressA,
      this.startTime});
}
