import 'package:conta/screens/view_datas/bloc/balence/balence_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BalanceTab extends StatefulWidget {
  const BalanceTab({super.key});

  @override
  State<BalanceTab> createState() => _BalanceTabState();
}

class _BalanceTabState extends State<BalanceTab> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BalanceBloc, BalanceState>(
      builder: (context, state) {
        if (state.status == BalanceStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == BalanceStatus.failure) {
          return Center(child: Text('Falha ao carregar saldo: ${state.errorMessage}'));
        } else if (state.status == BalanceStatus.success && state.balance != null) {
          final balance = state.balance!;
          final totalIncome = balance.fixedIncome;
          final totalExpense = balance.totalExpense;
          final remainingBalance = balance.balance;
          final total = totalIncome + totalExpense;
          final expensePercentage = total == 0 ? 0 : (totalExpense / total) * 100;
          final incomePercentage = total == 0 ? 0 : (totalIncome / total) * 100;

          return Column(
            children: [
              const SizedBox(height: 8),
              Text(
                'Saldo: R\$${remainingBalance.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
        
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      trailing: Text('R\$${totalExpense.toStringAsFixed(2)} (${expensePercentage.toStringAsFixed(0)}%)',
                          style: const TextStyle(fontSize: 18, color: Colors.blue)),
                      title: const Text('Despesas'),
                    ),
                    ListTile(
                      trailing: Text('R\$${totalIncome.toStringAsFixed(2)} (${incomePercentage.toStringAsFixed(0)}%)',
                          style: const TextStyle(fontSize: 18, color: Colors.yellow)),
                      title: const Text('Renda'),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Center(child: Text('Nenhum dado disponível'));
        }
      }
    );
  }
}
