import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatar datas

class GroupStatisticsScreen extends StatefulWidget {
  const GroupStatisticsScreen({super.key});

  @override
  State<GroupStatisticsScreen> createState() => _GroupStatisticsScreenState();
}

class _GroupStatisticsScreenState extends State<GroupStatisticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _selectedDate = DateTime.now(); // Data atual

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
      body: Column(
        children: [
          Card(
            elevation: 4,
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Balance'),
                    Tab(text: 'Category'),
                    Tab(text: 'Members'),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 200, // Altura fixa para o gráfico
                  child: _buildPieChart(_tabController.index == 0
                      ? [
                          PieChartSectionData(
                              color: Colors.blue, value: 52, title: '52%'),
                          PieChartSectionData(
                              color: Colors.yellow, value: 48, title: '48%'),
                        ]
                      : _tabController.index == 1
                          ? [
                              PieChartSectionData(
                                  color: Colors.red, value: 60, title: '60%'),
                              PieChartSectionData(
                                  color: Colors.green, value: 40, title: '40%'),
                            ]
                          : [
                              PieChartSectionData(
                                  color: Colors.purple,
                                  value: 70,
                                  title: '70%'),
                              PieChartSectionData(
                                  color: Colors.orange,
                                  value: 30,
                                  title: '30%'),
                            ]),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildListView(const [
                  ListTile(title: Text('Expense'), trailing: Text('\$1,654')),
                  ListTile(title: Text('Income'), trailing: Text('\$1,824')),
                ]),
                _buildListView(const [
                  ListTile(title: Text('House'), trailing: Text('\$1,005')),
                  ListTile(title: Text('Drink'), trailing: Text('\$17')),
                  ListTile(title: Text('Grocery'), trailing: Text('\$52')),
                ]),
                _buildListView(const [
                  ListTile(title: Text('Pluddie'), trailing: Text('\$237')),
                  ListTile(title: Text('Zebra'), trailing: Text('\$711')),
                  ListTile(title: Text('Whale'), trailing: Text('\$387')),
                  ListTile(title: Text('Kitty'), trailing: Text('\$319')),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(List<PieChartSectionData> chartData) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: PieChart(
        PieChartData(sections: chartData),
      ),
    );
  }

  Widget _buildListView(List<Widget> listItems) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 4,
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: listItems,
        ),
      ),
    );
  }
}
