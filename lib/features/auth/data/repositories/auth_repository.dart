import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepository(this.remoteDatasource);

  Future<UserModel> login(String email, String password) async {
    try {
      return await remoteDatasource.login(email, password);
    } catch (e) {
      rethrow;
    }
  }
}
