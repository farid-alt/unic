class User {
  String name;
  String surname;
  String profilePicAdress = ' ';
  String fullname;
  String email;
  String phone;
  User(
      {this.name,
      this.surname,
      this.profilePicAdress = ' ',
      this.email,
      this.phone})
      : fullname = '$name $surname';
}
