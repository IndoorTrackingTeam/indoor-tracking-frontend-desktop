// ignore_for_file: unused_field

import 'package:desktop/widgets/navbar.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  final String _token;
  final int _selectedIndex;
  const CreateScreen(this._token, this._selectedIndex, {super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
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
                  'Create',
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
