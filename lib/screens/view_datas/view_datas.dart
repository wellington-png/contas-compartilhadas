import 'package:conta/config/theme.dart';
import 'package:conta/screens/view_datas/bloc/expense_com/expense_com_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/balance_tab.dart';
import 'widgets/members_tab.dart';
import 'widgets/pie_chart_widget.dart';
import 'widgets/tab_buttons.dart';

class ViewDatasScreen extends StatefulWidget {
  const ViewDatasScreen({super.key});

  @override
  State<ViewDatasScreen> createState() => _ViewDatasScreenState();
}

class _ViewDatasScreenState extends State<ViewDatasScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPeach,
      appBar: AppBar(
        title: const Text('View Data'),
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
                  BlocBuilder<ExpenseComBloc, ExpenseComState>(
                    builder: (context, state) {
                      if (state.status == ExpenseComStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.status == ExpenseComStatus.failure) {
                        return Center(
                          child: Text(
                            state.errorMessage ?? 'Erro ao carregar dados.',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      } else if (state.status == ExpenseComStatus.success) {
                        final expenses = state.expenses ?? [];
                        return SizedBox(
                          height: 200,
                          child: PieChartWidget(
                            currentIndex: _currentIndex,
                            expenses: expenses,
                          ),
                        );
                      }
                      return const Center(child: Text('Selecione um grupo e uma data para visualizar despesas.'));
                    },
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
