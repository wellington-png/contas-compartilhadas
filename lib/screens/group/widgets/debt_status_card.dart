import 'package:conta/screens/expenses/bloc/expense/expense_bloc.dart';
import 'package:conta/screens/expenses/expenses.dart';
import 'package:flutter/material.dart';
import 'package:conta/screens/group/widgets/debt_status_row.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DebtStatusCard extends StatelessWidget {
  final int? groupId;
  const DebtStatusCard({super.key, this.groupId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        final expenses = state.expenses;
        final dateFormat = DateFormat('dd/MM/yyyy');
        
        // Textos personalizados para os estados
        final noExpensesText = 'Nenhuma despesa encontrada.';
        final deleteFailureText = 'Não foi possível excluir a despesa.';

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
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ExpensesScreen(
                            groupId: groupId,
                          ),
                        ));
                      },
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
                if (state.status == ExpenseStatus.failure)
                  Center(
                    child: Text(
                      deleteFailureText,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                  )
                else if (expenses == null || expenses.isEmpty)
                  Center(
                    child: Text(
                      noExpensesText,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  )
                else
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
                      final formattedDate =
                          dateFormat.format(expense.dateSpent);
                      return DebtStatusRow(
                        icon: expense.isFixed
                            ? const Icon(Icons.money)
                            : const Icon(Icons.attach_money),
                        name: expense.description,
                        debtAmount: NumberFormat.currency(
                                locale: 'pt_BR', symbol: 'R\$')
                            .format(expense.amount),
                        subName: formattedDate,
                        nameUser: expense.nameUser!,
                        isFixad: expense.isFixed,
                        onDelete: () {
                          _showDeleteConfirmationDialog(context, expense.id!,
                              () {
                            deleteExpense(context, expense.id!);
                          });
                        },
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

  void deleteExpense(BuildContext context, int expenseId) {
    context.read<ExpenseBloc>().add(DeleteExpenseRequested(expenseId));
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, int expenseId, void Function() onDelete) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir Despesa'),
          content:
              const Text('Você tem certeza que deseja excluir esta despesa?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Dispara o evento de exclusão para o BLoC
                onDelete();
                Navigator.of(context).pop();
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }
}
