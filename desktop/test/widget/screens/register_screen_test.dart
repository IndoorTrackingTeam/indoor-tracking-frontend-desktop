// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desktop/screens/register_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Testando tela de Registro', () {
    group('Testando o carregamento dos widgets da tela.', () {
      testWidgets('Deve ser exibido o texto de inicio corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: RegisterScreen(),
          ),
        );

        final welcomeText = find.byKey(Key('welcome_text'));

        expect(welcomeText, findsOneWidget);
      });

      testWidgets(
          'Deve ser exibido o texto de instruções corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: RegisterScreen(),
          ),
        );

        final registerText = find.byKey(Key('register_text'));

        expect(registerText, findsOneWidget);
      });

      testWidgets('Deve ser exibido o campo de nome corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: RegisterScreen(),
          ),
        );

        final nameField = find.byKey(Key('name_field'));

        expect(nameField, findsOneWidget);
      });

      testWidgets('Deve ser exibido o campo de email corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: RegisterScreen(),
          ),
        );

        final emailField = find.byKey(Key('email_field'));

        expect(emailField, findsOneWidget);
      });

      testWidgets('Deve ser exibido o campo de senha corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: RegisterScreen(),
          ),
        );

        final passwordField = find.byKey(Key('password_field'));

        expect(passwordField, findsOneWidget);
      });

      testWidgets('Deve ser exibido o botão de cadastrar corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: RegisterScreen(),
          ),
        );

        final registerButton = find.byKey(Key('register_button'));

        expect(registerButton, findsOneWidget);
      });

      testWidgets(
          'Deve ser exibido o botão de ir para o login corretamente na tela.',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: RegisterScreen(),
          ),
        );

        final haveAccountButton = find.byKey(Key('have_account_button'));

        expect(haveAccountButton, findsOneWidget);
      });
    });
  });
}
