import 'package:flutter/material.dart';

class DebtStatusRow extends StatelessWidget {
  final Widget icon;
  final String name;
  final String debtAmount;
  final String subName;
  final String nameUser;
  final bool isFixad;
  final VoidCallback onDelete; // Adicione este parâmetro

  const DebtStatusRow({
    super.key,
    required this.icon,
    required this.name,
    required this.debtAmount,
    required this.subName,
    required this.nameUser,
    required this.isFixad,
    required this.onDelete, // Adicione o parâmetro
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 24,
          child: icon,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subName,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              if (nameUser.isNotEmpty)
                Text(
                  nameUser,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
            ],
          ),
        ),
        Column(
          children: [
            Text(
              debtAmount,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(isFixad ? 'Fixo' : 'Variável'),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete, // Chama o callback de exclusão
        ),
      ],
    );
  }
}
