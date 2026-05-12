class ChangeRoleModel {
  String? userEmail;
  String? newRole;

  ChangeRoleModel({this.userEmail, this.newRole});

  factory ChangeRoleModel.fromJson(Map<String, dynamic> json) {
    return ChangeRoleModel(
      userEmail: json['userEmail'],
      newRole: json['newRole'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'newRole': newRole,
    };
  }
}