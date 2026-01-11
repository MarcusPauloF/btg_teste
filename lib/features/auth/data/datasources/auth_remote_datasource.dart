import '../models/user_model.dart';

class AuthRemoteDatasource {
  static const String _fixedEmail = '	teste@empiricus.com.br';
  static const String _fixedPassword = '123456';
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
