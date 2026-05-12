class RegisterModel {
  String email;
  String password;
  String phoneNumber;

  RegisterModel({
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
    };
  }
}