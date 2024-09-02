import 'package:conta/config/services/http_service_impl.dart';
import 'package:conta/config/theme.dart';
import 'package:conta/domain/models/entities/expense/expense_entity.dart';
import 'package:conta/domain/repositories/expense/expense_repository_impl.dart';
import 'package:conta/screens/expenses/widgets/app_bar.dart';
import 'package:conta/screens/expenses/widgets/tab_buttons.dart';
import 'package:conta/screens/group/widgets/debt_status_row.dart';
import 'package:conta/screens/new_expense/new_expense.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  final int? groupId;
  const ExpensesScreen({super.key, this.groupId});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  DateTime _selectedDate = DateTime.now();
  int _currentIndex = 0;
  List<ExpenseEntity> _expenses = [];

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  void _changeMonth(int delta) {
    setState(() {
      _selectedDate = DateTime(
        _selectedDate.year,
        _selectedDate.month + delta,
      );
    });
    _loadExpenses(); // Recarrega as despesas ao mudar o mês
  }

  Future<void> _selectMonth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return child ?? const SizedBox.shrink();
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = DateTime(picked.year, picked.month);
      });
      _loadExpenses(); // Recarrega as despesas ao selecionar um mês diferente
    }
  }

  Future<void> _loadExpenses() async {
    final expenseRepository =
        ExpenseRepositoryImpl(httpService: HttpServiceImpl());

    bool? isFixed;
    if (_currentIndex == 1) {
      isFixed = false; // Variável
    } else if (_currentIndex == 2) {
      isFixed = true; // Fixa
    }

    final result = await expenseRepository.list(
      groupId: widget.groupId,
      month: _selectedDate.month,
      year: _selectedDate.year,
      isFixed: isFixed,
    );

    setState(() {
      _expenses = result.fold(
        (error) => [], // Se ocorrer um erro, define a lista como vazia
        (expenses) =>
            expenses, // Caso contrário, atualiza a lista com as despesas recebidas
      );
    });
  }

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    _loadExpenses(); // Recarrega as despesas ao mudar a aba
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPeach,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => const NewExpenseScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            AppBarTitle(
              selectedDate: _selectedDate,
              changeMonth: _changeMonth,
              selectMonth: _selectMonth,
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Color.fromARGB(91, 158, 158, 158),
            ),
            Card(
              margin: const EdgeInsets.all(0),
              color: AppColors.bgPeach,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        TabButtons(
                          currentIndex: _currentIndex,
                          onTabChanged: _onTabChanged,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Card(
                margin: const EdgeInsets.all(18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
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
                        child: ListView.builder(
                          itemCount: _expenses.length,
                          
                          itemBuilder: (context, index) {
                            final expense = _expenses[index];
                            return DebtStatusRow(
                              icon: const Icon(Icons.money),
                              name: expense.description,
                              debtAmount: expense.amount.toString(),
                              subName:
                                  '${expense.dateSpent.day}/${expense.dateSpent.month}/${expense.dateSpent.year}',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
