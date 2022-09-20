class User {
  late String firstname;
  late String lastname;
  late String phonenumber;

  User({required String firstname}) {
    this.firstname = firstname;
    lastname = "";
    phonenumber = "";
  }
  static User fromJson(Map<String, dynamic> json) =>
      User(firstname: json['firstname']);
}
