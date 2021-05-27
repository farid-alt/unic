class Ride {
  String startAdress;
  DateTime startTime;
  String endAdress;
  DateTime endTime;
  DateTime rideDate;
  double rideRating;
  double ridePrice;
  int driverId;
  String driverName;
  String driverSurname;
  String driverPhoto;
  double driverRating;
  String driverNumber;
  String paymentMethod;
  int rideId;
  Ride(
      {this.driverId,
      this.driverName,
      this.rideId,
      this.driverNumber,
      this.driverPhoto,
      this.driverRating,
      this.driverSurname,
      this.endAdress,
      this.endTime,
      this.paymentMethod,
      this.rideDate,
      this.ridePrice,
      this.rideRating,
      this.startAdress,
      this.startTime});
}
