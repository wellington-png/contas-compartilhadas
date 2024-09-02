import 'package:flutter/material.dart';

class DeleteGroupButton extends StatelessWidget {
  final VoidCallback onDeleteGroup;

  const DeleteGroupButton({super.key, required this.onDeleteGroup});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onDeleteGroup,
      backgroundColor: Colors.red,
      child: const Icon(Icons.delete),
    );
  }
}
