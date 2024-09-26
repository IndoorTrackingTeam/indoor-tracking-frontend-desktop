// ignore_for_file: unused_field

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Navbar(
                token: widget._token, selectedIndex: widget._selectedIndex),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: const Center(
                child: Text(
                  'Settings',
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
