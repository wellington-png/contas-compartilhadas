import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppBarTitle extends StatelessWidget {
  final DateTime selectedDate;
  final void Function(int) changeMonth;
  final Future<void> Function(BuildContext) selectMonth;

  const AppBarTitle({
    super.key,
    required this.selectedDate,
    required this.changeMonth,
    required this.selectMonth,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => selectMonth(context), // Abre o calendário ao clicar na data
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => changeMonth(-1),
          ),
          Text(DateFormat.yMMMM('pt_BR').format(selectedDate), // Formata a data
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () => changeMonth(1),
          ),
        ],
      ),
    );
  }
}
