import 'package:empiricus_teste/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:empiricus_teste/features/auth/data/models/user_model.dart';
import 'package:empiricus_teste/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDatasource extends Mock implements AuthRemoteDatasource {}

void main() {
  group('AuthRepository', () {
    late AuthRepository repository;
    late MockAuthRemoteDatasource mockDatasource;

    setUp(() {
      mockDatasource = MockAuthRemoteDatasource();
      repository = AuthRepository(mockDatasource);
    });

    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    final testUser = UserModel(
      email: testEmail,
      name: 'Test User',
      token: 'test_token',
    );

    group('login', () {
      test('deve retornar um UserModel quando o datasource retorna com sucesso',
          () async {
        when(() => mockDatasource.login(testEmail, testPassword))
            .thenAnswer((_) async => testUser);

        final result = await repository.login(testEmail, testPassword);

        expect(result, testUser);
        expect(result.email, testEmail);
        verify(() => mockDatasource.login(testEmail, testPassword)).called(1);
      });

      test('deve lançar exceção quando o datasource lança uma exceção',
          () async {
        when(() => mockDatasource.login(testEmail, testPassword))
            .thenThrow(Exception('Email ou senha inválidos'));

        expect(
          () => repository.login(testEmail, testPassword),
          throwsA(isA<Exception>()),
        );
        verify(() => mockDatasource.login(testEmail, testPassword)).called(1);
      });

      test('deve chamar o datasource com os parâmetros corretos', () async {
        when(() => mockDatasource.login(testEmail, testPassword))
            .thenAnswer((_) async => testUser);

        await repository.login(testEmail, testPassword);

        verify(() => mockDatasource.login(testEmail, testPassword)).called(1);
      });
    });
  });
}
