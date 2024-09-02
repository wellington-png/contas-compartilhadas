// Imports de pacotes
import 'package:flutter/material.dart';

// Imports de configuração e serviços
import 'package:conta/config/services/http_service_impl.dart';
import 'package:conta/config/theme.dart';

// Imports de modelos e repositórios
import 'package:conta/domain/models/entities/expense/expense_entity.dart';
import 'package:conta/domain/repositories/expense/expense_repository_impl.dart';

// Imports de widgets
import 'package:conta/screens/expenses/widgets/app_bar.dart';
import 'package:conta/screens/expenses/widgets/tab_buttons.dart';

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
    final expenseRepository = ExpenseRepositoryImpl(
      httpService: HttpServiceImpl(),
    );

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
      body: SafeArea(
        child: Column(
          children: [
            // AppBar com seleção de data e navegação
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
            // Seção de abas
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
            // Lista de despesas
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
                        child: ListView.separated(
                          itemCount: _expenses.length,
                          separatorBuilder: (context, index) {
                            // Retorna um Divider para todos os itens, exceto o último
                            return index < _expenses.length - 1
                                ? const Divider(height: 1, color: Colors.grey)
                                : const SizedBox
                                    .shrink(); // Não exibe um Divider para o último item
                          },
                          itemBuilder: (context, index) {
                            final expense = _expenses[index];
                            return ListTile(
                              leading: Icon(
                                expense.isFixed
                                    ? Icons.lock
                                    : Icons
                                        .lock_open, // Exibe ícone diferente com base em isFixed
                              ),
                              title: Text(expense.description),
                              subtitle: Text(
                                  '${expense.dateSpent.day}/${expense.dateSpent.month}/${expense.dateSpent.year}'),
                              trailing: Text(expense.amount.toString()),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16.0), // Espaçamento interno
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
