// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_field

import 'package:flutter/material.dart';
import 'package:desktop/api/user_service.dart';
import 'package:desktop/screens/password_screen.dart';
import 'package:desktop/screens/register_screen.dart';
import 'package:desktop/screens/equipaments_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserService userService = UserService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoggedIn = false;
  bool _isLoading = false;
  String _token = '';

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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Coloque seu email, por favor';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Coloque um email válido, por favor';
    }
    return null;
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      String email = _emailController.text;
      String password = _passwordController.text;
      try {
        _token = await userService.signInEmailPassword(email, password);
        await _saveLogin(_token);
        Navigator.of(context)
            .pushReplacement(_createRoute(EquipamentsScreen(_token, 0)));
      } catch (e) {
        if (e.toString().contains('email')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Email não encontrado.'),
              backgroundColor: const Color.fromARGB(255, 143, 20, 11),
            ),
          );
          _emailController.clear();
          _passwordController.clear();
        } else if (e.toString().contains('password')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Senha incorreta.'),
              backgroundColor: const Color.fromARGB(255, 143, 20, 11),
            ),
          );
          _passwordController.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Erro desconhecido: $e. Por favor, entre em contato com o suporte.'),
              backgroundColor: Color.fromARGB(255, 214, 177, 10),
            ),
          );
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _saveLogin(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('logged_in', true);
    await prefs.setString('auth_token', token);
    setState(() {
      _isLoggedIn = true;
      _token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: const Color(0xFF394170),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'INDOOR TRACKING',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.02),
                          Text(
                            'Localizando seus equipamentos para seu hospital',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                    ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.02),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: Color(0xFFF5F7F8),
                            ),
                            child: const Text(
                              'Read More',
                              style: TextStyle(
                                color: Color(0xFF394170),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                  ),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Align(
                    alignment: Alignment.center,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Olá novamente!',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  'Seja bem-vindo.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.02),
                          TextFormField(
                            key: Key("email_field"),
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: _emailValidator,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.01),
                          TextFormField(
                            key: Key("password_field"),
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                color: Color(0xFF394170),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            obscureText: _obscurePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Coloque sua senha, por favor';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.width * 0.005),
                          Row(
                            children: [
                              Checkbox(
                                key: Key("remember_me_key"),
                                value: _rememberMe,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _rememberMe = value ?? false;
                                  });
                                },
                                side: BorderSide(width: 1),
                              ),
                              Expanded(
                                child: Text(
                                  'Lembrar de mim',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Flexible(
                                child: GestureDetector(
                                  key: Key("forgot_password_key"),
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      _createRoute(PasswordScreen()),
                                    );
                                  },
                                  child: Text(
                                    'Esqueceu a senha?',
                                    style: TextStyle(
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.02),
                          OutlinedButton(
                            key: Key("login_button"),
                            onPressed: _login,
                            style: OutlinedButton.styleFrom(
                              minimumSize: Size(double.infinity, 56),
                              maximumSize: Size(double.infinity, 56),
                            ),
                            child: Text('LOGIN'),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.02),
                          GestureDetector(
                            key: Key("register_button"),
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  _createRoute(RegisterScreen()));
                            },
                            child: Text(
                              'Não tem uma conta? Registre-se',
                              style: TextStyle(
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
