class Driver {
  String name, surname, fullname, vehicleNumberId, profilePicAdress, email;
  bool isMoped;
  int id;
  String number;
  double rating;
  int activity;
  double lat;
  double lng;

  Driver(
      {this.name,
      this.email,
      this.surname,
      this.id,
      this.isMoped,
      this.profilePicAdress,
      this.number,
      this.rating,
      this.fullname,
      this.activity,
      this.vehicleNumberId,
      this.lat,
      this.lng});
  factory Driver.fromJson(json) {
    try {
      return Driver(
          fullname: json['user']['full_name'],
          email: json['user']['email'],
          number: json['user']['phone'],
          rating: double.parse(json['rating'].toString()),
          profilePicAdress: json['image'],
          //TODO: get adress of picture
          activity: json['activity']);
    } catch (e) {
      print("EXCEPTION $e");
    }
  }
}
