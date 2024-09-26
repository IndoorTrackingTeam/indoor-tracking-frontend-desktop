// ignore_for_file:library_private_types_in_public_api, use_build_context_synchronously, unused_local_variable

import 'package:desktop/screens/equipaments_screen.dart';
import 'package:desktop/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  Future<void> _checkLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('logged_in') ?? false;
    await Future.delayed(const Duration(seconds: 2));

    if (isLoggedIn) {
      String token = prefs.getString('auth_token') ?? '';
      Navigator.of(context)
          .pushReplacement(_createRoute(EquipamentsScreen(token, 1)));
    } else {
      Navigator.of(context).pushReplacement(_createRoute(const LoginScreen()));
    }
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeIn;

        var curveTween = CurveTween(curve: curve);
        var fadeAnimation = animation.drive(curveTween);

        return FadeTransition(
          opacity: fadeAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 300,
            ),
            const SizedBox(height: 40),
            const SpinKitCircle(
              color: Color(0xFF394170),
              size: 45.0,
            ),
          ],
        ),
      ),
    );
  }
}
