import 'package:empiricus_teste/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:empiricus_teste/features/auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthRemoteDatasource', () {
    late AuthRemoteDatasource datasource;

    setUp(() {
      datasource = AuthRemoteDatasource();
    });

    group('login', () {
      test('deve retornar um UserModel quando as credenciais são válidas',
          () async {
        const email = 'teste@empiricus.com.br';
        const password = '123456';

        final result = await datasource.login(email, password);

        expect(result, isA<UserModel>());
        expect(result.email, email);
        expect(result.name, 'Admin User');
        expect(result.token, 'token_abc123xyz');
      });

      test('deve lançar exceção quando o email é inválido', () async {
        const email = 'wrong@example.com';
        const password = 'password123';

        expect(
          () => datasource.login(email, password),
          throwsA(isA<Exception>()),
        );
      });

      test('deve lançar exceção quando a senha é inválida', () async {
        const email = 'admin@example.com';
        const password = 'wrongpassword';

        expect(
          () => datasource.login(email, password),
          throwsA(isA<Exception>()),
        );
      });

      test('deve lançar exceção quando email e senha estão incorretos',
          () async {
        const email = 'wrong@example.com';
        const password = 'wrongpassword';

        expect(
          () => datasource.login(email, password),
          throwsA(isA<Exception>()),
        );
      });

      test(
          'deve lançar exceção com mensagem correta quando credenciais são inválidas',
          () async {
        const email = 'test@example.com';
        const password = 'test123';

        try {
          await datasource.login(email, password);
          fail('Esperava uma exceção');
        } catch (e) {
          expect(e.toString(), contains('Email ou senha inválidos'));
        }
      });
    });
  });
}
