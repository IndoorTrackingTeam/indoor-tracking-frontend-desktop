// ignore_for_file: unused_field, use_build_context_synchronously

import 'dart:io';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:desktop/api/user_service.dart';
import 'package:desktop/widgets/navbar.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final String _token;
  final int _selectedIndex;
  const SettingsScreen(this._token, this._selectedIndex, {super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  UserService userService = UserService();
  Map<String, dynamic> userData = {};
  bool isLoading = true;

  Future<void> _getUserData(String token) async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> data = await userService.getUser(token);
    setState(() {
      userData = data;
      isLoading = false;
    });
  }

  Future<void> _confirmResetPassword(String email) async {
    bool? shouldSend = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirmar redefinição de senha',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFFF5F7F8)
                  : const Color(0xFF2D2D2D),
            ),
          ),
          content: Text(
            'Vamos enviar um email para que você redefina sua senha de acesso?',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFFF5F7F8)
                  : const Color(0xFF2D2D2D),
            ),
          ),
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF2D2D2D)
              : const Color(0xFFF5F7F8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color(0xFFF5F7F8),
                ),
              ),
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  color: Color(0xFF2D2D2D),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color(0xFF394170),
                ),
              ),
              child: const Text('Enviar'),
            ),
          ],
        );
      },
    );

    if (shouldSend == true) {
      try {
        await userService.sendEmailRedefinePassword(email);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF2D2D2D)
                  : const Color(0xFFF5F7F8),
              title: Text(
                "Sucesso",
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFFFFFFFF)
                      : const Color(0xFF2D2D2D),
                ),
              ),
              content: Text(
                'Email enviado para ${userData['email']}',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFFFFFFFF)
                      : const Color(0xFF2D2D2D),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Erro"),
              content: Text('Erro ao enviar email: ${e.toString()}'),
              actions: <Widget>[
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<void> _selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      File imageFile = File(result.files.single.path!);

      final bytes = await imageFile.readAsBytes();
      String base64String = base64Encode(bytes);

      await userService.updateUserPhoto(widget._token, base64String);

      setState(() {
        userData['photo'] = base64String;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserData(widget._token);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Navbar(
              token: widget._token,
              selectedIndex: widget._selectedIndex,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: (MediaQuery.of(context).size.width * 0.15),
                  vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      isLoading
                          ? Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.width * 0.15,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/default.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: const CircularProgressIndicator(),
                              ),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.width * 0.15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: userData['photo'] != null &&
                                          userData['photo'].isNotEmpty
                                      ? MemoryImage(
                                          base64Decode(userData['photo']),
                                        )
                                      : const AssetImage(
                                              'assets/images/default.png')
                                          as ImageProvider,
                                  fit: BoxFit.fill,
                                ),
                                border: Border.all(
                                  color: const Color(0xFF394170),
                                  width: 5,
                                ),
                              ),
                            ),
                    ],
                  ),
                  SizedBox(height: (MediaQuery.of(context).size.width * 0.04)),
                  Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Editar imagem de perfil',
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? const Color(0xFFF5F7F8)
                                    : const Color(0xFF2D2D2D),
                          ),
                        ),
                        onTap: _selectImage,
                        tileColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? const Color(0xFF2D2D2D)
                                : const Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        title: Text(
                          'Redefinir senha',
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? const Color(0xFFF5F7F8)
                                    : const Color(0xFF2D2D2D),
                          ),
                        ),
                        onTap: () => _confirmResetPassword(userData['email']),
                        tileColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? const Color(0xFF2D2D2D)
                                : const Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
