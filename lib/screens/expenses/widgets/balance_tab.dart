import 'package:conta/screens/group/widgets/debt_status_row.dart';
import 'package:flutter/material.dart';

class BalanceTab extends StatelessWidget {
  const BalanceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        const Text(
          'Todas as despesas do mês',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView(
            children: const [
              DebtStatusRow(icon: Icon(Icons.money), name: 'teste', debtAmount: "100", subName: 'teste')
            ],
          ),
        ),
      ],
    );
  }
}
