import 'package:flutter/material.dart';

class NewRoomButton extends StatelessWidget {
  const NewRoomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // Ação para criar um novo grupo
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
            // Ação para escanear QR code
          },
          icon: const Icon(Icons.qr_code_scanner),
          label: const Text('Escanear QR Code'),
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
