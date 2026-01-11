class UserModel {
  final String email;
  final String name;
  final String token;

  UserModel({
    required this.email,
    required this.name,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] as String,
      name: json['name'] as String,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'token': token,
    };
  }
}
