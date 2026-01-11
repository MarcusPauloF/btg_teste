import 'package:empiricus_teste/features/auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserModel', () {
    const testEmail = 'test@example.com';
    const testName = 'Test User';
    const testToken = 'test_token_123';

    group('fromJson', () {
      test('deve criar um UserModel a partir de um JSON válido', () {
        final json = {
          'email': testEmail,
          'name': testName,
          'token': testToken,
        };

        final result = UserModel.fromJson(json);

        expect(result.email, testEmail);
        expect(result.name, testName);
        expect(result.token, testToken);
      });

      test('deve lançar exceção ao deserializar JSON com campos faltando',
          () {
        final json = {
          'email': testEmail,
          'name': testName,
        };

        expect(
          () => UserModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });

    group('toJson', () {
      test('deve converter UserModel para JSON corretamente', () {
        final user = UserModel(
          email: testEmail,
          name: testName,
          token: testToken,
        );

        final json = user.toJson();

        expect(json['email'], testEmail);
        expect(json['name'], testName);
        expect(json['token'], testToken);
      });
    });

    group('construtor', () {
      test('deve criar uma instância válida de UserModel', () {
        final user = UserModel(
          email: testEmail,
          name: testName,
          token: testToken,
        );

        expect(user.email, testEmail);
        expect(user.name, testName);
        expect(user.token, testToken);
      });
    });
  });
}
