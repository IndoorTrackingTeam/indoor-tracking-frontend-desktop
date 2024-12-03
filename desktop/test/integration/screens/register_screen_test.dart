// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desktop/screens/register_screen.dart';

class MockNavigatorObserver extends NavigatorObserver {
  List<Route> pushedRoutes = [];

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    pushedRoutes.add(route);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Testando tela de Registro', () {
    testWidgets(
        'Deve pedir que o usuario coloque o nome ao clicar no botão de cadastro com o campo de nome vazio.',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RegisterScreen(),
        ),
      );

      final nameField = find.byKey(Key('name_field'));
      final emailField = find.byKey(Key('email_field'));
      final passwordField = find.byKey(Key('password_field'));
      final registerButton = find.byKey(Key('register_button'));

      await tester.enterText(nameField, '');
      await tester.enterText(emailField, 'teste@email.com');
      await tester.enterText(passwordField, '123456');
      await tester.pumpAndSettle();

      await tester.tap(registerButton);
      await tester.pumpAndSettle();

      expect(find.text('Coloque seu nome, por favor'), findsOne);
    });

    testWidgets(
        'Deve pedir que o usuario coloque o email ao clicar no botão de cadastro com o campo de email vazio.',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RegisterScreen(),
        ),
      );

      final nameField = find.byKey(Key('name_field'));
      final emailField = find.byKey(Key('email_field'));
      final passwordField = find.byKey(Key('password_field'));
      final registerButton = find.byKey(Key('register_button'));

      await tester.enterText(nameField, 'teste');
      await tester.enterText(emailField, '');
      await tester.enterText(passwordField, '123456');
      await tester.pumpAndSettle();

      await tester.tap(registerButton);
      await tester.pumpAndSettle();

      expect(find.text('Coloque seu email, por favor'), findsOne);
    });

    testWidgets(
        'Deve pedir que o usuario coloque a senha ao clicar no botão de cadastro com o campo de senha vazio.',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RegisterScreen(),
        ),
      );

      final nameField = find.byKey(Key('name_field'));
      final emailField = find.byKey(Key('email_field'));
      final passwordField = find.byKey(Key('password_field'));
      final registerButton = find.byKey(Key('register_button'));

      await tester.enterText(nameField, 'teste');
      await tester.enterText(emailField, 'teste@email.com');
      await tester.enterText(passwordField, '');
      await tester.pumpAndSettle();

      await tester.tap(registerButton);
      await tester.pumpAndSettle();

      expect(find.text('Coloque sua senha, por favor'), findsOne);
    });

    testWidgets(
        'Deve pedir que o usuario coloque o email corretamente ao digitar um email inválido.',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RegisterScreen(),
        ),
      );

      final nameField = find.byKey(Key('name_field'));
      final emailField = find.byKey(Key('email_field'));
      final passwordField = find.byKey(Key('password_field'));
      final registerButton = find.byKey(Key('register_button'));

      await tester.enterText(nameField, 'teste');
      await tester.enterText(emailField, 'teste@email');
      await tester.enterText(passwordField, '123456');
      await tester.pumpAndSettle();

      await tester.tap(registerButton);
      await tester.pumpAndSettle();

      expect(find.text('Coloque um email válido, por favor'), findsOne);
    });

    testWidgets(
        'Deve ir para a pagina de login ao clicar no botão de "já tenho uma conta".',
        (tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: RegisterScreen(),
          navigatorObservers: [mockObserver],
        ),
      );

      final haveAccountButton = find.byKey(Key('have_account_button'));
      await tester.tap(haveAccountButton);
      await tester.pumpAndSettle();

      expect(mockObserver.pushedRoutes.length, greaterThan(0));
    });
  });
}
