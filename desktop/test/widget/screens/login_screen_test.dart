// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desktop/screens/login_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Testando tela de Login.', () {
    group('Testando o carregamento dos widgets da tela.', () {
      testWidgets('Deve ser exibido o campo de email corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: LoginScreen(),
          ),
        );

        final emailField = find.byKey(Key('email_field'));

        expect(emailField, findsOneWidget);
      });

      testWidgets('Deve ser exibido o campo de senha corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: LoginScreen(),
          ),
        );

        final passwordField = find.byKey(Key('password_field'));

        expect(passwordField, findsOneWidget);
      });

      testWidgets(
          'Deve ser exibido o campo de lembrar de mim corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: LoginScreen(),
          ),
        );

        final rememberMeKey = find.byKey(Key('remember_me_key'));

        expect(rememberMeKey, findsOneWidget);
      });

      testWidgets(
          'Deve ser exibido o botão esqueci minha senha corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: LoginScreen(),
          ),
        );

        final forgotPasswordKey = find.byKey(Key('forgot_password_key'));

        expect(forgotPasswordKey, findsOneWidget);
      });

      testWidgets('Deve ser exibido o botão de login corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: LoginScreen(),
          ),
        );

        final loginButton = find.byKey(Key('login_button'));

        expect(loginButton, findsOneWidget);
      });

      testWidgets('Deve ser exibido o botão de registrar corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: LoginScreen(),
          ),
        );

        final registerButton = find.byKey(Key('register_button'));

        expect(registerButton, findsOneWidget);
      });
    });
  });
}
