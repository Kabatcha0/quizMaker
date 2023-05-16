class SignUpModel {
  late String email;
  late String password;
  late String name;
  SignUpModel.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    password = json["password"];
    name = json["name"];
  }
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "password": password,
    };
  }
}
