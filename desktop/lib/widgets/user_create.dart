// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:desktop/api/user_service.dart'; // Certifique-se de ter um serviço para gerenciar usuários

class UserCreateForm extends StatefulWidget {
  const UserCreateForm({super.key});

  @override
  _UserCreateFormState createState() => _UserCreateFormState();
}

class _UserCreateFormState extends State<UserCreateForm> {
  final UserService userService = UserService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 350,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF1D1D1D)
              : const Color(0xFFF5F7F8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Criar Usuário",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(),
            const Spacer(),
            _buildTextField("Nome", nameController, context, Icons.person),
            _buildTextField("E-mail", emailController, context, Icons.email),
            _buildTextField(
              "Senha",
              passwordController,
              context,
              Icons.lock,
            ),
            const Spacer(),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 200,
                      height: 60,
                      child: OutlinedButton(
                        onPressed: () async {
                          final String name = nameController.text;
                          final String email = emailController.text;
                          final String password = passwordController.text;

                          if (name.isEmpty ||
                              email.isEmpty ||
                              password.isEmpty) {
                            _showErrorDialog(context);
                          } else {
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              await userService.createUser(
                                  name, email, password);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Usuário criado com sucesso!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } catch (e) {
                              String errorMessage;
                              errorMessage =
                                  'Erro: $e. Por favor, entre em contato com o suporte.';
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(errorMessage),
                                  backgroundColor:
                                      const Color.fromARGB(255, 214, 177, 10),
                                ),
                              );
                            } finally {
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: const Text("ADICIONAR"),
                      ),
                    ),
                  ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Erro",
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFFFFFFFF)
                  : const Color(0xFF2D2D2D),
            ),
          ),
          content: Text(
            "Por favor, preencha todos os campos!",
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFFFFFFFF)
                  : const Color(0xFF2D2D2D),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF2D2D2D)
              : const Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      BuildContext context, IconData icon,
      {bool obscureText = false}) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF2D2D2D)
            : const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          prefixIcon: Icon(
            icon,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            size: 20,
          ),
          labelStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFFF5F7F8)
                : const Color(0xFF2D2D2D),
          ),
        ),
      ),
    );
  }
}
