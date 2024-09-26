// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_field

import 'package:flutter/material.dart';
import 'package:desktop/api/user_service.dart';
import 'package:desktop/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  UserService userService = UserService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

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

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      String name = _nameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      try {
        await userService.signUpEmailPassword(name, password, email);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      } catch (e) {
        if (e.toString().contains('email')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Email já cadastrado.'),
              backgroundColor: const Color.fromARGB(255, 143, 20, 11),
            ),
          );
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
                                  key: Key("welcome_text"),
                                  'Olá!',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  key: Key("register_text"),
                                  'Cadastre-se para continuar.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24),
                          TextFormField(
                            key: Key("name_field"),
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Nome completo',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Coloque seu nome, por favor';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 24),
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
                          SizedBox(height: 24),
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
                                color: Color(0xFFFFFFFF),
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
                          SizedBox(height: 24),
                          OutlinedButton(
                            key: Key("register_button"),
                            onPressed: _register,
                            style: OutlinedButton.styleFrom(
                              minimumSize: Size(double.infinity, 56),
                              maximumSize: Size(double.infinity, 56),
                            ),
                            child: Text('CADASTRAR'),
                          ),
                          SizedBox(height: 12),
                          GestureDetector(
                            key: Key("have_account_button"),
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(_createRoute(LoginScreen()));
                            },
                            child: Text(
                              'Já tenho uma conta',
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
