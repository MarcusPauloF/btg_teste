import 'package:bloc_test/bloc_test.dart';
import 'package:empiricus_teste/features/auth/data/models/user_model.dart';
import 'package:empiricus_teste/features/auth/data/repositories/auth_repository.dart';
import 'package:empiricus_teste/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:empiricus_teste/features/auth/presentation/blocs/auth/auth_event.dart';
import 'package:empiricus_teste/features/auth/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('AuthBloc', () {
    late AuthBloc authBloc;
    late MockAuthRepository mockRepository;

    setUp(() {
      mockRepository = MockAuthRepository();
      authBloc = AuthBloc(mockRepository);
    });

    tearDown(() {
      authBloc.close();
    });

    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    final testUser = UserModel(
      email: testEmail,
      name: 'Test User',
      token: 'test_token',
    );

    group('LoginEvent', () {
      blocTest<AuthBloc, AuthState>(
        'deve emitir [AuthLoading, AuthSuccess] quando o login é bem-sucedido',
        build: () {
          when(() => mockRepository.login(testEmail, testPassword))
              .thenAnswer((_) async => testUser);
          return authBloc;
        },
        act: (bloc) => bloc.add(
          const LoginEvent(
            email: testEmail,
            password: testPassword,
          ),
        ),
        expect: () => [
          isA<AuthLoading>(),
          isA<AuthSuccess>()
              .having((state) => state.user.email, 'email', testEmail)
              .having((state) => state.user.name, 'name', 'Test User')
              .having((state) => state.user.token, 'token', 'test_token'),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'deve emitir [AuthLoading, AuthError] quando o login falha',
        build: () {
          when(() => mockRepository.login(testEmail, testPassword))
              .thenThrow(Exception('Email ou senha inválidos'));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          const LoginEvent(
            email: testEmail,
            password: testPassword,
          ),
        ),
        expect: () => [
          isA<AuthLoading>(),
          isA<AuthError>()
              .having(
                (state) => state.message,
                'message',
                contains('Email ou senha inválidos'),
              ),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'deve chamar repository.login com os parâmetros corretos',
        build: () {
          when(() => mockRepository.login(testEmail, testPassword))
              .thenAnswer((_) async => testUser);
          return authBloc;
        },
        act: (bloc) => bloc.add(
          const LoginEvent(
            email: testEmail,
            password: testPassword,
          ),
        ),
        verify: (_) {
          verify(() => mockRepository.login(testEmail, testPassword))
              .called(1);
        },
      );
    });

    group('LogoutEvent', () {
      blocTest<AuthBloc, AuthState>(
        'deve emitir [AuthLoggedOut, AuthInitial] quando logout é disparado',
        build: () => authBloc,
        act: (bloc) => bloc.add(const LogoutEvent()),
        expect: () => [
          isA<AuthLoggedOut>(),
          isA<AuthInitial>(),
        ],
      );
    });

    group('AuthBloc initialization', () {
      test('estado inicial deve ser AuthInitial', () {
        expect(authBloc.state, isA<AuthInitial>());
      });
    });
  });
}
