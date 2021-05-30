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
  double ridePrice;
  // int driverId;
  // String driverName;
  // String driverSurname;
  // String driverPhoto;
  // double driverRating;
  // String driverNumber;
  String paymentMethod;
  int rideId;
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
      this.startTime});
}
