class User {
  String name;
  String surname;
  String profilePicAdress = ' ';
  String fullname;
  String email;
  String phone;
  int id;
  User(
      {this.name,
      this.id,
      this.surname,
      this.profilePicAdress = ' ',
      this.email,
      this.phone})
      : fullname = '$name $surname';
}
