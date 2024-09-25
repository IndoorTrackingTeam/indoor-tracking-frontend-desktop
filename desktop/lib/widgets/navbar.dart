import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  final String token;
  final int selectedIndex;
  const Navbar({super.key, required this.token, required this.selectedIndex});

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.search, 'title': 'Search...'},
    {'icon': Icons.earbuds_rounded, 'title': 'Equipaments'},
    {'icon': Icons.create, 'title': 'Create'},
    {'icon': Icons.person, 'title': 'Users'},
    {'icon': Icons.settings, 'title': 'Settings'},
    {'icon': Icons.download, 'title': 'Mobile App'}
  ];

  void _onItemTap(int index) {
    // Atualiza o índice selecionado
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: 200,
      color: const Color(0xFF394170),
      child: Column(
        children: [
          const SizedBox(height: 20),
          for (int i = 0; i < _navItems.length; i++) ...[
            ListTile(
              leading: Icon(
                _navItems[i]['icon'],
                color: widget.selectedIndex == i ? Colors.white : Colors.grey,
              ),
              title: Text(
                _navItems[i]['title'],
                style: TextStyle(
                  color: widget.selectedIndex == i ? Colors.white : Colors.grey,
                ),
              ),
              onTap: () => _onItemTap(i),
              selected: widget.selectedIndex == i,
              selectedTileColor: Colors.blueGrey[700],
            ),
          ],
          const Spacer(),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              'Sair',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              //print('Fazendo logout...');
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
