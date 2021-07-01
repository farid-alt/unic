class User {
  String name;
  String surname;
  String profilePicAdress = ' ';
  String fullname;
  String email;
  String homeAdress;
  String workAdress;
  String phone;
  int id;

  User(
      {this.name,
      this.id,
      this.surname,
      this.homeAdress,
      this.workAdress,
      this.profilePicAdress = ' ',
      this.email,
      this.phone})
      : fullname = '$name $surname';
}
