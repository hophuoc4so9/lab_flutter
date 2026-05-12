class ChangePasswordModel {
  String email;
  String currentPassword;
  String newPassword;

  ChangePasswordModel({
    required this.email,
    required this.currentPassword,
    required this.newPassword,
  });
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };
  }
}