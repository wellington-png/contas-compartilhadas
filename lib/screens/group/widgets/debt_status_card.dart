import 'package:conta/screens/group/bloc/group_details/group_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:conta/screens/group/widgets/debt_status_row.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DebtStatusCard extends StatelessWidget {
  const DebtStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupDetailsBloc, GroupDetailState>(
      builder: (context, state) {
        final expenses = state.group!.expenses;
        final dateFormat = DateFormat('dd/MM/yyyy');

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Despesas do Mês',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Ver todas',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: expenses.length,
                  separatorBuilder: (context, index) {
                    return index == expenses.length - 1
                        ? const SizedBox.shrink()
                        : const Divider(
                            color: Colors.grey,
                            thickness: 1,
                            height: 30,
                          );
                  },
                  itemBuilder: (context, index) {
                    final expense = expenses[index];
                    final formattedDate = dateFormat.format(expense.dateSpent);
                    return DebtStatusRow(
                      icon: expense.isFixed
                          ? const Icon(Icons.money)
                          : const Icon(Icons.attach_money),
                      name: expense.description,
                      debtAmount: expense.amount.toString(),
                      subName: formattedDate,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
