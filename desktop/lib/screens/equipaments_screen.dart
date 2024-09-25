// ignore_for_file: unused_field

import 'package:desktop/widgets/navbar.dart';
import 'package:flutter/material.dart';

class EquipamentsScreen extends StatefulWidget {
  final String _token;
  final int _selectedIndex;
  const EquipamentsScreen(this._token, this._selectedIndex, {super.key});

  @override
  State<EquipamentsScreen> createState() => _EquipamentsScreenState();
}

class _EquipamentsScreenState extends State<EquipamentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Navbar(token: widget._token, selectedIndex: widget._selectedIndex),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: const Center(
                child: Text(
                  'Conteúdo da Página',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
