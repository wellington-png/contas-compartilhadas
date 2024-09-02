import 'package:conta/screens/home/bloc/groups/groups_bloc.dart';
import 'package:conta/screens/view_datas/bloc/expense_com/expense_com_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MembersTab extends StatefulWidget {
  const MembersTab({super.key});

  @override
  State<MembersTab> createState() => _MembersTabState();
}

class _MembersTabState extends State<MembersTab> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedGroup;

  List<String> _members = ['João', 'Maria', 'Pedro'];

  void _changeMonth(int delta) {
    setState(() {
      _selectedDate = DateTime(
        _selectedDate.year,
        _selectedDate.month + delta,
      );
      // Atualizar o bloco quando a data muda
      _requestExpenses();
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
        // Atualizar o bloco quando a data é selecionada
        _requestExpenses();
      });
    }
  }

  void _requestExpenses() {
    if (_selectedGroup != null) {
      context.read<ExpenseComBloc>().add(ExpenseComRequested(
            id: int.parse(_selectedGroup!),
            month: _selectedDate.month,
            year: _selectedDate.year,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GroupsBloc, GroupsState>(
          listener: (context, state) {
            if (state.groups != null && _selectedGroup == null) {
              final groupId = int.parse(state.groups!.first.id.toString());
              setState(() {
                _selectedGroup = groupId.toString();
                // Atualizar o bloco quando o grupo muda
                _requestExpenses();
              });
            }
          },
        ),
      ],
      child: Column(
        children: [
          const Text(
            'Membros',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => _changeMonth(-1),
              ),
              Text(DateFormat.yMMMM('pt_BR').format(_selectedDate)),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () => _changeMonth(1),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              BlocBuilder<GroupsBloc, GroupsState>(builder: (context, state) {
                if (state.groups == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return DropdownButton<String>(
                  hint: const Text('Selecione um Grupo'),
                  value: _selectedGroup,
                  onChanged: (String? newValue) {
                    if (newValue != null && newValue != _selectedGroup) {
                      setState(() {
                        _selectedGroup = newValue;
                        _requestExpenses();
                      });
                    }
                  },
                  items: state.groups!.map<DropdownMenuItem<String>>((group) {
                    return DropdownMenuItem<String>(
                      value: group.id.toString(),
                      child: Text(group.name),
                    );
                  }).toList(),
                );
              }),
            ],
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
                final expenses = state.expenses;
                if (expenses == null || expenses.isEmpty) {
                  return const Center(
                      child: Text('Nenhuma despesa encontrada.'));
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
                      return ListTile(
                        leading: Icon(
                          Icons.person,
                          color:
                              Colors.primaries[index % Colors.primaries.length],
                        ),
                        title: Text(expense.userEmail),
                        trailing: Text(
                            'Contribuição: \$${expense.totalExpense.toStringAsFixed(2)}'),
                      );
                    },
                  ),
                );
              }
              return const Center(
                  child: Text(
                      'Selecione um grupo e uma data para visualizar despesas.'));
            },
          )
        ],
      ),
    );
  }
}
