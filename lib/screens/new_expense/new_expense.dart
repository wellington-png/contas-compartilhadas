import 'package:conta/config/theme.dart';
import 'package:conta/domain/models/entities/expense/expense_entity.dart';
import 'package:conta/screens/expenses/bloc/expense/expense_bloc.dart';
import 'package:conta/screens/home/bloc/groups/groups_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewExpenseScreen extends StatefulWidget {
  const NewExpenseScreen({super.key});

  @override
  State<NewExpenseScreen> createState() => _NewExpenseScreenState();
}

class _NewExpenseScreenState extends State<NewExpenseScreen> {
  static const String _titleText = 'Despesa';
  static const String _leadingText = 'Voltar';
  static const String _actionSaveText = 'Salvar';

  int? selectedGroupId; // Alterado para int
  DateTime selectedDate = DateTime.now();
  bool isFixed = false;

  final TextEditingController valueController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _saveExpense() {
    if (valueController.text.isEmpty || selectedGroupId == null) {
      // Exibir uma mensagem de erro se o valor ou grupo não estiverem preenchidos
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
      return;
    }

    // Lógica para enviar os dados para a API ou backend
    ExpenseEntity expense = ExpenseEntity(
      group: selectedGroupId!,
      description: descriptionController.text,
      amount: double.parse(valueController.text),
      dateSpent: selectedDate,
      isFixed: isFixed,
    );
    context.read<ExpenseBloc>().add(CreateExpenseRequested(expense));

    // Limpar os campos após salvar
    valueController.clear();
    descriptionController.clear();
    selectedGroupId = null;
    selectedDate = DateTime.now();
    isFixed = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenseBloc, ExpenseState>(
      listener: (context, state) {
        if (state.status == ExpenseStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Despesa adicionada com sucesso!')),
          );
        } else if (state.status == ExpenseStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Falha ao adicionar despesa: ${state.errorMessage}')),
          );
        }
      },
      child: BlocBuilder<GroupsBloc, GroupsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.bgPeach,
            appBar: AppBar(
              title: const Text(
                _titleText,
                style: TextStyle(
                  color: AppColors.textBigTitle,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(_leadingText),
              ),
              leadingWidth: 70,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Valor:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: valueController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Digite o valor da despesa',
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Descrição:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Digite a descrição da despesa',
                        prefixIcon: Icon(Icons.description),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.category),
                        const SizedBox(width: 10),
                        const Text(
                          'Tipo:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 150,
                          child: DropdownButton<bool>(
                            isExpanded: true,
                            value: isFixed,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isFixed = newValue!;
                              });
                            },
                            items: const [
                              DropdownMenuItem(
                                value: true,
                                child: Text('Fixa'),
                              ),
                              DropdownMenuItem(
                                value: false,
                                child: Text('Variável'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today),
                        const SizedBox(width: 10),
                        const Text(
                          'Data:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 20),
                        TextButton(
                          onPressed: () => _selectDate(context),
                          child: Text(
                            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Icon(Icons.group),
                        SizedBox(width: 10),
                        Text(
                          'Selecione o grupo:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    DropdownButton<int>(
                      isExpanded: true,
                      value: selectedGroupId,
                      hint: const Text('Selecione um grupo'),
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedGroupId = newValue;
                        });
                      },
                      items: state.groups?.map<DropdownMenuItem<int>>((group) {
                        return DropdownMenuItem<int>(
                          value: group.id, // Use o ID como valor
                          child: Text(group.name),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                onPressed: _saveExpense,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  _actionSaveText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
