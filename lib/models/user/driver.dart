class Driver {
  String name, surname, fullname, vehicleNumberId, profilePicAdress, email;
  bool isMoped;
  int id;
  String number;
  double rating;
  int activity;

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
      this.vehicleNumberId});
  factory Driver.fromJson(json) => Driver(
      fullname: json['user']['full_name'],
      email: json['user']['email'],
      number: json['user']['phone'],
      rating: json['rating'],
      profilePicAdress: json['image'],
      //TODO: get adress of picture
      activity: json['activity']);
}
