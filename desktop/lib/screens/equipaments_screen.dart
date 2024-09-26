// ignore_for_file: unused_field, unused_element, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
//import 'dart:convert';
//import 'package:intl/intl.dart';
//import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:desktop/api/equipament_service.dart';
import 'package:desktop/widgets/navbar.dart';

class EquipamentsScreen extends StatefulWidget {
  final String _token;
  final int _selectedIndex;
  const EquipamentsScreen(this._token, this._selectedIndex, {super.key});

  @override
  State<EquipamentsScreen> createState() => _EquipamentsScreenState();
}

class _EquipamentsScreenState extends State<EquipamentsScreen> {
  final TextEditingController _searchController = TextEditingController();
  EquipamentService equipamentService = EquipamentService();
  List<dynamic> equipaments = [];
  List<dynamic> filteredEquipaments = [];
  bool isLoading = true;
  bool isUpdatingEquipaments = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchEquipaments();
    _timer = Timer.periodic(const Duration(minutes: 20), (timer) {
      _fetchEquipaments();
    });
  }

  Future<void> _fetchEquipaments() async {
    setState(() {
      isLoading = true;
    });
    List<dynamic> list = await equipamentService.getEquipaments();
    setState(() {
      equipaments = list;
      filteredEquipaments = list;
      isLoading = false;
    });
  }

  Future<void> _updateEquipamentsLocation() async {
    setState(() {
      isUpdatingEquipaments = true;
    });
    try {
      await equipamentService.updateEquipamentsLocation();
      await _fetchEquipaments();
      setState(() {
        isUpdatingEquipaments = false;
      });
    } catch (e) {
      setState(() {
        isUpdatingEquipaments = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao atualizar a localização dos equipamentos'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
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
                token: widget._token, selectedIndex: widget._selectedIndex),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Equipaments',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: SingleChildScrollView(
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: filteredEquipaments.map((equipament) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: SizedBox(
                                    width: 450,
                                    height: 150,
                                    child: cardEquipament(context, equipament),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
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

Widget cardEquipament(BuildContext context, dynamic equipament) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFF2D2D2D),
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Color(0xFF000000),
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            child: equipament['image'] != null && equipament['image'].isNotEmpty
                ? Image.memory(
                    base64Decode(equipament['image']),
                    width: 450,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "default.png",
                    width: 150,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  equipament['name'].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  equipament['register'],
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 5),
                Text(
                  equipament['c_room'],
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
