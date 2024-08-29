import 'package:conta/config/routes/router.dart';
import 'package:flutter/material.dart';

class TitleAndDropdown extends StatelessWidget {
  const TitleAndDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '309 Roomies',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        IconButton(
          onPressed: () => Navigator.of(context).pushNamed(Routes.groupStatistics),
          icon: const Icon(Icons.bar_chart, color: Colors.brown),
        )
      ],
    );
  }
}
