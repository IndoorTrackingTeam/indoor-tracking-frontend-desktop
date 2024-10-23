// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:desktop/api/equipament_service.dart';

class EquipamentCreateForm extends StatefulWidget {
  const EquipamentCreateForm({super.key});

  @override
  _EquipamentCreateFormState createState() => _EquipamentCreateFormState();
}

class _EquipamentCreateFormState extends State<EquipamentCreateForm> {
  final EquipamentService equipamentService = EquipamentService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController registerController = TextEditingController();
  final TextEditingController espController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String? imagePath;
  String image64 = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 400,
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
                const Text(
                  "Criar Equipamento",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(),
            const Spacer(),
            _buildTextField(
              "Nome do Equipamento",
              nameController,
              context,
              Icons.device_hub,
            ),
            _buildTextField(
              "Número de Série",
              registerController,
              context,
              Icons.format_list_numbered,
            ),
            _buildTextField(
              "Identificação do Módulo ESP",
              espController,
              context,
              Icons.bluetooth,
            ),
            _buildImagePicker(context),
            const Spacer(),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 200,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () async {
                          final String name = nameController.text;
                          final String register = registerController.text;
                          final String espId = espController.text;

                          if (name.isEmpty ||
                              register.isEmpty ||
                              espId.isEmpty) {
                            _showErrorDialog(context);
                          } else {
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              await equipamentService.createEquipament(
                                name: name,
                                register: register,
                                espId: espId,
                                image: image64,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Equipamento criado com sucesso!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } catch (e) {
                              String errorMessage;
                              if (e.toString().contains(
                                  "Equipment with this patrimony already exists")) {
                                errorMessage =
                                    'O patrimônio já existe. Por favor, verifique e tente novamente.';
                              } else {
                                errorMessage =
                                    'Erro: $e. Por favor, entre em contato com o suporte.';
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(errorMessage),
                                  backgroundColor:
                                      const Color.fromARGB(255, 214, 177, 10),
                                ),
                              );
                            } finally {
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: const Text("ADICIONAR"),
                      ),
                    ),
                  ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Erro",
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFFFFFFFF)
                  : const Color(0xFF2D2D2D),
            ),
          ),
          content: Text(
            "Por favor, preencha todos os campos!",
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFFFFFFFF)
                  : const Color(0xFF2D2D2D),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF2D2D2D)
              : const Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      BuildContext context, IconData icon) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF2D2D2D)
            : const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          prefixIcon: Icon(
            icon,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            size: 20,
          ),
          labelStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFFF5F7F8)
                : const Color(0xFF2D2D2D),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final XFile? image = await _picker.pickImage(
          source: ImageSource.gallery,
        );
        if (image != null) {
          File imageFile = File(image.path);
          final bytes = await imageFile.readAsBytes();
          String base64String = base64Encode(bytes);
          setState(() {
            image64 = base64String;
            imagePath = image.path;
          });
        }
      },
      child: Container(
        width: double.infinity,
        height: 60,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF2D2D2D)
              : const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(
              Icons.image,
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFFFFFFFF)
                  : const Color(0xFF2D2D2D),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                imagePath != null
                    ? 'Imagem selecionada: ${imagePath!.split('/').last}'
                    : 'Escolher Imagem',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFFF5F7F8)
                      : const Color(0xFF2D2D2D),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
