class User {
  late String key;
  late String email = "";
  late String name;
  late String mobileNo;

  User(this.key, this.email, this.name, this.mobileNo);

  bool _validateSession() {
    if (email != "") {
      return true;
    } else {
      return false;
    }
  }
}