// ignore_for_file: unused_field, unused_element, use_build_context_synchronously, unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:desktop/widgets/equipament_data.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
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
  List<dynamic> filteredEquipaments = [];
  List<dynamic> equipaments = [];
  bool isUpdatingEquipaments = false;
  bool isLoading = true;
  Timer? _timer;
  final random = Random();

  @override
  void initState() {
    super.initState();
    _fetchEquipaments();
    _timer = Timer.periodic(const Duration(minutes: 20), (timer) {
      _fetchEquipaments();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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

  Future<void> _getEquipamentsHistoric(BuildContext context,
      EquipamentService equipamentService, dynamic equipament) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    Map<String, dynamic> data =
        await equipamentService.getOneEquipament(equipament['register']);
    Navigator.pop(context);
    _showEquipamentDetails(context, equipament, data);
  }

  void _showEquipamentDetails(
      BuildContext context, dynamic equipament, Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) => EquipamentData(equipament: equipament, data: data),
    );
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
                  Row(
                    children: [
                      Expanded(
                        flex: 20,
                        child: TextField(
                          key: const Key('search_text_field'),
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {
                              filteredEquipaments = equipaments
                                  .where((element) => element['name']
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Pesquisar',
                            prefixIcon: Icon(Icons.search,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? const Color(0xFFF2F2F2)
                                    : const Color(0xFF394170)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: isUpdatingEquipaments
                            ? Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? const Color(0xFFF2F2F2)
                                        : const Color(0xFF394170),
                                  ),
                                ),
                              )
                            : IconButton(
                                icon: const Icon(Icons.refresh),
                                onPressed: _updateEquipamentsLocation,
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  isLoading
                      ? Expanded(
                          child: SingleChildScrollView(
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: List.generate(random.nextInt(13) + 2,
                                  (index) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[400]!,
                                  highlightColor: Colors.grey[300]!,
                                  child: Container(
                                    width: 450,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        )
                      : Expanded(
                          child: SingleChildScrollView(
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: filteredEquipaments.map((equipament) {
                                return GestureDetector(
                                  onTap: () => _getEquipamentsHistoric(
                                      context, equipamentService, equipament),
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
      color: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF2D2D2D)
          : const Color(0xFF394170),
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
                    color: Color(0xFFF2F2F2),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  equipament['register'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFFF2F2F2),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  equipament['c_room'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFFF2F2F2),
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
