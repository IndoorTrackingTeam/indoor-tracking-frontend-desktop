// ignore_for_file: use_build_context_synchronously

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:desktop/api/equipament_service.dart';
import 'package:desktop/widgets/equipament_update_form.dart';

class EquipamentData extends StatelessWidget {
  final dynamic equipament;
  final Map<String, dynamic> data;

  const EquipamentData({
    super.key,
    required this.equipament,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: screenSize.width * 0.5,
        height: 450,
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
                Row(
                  children: [
                    const Text(
                      "Dados do Equipamento",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => EquipamentUpdateForm(
                            name: equipament['name'],
                            register: equipament['register'],
                            espId: equipament["esp_id"],
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        _showDeleteConfirmationDialog(context, equipament);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(),
            _textEquipament(equipament['name'].toUpperCase(), context),
            _textEquipament(equipament['register'].toString(), context),
            _textEquipament(
                "Última vez visto na sala ${equipament['c_room']}", context),
            const SizedBox(height: 10),
            const Divider(),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Histórico",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: (data['historic'] ?? []).isEmpty
                  ? const Center(
                      child: Text('Nenhum histórico disponível'),
                    )
                  : ListView.builder(
                      itemCount: data['historic'].length,
                      itemBuilder: (context, index) {
                        var initialDate = DateTime.parse(
                            data['historic'][index]['initial_date']);
                        var formattedDate =
                            DateFormat('HH:mm dd/MM/yyyy').format(initialDate);
                        return _textEquipamentHistoric(
                          'Sala ${data['historic'][index]['room']}',
                          formattedDate,
                          context,
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textEquipament(String text, BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF2D2D2D)
            : const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFFF5F7F8)
              : const Color(0xFF2D2D2D),
        ),
      ),
    );
  }

  Widget _textEquipamentHistoric(
      String room, String date, BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF2D2D2D)
            : const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                room,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFFF5F7F8)
                      : const Color(0xFF2D2D2D),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                date,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 110, 110, 110),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showDeleteConfirmationDialog(BuildContext context, dynamic equipament) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final EquipamentService equipamentService = EquipamentService();
      return AlertDialog(
        title: Text(
          "Confirmar Exclusão",
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFFFFFFFF)
                : const Color(0xFF2D2D2D),
          ),
        ),
        content: Text(
          "Você realmente deseja apagar este equipamento?",
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFFFFFFFF)
                : const Color(0xFF2D2D2D),
          ),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF2D2D2D)
            : const Color(0xFFFFFFFF),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF3D3D3D),
            ),
            child: const Text(
              "Cancelar",
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 167, 38, 38),
            ),
            onPressed: () async {
              await equipamentService.deleteEquipament(equipament['register']);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text("Apagar"),
          ),
        ],
      );
    },
  );
}
