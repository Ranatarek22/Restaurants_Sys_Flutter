
class UserModel {
  final String id;
  final String name;
  final String? gender;
  final String email;
  final int level;
  final String role;
  final String password;

  UserModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.email,
    required this.level,
    required this.password,
    required this.role,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        email = json["email"],
        password = json["password"],
        gender = json["gender"],
        role = json["role"],
        level = json["level"];

  @override
  String toString() {
    return 'User{id: $id, name: $name, role: $role, email: $email, gender: $gender, level: $level}';
  }
}
