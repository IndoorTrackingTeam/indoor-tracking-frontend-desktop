// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desktop/screens/password_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Testando tela de Redefinição de Senha', () {
    testWidgets('Deve exibir o título corretamente', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PasswordScreen(),
        ),
      );

      final titleFinder = find.text('Redefinição de senha');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('Deve exibir a descrição corretamente', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PasswordScreen(),
        ),
      );

      final descriptionFinder = find.text(
          'Informe um email e enviaremos um link para redefinir sua senha.');
      expect(descriptionFinder, findsOneWidget);
    });

    testWidgets('Deve exibir o campo de email', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PasswordScreen(),
        ),
      );

      final emailFieldFinder = find.byKey(Key("email_input_field"));
      expect(emailFieldFinder, findsOneWidget);
    });

    testWidgets('Deve exibir o botão de enviar', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PasswordScreen(),
        ),
      );

      final sendButtonFinder = find.byKey(Key("send_recovery_email_button"));
      expect(sendButtonFinder, findsOneWidget);
    });

    testWidgets('Deve exibir erro quando email vazio for enviado',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PasswordScreen(),
        ),
      );

      final sendButtonFinder = find.byKey(Key("send_recovery_email_button"));
      await tester.tap(sendButtonFinder);
      await tester.pumpAndSettle();

      expect(find.text('Por favor, insira um email'), findsOneWidget);
    });

    testWidgets('Deve exibir erro quando email inválido for enviado',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PasswordScreen(),
        ),
      );

      final emailFieldFinder = find.byKey(Key("email_input_field"));
      await tester.enterText(emailFieldFinder, 'emailinvalido');
      await tester.pumpAndSettle();

      final sendButtonFinder = find.byKey(Key("send_recovery_email_button"));
      await tester.tap(sendButtonFinder);
      await tester.pumpAndSettle();

      expect(find.text('Por favor, insira um email válido'), findsOneWidget);
    });
  });
}

class MockNavigatorObserver extends NavigatorObserver {
  final List<Route> pushedRoutes = [];

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    pushedRoutes.add(route);
  }
}
