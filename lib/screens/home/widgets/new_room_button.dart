import 'package:flutter/material.dart';

class NewRoomButton extends StatelessWidget {
  const NewRoomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => Navigator.of(context).pushNamed('/group'),
      icon: const Icon(Icons.add),
      label: const Text('New Room'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightBlueAccent,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minimumSize: const Size.fromHeight(50),
      ),
    );
  }
}
