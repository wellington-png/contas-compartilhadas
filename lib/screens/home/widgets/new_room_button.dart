import 'package:flutter/material.dart';
import 'package:conta/screens/scanner_qrcode/scanner_qrcode.dart';

class NewRoomButton extends StatelessWidget {
  const NewRoomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                final TextEditingController groupNameController = TextEditingController();
                final GlobalKey<FormState> formKey = GlobalKey<FormState>();
                String? errorMessage;

                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      title: const Text('Novo Grupo'),
                      content: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: groupNameController,
                              decoration: InputDecoration(
                                labelText: 'Nome do Grupo',
                                errorText: errorMessage,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'O nome do grupo é obrigatório';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              // Lógica para criar o novo grupo usando o nome do grupo
                              String groupName = groupNameController.text;

                              // TODO: Adicionar a lógica para criar o grupo e tratar erros

                              Navigator.of(context).pop();
                            } else {
                              setState(() {
                                errorMessage = 'Por favor, insira um nome válido';
                              });
                            }
                          },
                          child: const Text('Criar'),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
          icon: const Icon(Icons.add),
          label: const Text('Novo Grupo'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlueAccent,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            minimumSize: const Size(160, 50),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BarcodeScannerWithOverlay(),
              ),
            );
          },
          icon: const Icon(Icons.qr_code_scanner),
          label: const Text('Escanear'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            minimumSize: const Size(160, 50),
          ),
        ),
      ],
    );
  }
}
