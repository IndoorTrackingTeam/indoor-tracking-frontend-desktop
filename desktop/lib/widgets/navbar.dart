// ignore: library_private_types_in_public_api
// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:desktop/screens/create_screen.dart';
import 'package:desktop/screens/equipaments_screen.dart';
import 'package:desktop/screens/login_screen.dart';
import 'package:desktop/screens/settings_screen.dart';
import 'package:desktop/screens/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Navbar extends StatefulWidget {
  final String token;
  final int selectedIndex;
  const Navbar({super.key, required this.token, required this.selectedIndex});

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int? _hoveredIndex;

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

  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.search, 'title': 'Search...'},
    {'icon': Icons.earbuds_rounded, 'title': 'Equipaments'},
    {'icon': Icons.create, 'title': 'Create'},
    {'icon': Icons.person, 'title': 'Users'},
    {'icon': Icons.settings, 'title': 'Settings'},
    {'icon': Icons.download, 'title': 'Mobile App'}
  ];

  void _onItemTap(int index) {
    Widget page;

    if (_navItems[index]['title'] == 'Equipaments') {
      page = EquipamentsScreen(widget.token, index);
    } else if (_navItems[index]['title'] == 'Create') {
      page = CreateScreen(widget.token, index);
    } else if (_navItems[index]['title'] == 'Users') {
      page = UsersScreen(widget.token, index);
    } else if (_navItems[index]['title'] == 'Settings') {
      page = SettingsScreen(widget.token, index);
    } else if (_navItems[index]['title'] == 'Mobile App') {
      page = EquipamentsScreen(widget.token, index);
    } else {
      page = EquipamentsScreen(widget.token, index);
    }

    Navigator.pushReplacement(
      context,
      _createRoute(page),
    );
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('logged_in', false);
    await prefs.remove('auth_token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  Future<void> _confirmLogout() async {
    bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirmar Logout',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFFF5F7F8)
                  : const Color(0xFF2D2D2D),
            ),
          ),
          content: Text(
            'Você realmente deseja sair do aplicativo?',
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
                  const Color.fromARGB(255, 143, 20, 11),
                ),
              ),
              child: const Text('Sair'),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      _logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 3,
            offset: const Offset(0, 5),
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: const Color(0xFF394170),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: 100,
            height: 50,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logo_navbar.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 5),
          for (int i = 0; i < _navItems.length; i++) ...[
            const SizedBox(height: 5),
            MouseRegion(
              onEnter: (_) => setState(() => _hoveredIndex = i),
              onExit: (_) => setState(() => _hoveredIndex = null),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: widget.selectedIndex == i
                      ? const Color(0xFFF5F7F8)
                      : _hoveredIndex == i
                          ? const Color(0xFF2D3359)
                          : const Color(0xFF394170),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ListTile(
                  leading: Icon(
                    _navItems[i]['icon'],
                    color: widget.selectedIndex == i
                        ? const Color(0xFF394170)
                        : const Color(0xFFF5F7F8),
                  ),
                  title: Text(
                    _navItems[i]['title'],
                    style: TextStyle(
                      color: widget.selectedIndex == i
                          ? const Color(0xFF394170)
                          : const Color(0xFFF5F7F8),
                    ),
                  ),
                  onTap: () => _onItemTap(i),
                  selected: widget.selectedIndex == i,
                ),
              ),
            ),
          ],
          const Spacer(),
          MouseRegion(
            onEnter: (_) => setState(() => _hoveredIndex = -1),
            onExit: (_) => setState(() => _hoveredIndex = null),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: _hoveredIndex == -1
                    ? const Color(0xFF2D3359)
                    : const Color(0xFF394170),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: const Text(
                  'Sair',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: _confirmLogout,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
