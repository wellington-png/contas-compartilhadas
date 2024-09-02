import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

AppBar buildAppBar(BuildContext context, DateTime selectedDate,
    void Function(int) changeMonth, Future<void> Function(BuildContext) selectMonth) {
  return AppBar(
    title: GestureDetector(
      onTap: () => selectMonth(context), // Abre o calendário ao clicar na data
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => changeMonth(-1),
          ),
          Text(DateFormat.yMMMM('pt_BR').format(selectedDate)),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () => changeMonth(1),
          ),
        ],
      ),
    ),
    centerTitle: true,
  );
}
