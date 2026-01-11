import '../models/user_model.dart';

class AuthRemoteDatasource {
  static const String _fixedEmail = 'admin@example.com';
  static const String _fixedPassword = 'password123';
  static const String _fixedToken = 'token_abc123xyz';

  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email == _fixedEmail && password == _fixedPassword) {
      return UserModel(
        email: email,
        name: 'Admin User',
        token: _fixedToken,
      );
    }

    throw Exception('Email ou senha inválidos');
  }
}
