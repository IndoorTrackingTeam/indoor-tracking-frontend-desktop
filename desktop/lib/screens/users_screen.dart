// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:desktop/api/user_service.dart';
import 'package:desktop/widgets/navbar.dart';
import 'package:desktop/widgets/user_create.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  final String _token;
  final int _selectedIndex;

  const UsersScreen(this._token, this._selectedIndex, {super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  UserService userService = UserService();
  List<dynamic> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
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

  Future<void> _fetchUsers() async {
    setState(() {
      isLoading = true;
    });
    List<dynamic> list = await userService.getAllUsers();
    setState(() {
      users = list;
      isLoading = false;
    });
  }

  Future<void> _changeUserRole(dynamic user, bool isAdmin) async {
    setState(() {
      isLoading = true;
      user['isAdmin'] = isAdmin;
    });

    try {
      await userService.updateUserAdmin(user['email'], isAdmin);
    } catch (e) {
      setState(() {
        user['isAdmin'] = !isAdmin;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar o status do usuário: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showUserOptions(dynamic user) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 200,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF1E1E1E)
                : const Color(0xFFFFFFFF),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alterar tipo de usuário',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFFFFFFFF)
                      : const Color(0xFF2D2D2D),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: Text(
                  'Admin',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF2D2D2D),
                  ),
                ),
                leading: Radio<bool>(
                  value: true,
                  groupValue: user['isAdmin'],
                  onChanged: (bool? value) {
                    Navigator.pop(context);
                    if (value != null && value != user['isAdmin']) {
                      _changeUserRole(user, value);
                    }
                  },
                ),
              ),
              ListTile(
                title: Text(
                  'User',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF2D2D2D),
                  ),
                ),
                leading: Radio<bool>(
                  value: false,
                  groupValue: user['isAdmin'],
                  onChanged: (bool? value) {
                    Navigator.pop(context);
                    if (value != null && value != user['isAdmin']) {
                      _changeUserRole(user, value);
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _deleteUser(dynamic user) async {
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF1E1E1E)
              : const Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            'Confirmar exclusão',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFFFFFFFF)
                  : const Color(0xFF1E1E1E),
            ),
          ),
          content: Text(
            'Você realmente deseja excluir o usuário ${user['name']}?',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFFFFFFFF)
                  : const Color(0xFF1E1E1E),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 109, 19, 12)),
              ),
              child:
                  const Text('Excluir', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      try {
        setState(() {
          isLoading = true;
        });
        await userService.deleteUser(user['email']);
        setState(() {
          users.removeWhere((u) => u['email'] == user['email']);
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: const Color(0xFFF1B600),
              content: Text('Erro ao deletar o usuário: $e',
                  style: const TextStyle(color: Colors.black))),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _openCreateUserDialog() async {
    final newUser = await showDialog<UserCreateForm>(
      context: context,
      builder: (context) {
        return const UserCreateForm();
      },
    );

    if (newUser != null) {
      setState(() {
        users.add(newUser);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
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
                  padding: const EdgeInsets.all(20),
                  child: ListView.builder(
                    itemCount:
                        users.where((user) => user['isAdmin'] == true).length,
                    itemBuilder: (context, index) {
                      var user = users
                          .where((user) => user['isAdmin'] == true)
                          .toList()[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user['name'],
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? const Color(0xFF1E1E1E)
                                          : const Color(0xFFFFFFFF),
                                    ),
                                  ),
                                  Text(
                                    'Admin',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? const Color(0xFF1E1E1E)
                                          : const Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? const Color(0xFF1E1E1E)
                                      : const Color(0xFFFFFFFF),
                                ),
                                onPressed: () {
                                  _deleteUser(user);
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            _showUserOptions(user);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: ListView.builder(
                        itemCount: users
                            .where((user) => user['isAdmin'] == false)
                            .length,
                        itemBuilder: (context, index) {
                          var user = users
                              .where((user) => user['isAdmin'] == false)
                              .toList()[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user['name'],
                                        style: TextStyle(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? const Color(0xFF1E1E1E)
                                              : const Color(0xFFFFFFFF),
                                        ),
                                      ),
                                      Text(
                                        'User',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? const Color(0xFF1E1E1E)
                                              : const Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? const Color(0xFF1E1E1E)
                                          : const Color(0xFFFFFFFF),
                                    ),
                                    onPressed: () {
                                      _deleteUser(user);
                                    },
                                  ),
                                ],
                              ),
                              onTap: () {
                                _showUserOptions(user);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 250,
                          height: 100,
                          padding: const EdgeInsets.all(20),
                          child: ElevatedButton(
                            onPressed: () async {
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const UserCreateForm();
                                },
                              );
                              Navigator.pushReplacement(
                                context,
                                _createRoute(UsersScreen(
                                    widget._token, widget._selectedIndex)),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text('Adicionar'),
                          ),
                        ),
                      ))
                ],
              )),
            ],
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
