// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desktop/screens/password_screen.dart';
import 'package:desktop/api/user_service.dart';

class MockUserService extends UserService {
  @override
  Future<String> sendEmailRedefinePassword(String email) async {
    if (email == 'valid@email.com') {
      return 'Email enviado com sucesso';
    } else {
      throw Exception('Erro ao enviar email');
    }
  }
}

class MockNavigatorObserver extends NavigatorObserver {
  final List<Route> pushedRoutes = [];

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    pushedRoutes.add(route);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Testando a tela de Redefinição de Senha', () {
    testWidgets('Deve exibir erro ao enviar email inválido', (tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: PasswordScreen(),
          navigatorObservers: [mockObserver],
        ),
      );

      final emailFieldFinder = find.byKey(Key("email_input_field"));
      await tester.enterText(emailFieldFinder, 'invalid-email');
      await tester.pumpAndSettle();

      final sendButtonFinder = find.byKey(Key("send_recovery_email_button"));
      await tester.tap(sendButtonFinder);
      await tester.pumpAndSettle();

      expect(find.text('Por favor, insira um email válido'), findsOneWidget);
    });

    testWidgets('Deve exibir erro ao enviar email vazio', (tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: PasswordScreen(),
          navigatorObservers: [mockObserver],
        ),
      );

      final sendButtonFinder = find.byKey(Key("send_recovery_email_button"));
      await tester.tap(sendButtonFinder);
      await tester.pumpAndSettle();

      expect(find.text('Por favor, insira um email'), findsOneWidget);
    });
  });
}
