// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desktop/screens/login_screen.dart';

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

  group('Testando tela de Login.', () {
    testWidgets(
        'Deve pedir que o usuario coloque o email ao clicar no botão de login com o campo de email vazio.',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
        ),
      );

      final emailField = find.byKey(Key('email_field'));
      final passwordField = find.byKey(Key('password_field'));
      final loginButton = find.byKey(Key('login_button'));

      await tester.enterText(emailField, '');
      await tester.enterText(passwordField, '1234');
      await tester.pumpAndSettle();

      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      expect(find.text('Coloque seu email, por favor'), findsOne);
    });

    testWidgets(
        'Deve pedir que o usuario coloque a senha ao clicar no botão de login com o campo de senha vazio.',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
        ),
      );

      final emailField = find.byKey(Key('email_field'));
      final passwordField = find.byKey(Key('password_field'));
      final loginButton = find.byKey(Key('login_button'));

      await tester.enterText(emailField, 'teste@email.com');
      await tester.enterText(passwordField, '');
      await tester.pumpAndSettle();

      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      expect(find.text('Coloque sua senha, por favor'), findsOne);
    });

    testWidgets(
        'Deve ir para a pagina de redefinir senha ao clicar no botão de esqueci minha senha.',
        (tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
          navigatorObservers: [mockObserver],
        ),
      );

      final forgotPasswordKey = find.byKey(Key('forgot_password_key'));
      await tester.tap(forgotPasswordKey);
      await tester.pumpAndSettle();

      expect(mockObserver.pushedRoutes.length, greaterThan(0));
    });

    testWidgets(
        'Deve ir para a pagina de registro ao clicar no botão de registrar.',
        (tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
          navigatorObservers: [mockObserver],
        ),
      );

      final registerButton = find.byKey(Key('register_button'));
      await tester.tap(registerButton);
      await tester.pumpAndSettle();

      expect(mockObserver.pushedRoutes.length, greaterThan(0));
    });

    testWidgets(
        'Deve mudar o estado do checkbox ao clicar no texto de lembrar de mim.',
        (tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
          navigatorObservers: [mockObserver],
        ),
      );

      final rememberMeKey = find.byKey(Key('remember_me_key'));
      await tester.tap(rememberMeKey);
      await tester.pumpAndSettle();
      final rememberMe = tester.widget<Checkbox>(rememberMeKey);
      expect(rememberMe.value, true);
    });
  });
}
