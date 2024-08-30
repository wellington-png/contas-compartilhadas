import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class Expense {
  final String title;
  final double amount;
  final bool isMine;

  Expense(this.title, this.amount, this.isMine);
}

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _selectedDate = DateTime.now(); // Data atual
  bool _showAllExpenses = true; // Flag para mostrar todas as despesas

  // Lista de despesas para exemplo
  final List<Expense> _expenses = [
    Expense('Aluguel', 1200.0, true),
    Expense('Conta de Luz', 150.0, true),
    Expense('Supermercado', 300.0, false),
    Expense('Transporte', 80.0, true),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Alterado para 2
  }

  void _changeMonth(int delta) {
    setState(() {
      _selectedDate = DateTime(
        _selectedDate.year,
        _selectedDate.month + delta,
      );
    });
  }

  Future<void> _selectMonth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return child ?? const SizedBox.shrink(); // Para prevenir retorno nulo
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = DateTime(picked.year, picked.month);
      });
    }
  }

  List<Expense> get displayedExpenses {
    if (_showAllExpenses) {
      return _expenses;
    }
    return _expenses.where((expense) => expense.isMine).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                _changeMonth(-1); // Mês anterior
              },
            ),
            Text(DateFormat.yMMMM().format(_selectedDate)), // Exibe mês e ano
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                _changeMonth(1); // Próximo mês
              },
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              _selectMonth(context); // Selecionar mês
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/new-expense'); // Navega para nova despesa
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Espaçamento lateral
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Espaçamento interno do card
            child: Column(
              children: [
                // Título e ícone
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Despesas',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.pie_chart), // Ícone do gráfico
                      onPressed: () {
                        setState(() {
                          _tabController.index = 1; // Altera para a aba do gráfico
                        });
                      },
                    ),
                  ],
                ),
                // Botões para filtrar despesas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showAllExpenses = true; // Mostrar todas as despesas
                        });
                      },
                      child: const Text('Todas'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showAllExpenses = false; // Mostrar apenas as minhas despesas
                        });
                      },
                      child: const Text('Minhas'),
                    ),
                  ],
                ),
                // Abas para mostrar despesas ou gráfico
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Lista de Despesas'),
                    Tab(text: 'Gráfico'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Listagem de despesas
                      ListView.builder(
                        itemCount: displayedExpenses.length,
                        itemBuilder: (context, index) {
                          final expense = displayedExpenses[index];
                          return ListTile(
                            title: Text(expense.title),
                            subtitle: Text('R\$ ${expense.amount.toStringAsFixed(2)}'),
                          );
                        },
                      ),
                      // Gráfico usando fl_chart
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: PieChart(
                          PieChartData(
                            sections: _getChartSections(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _getChartSections() {
    // Cria os dados do gráfico
    return _expenses.map((expense) {
      return PieChartSectionData(
        color: expense.isMine ? Colors.blue : Colors.green,
        value: expense.amount,
        title: expense.title,
        radius: 30,
      );
    }).toList();
  }
}
