import 'package:unic_app/models/adress.dart';

class User {
  String name;
  String surname;
  String profilePicAdress = ' ';
  String fullname;
  String email;
  Adress homeAdress;
  Adress workAdress;
  String phone;
  int id;
  Adress lastAdress;

  User(
      {this.name,
      this.id,
      this.surname,
      this.homeAdress,
      this.workAdress,
      this.profilePicAdress = ' ',
      this.email,
      this.lastAdress,
      this.phone})
      : fullname = '$name $surname';
}
