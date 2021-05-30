class Driver {
  String name, surname, fullname, vehicleNumberId, profilePicAdress;
  bool isMoped;
  int id;
  String number;
  double rating;

  Driver(
      {this.name,
      this.surname,
      this.id,
      this.isMoped,
      this.profilePicAdress,
      this.number,
      this.rating,
      this.vehicleNumberId})
      : fullname = '$name $surname';
}
