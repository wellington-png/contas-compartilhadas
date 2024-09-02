import 'package:flutter/material.dart';

// Imports de configuração e serviços
import 'package:conta/config/services/http_service_impl.dart';
import 'package:conta/config/theme.dart';

// Imports de modelos e repositórios
import 'package:conta/domain/models/entities/expense/expense_entity.dart';
import 'package:conta/domain/repositories/expense/expense_repository_impl.dart';

// Imports de widgets
import 'package:conta/screens/expenses/widgets/app_bar.dart';

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
  final List<String> _options = [
    'Todas',
    'Variável',
    'Fixa'
  ]; // Opções para o Dropdown

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

  void _onOptionChanged(String? option) {
    setState(() {
      _currentIndex = _options.indexOf(option ?? 'Todas');
    });
    _loadExpenses(); // Recarrega as despesas ao mudar a opção
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
            // Seção de opções

            // Lista de despesas
            Expanded(
              child: Card(
                margin: const EdgeInsets.all(8),
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          value: _options[_currentIndex],
                          onChanged: _onOptionChanged,
                          items: _options.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.separated(
                          itemCount: _expenses.length,
                          separatorBuilder: (context, index) {
                            // Retorna um Divider com espaçamento entre os itens
                            return index < _expenses.length - 1
                                ? Column(
                                    children: [
                                      const Divider(
                                          height: 1, color: Colors.grey),
                                      const SizedBox(
                                          height: 8), // Espaço entre os itens
                                    ],
                                  )
                                : const SizedBox
                                    .shrink(); // Não exibe um Divider para o último item
                          },
                          itemBuilder: (context, index) {
                            final expense = _expenses[index];
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  child: Icon(
                                    expense.isFixed
                                        ? Icons.lock
                                        : Icons
                                            .lock_open, // Exibe ícone diferente com base em isFixed
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        expense.description,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${expense.dateSpent.day}/${expense.dateSpent.month}/${expense.dateSpent.year}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      if (expense.nameUser != null)
                                        Text(
                                          expense.nameUser!,
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
                                      expense.amount.toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(expense.isFixed ? 'Fixo' : 'Variável'),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
