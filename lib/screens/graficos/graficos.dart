import 'package:conta/config/theme.dart';
import 'package:conta/screens/new_expense/new_expense.dart';
import 'package:flutter/material.dart';
import 'widgets/app_bar.dart';
import 'widgets/balance_tab.dart';
import 'widgets/category_tab.dart';
import 'widgets/members_tab.dart';
import 'widgets/pie_chart_widget.dart';
import 'widgets/tab_buttons.dart';

class GraficosScreen extends StatefulWidget {
  const GraficosScreen({super.key});

  @override
  State<GraficosScreen> createState() => _GraficosScreenState();
}

class _GraficosScreenState extends State<GraficosScreen>
    with SingleTickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now();
  int _currentIndex = 0;

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
        return child ?? const SizedBox.shrink();
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
      backgroundColor: AppColors.bgPeach,
      appBar: buildAppBar(
        context,
        _selectedDate,
        _changeMonth,
        _selectMonth,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // NewExpenseScreen()
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => const NewExpenseScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const Divider(
            height: 1,
            thickness: 1,
            color: Color.fromARGB(91, 158, 158, 158),
          ),
          Card(
            margin: const EdgeInsets.all(0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TabButtons(
                    currentIndex: _currentIndex,
                    onTabChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: PieChartWidget(currentIndex: _currentIndex),
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
                child: IndexedStack(
                  index: _currentIndex,
                  children: const [
                    BalanceTab(),
                    CategoryTab(),
                    MembersTab(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
