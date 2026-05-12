
class UserModel {
  final String id;
  final String email;
  final String? phoneNumber;
  final List<String>? role;

  UserModel({
    required this.id,
    required this.email,
    this.phoneNumber,
    this.role,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      role: (json['roles'] as List<dynamic>?)
          ?.map((role) => role as String)
          .toList(),
    );
  }
}