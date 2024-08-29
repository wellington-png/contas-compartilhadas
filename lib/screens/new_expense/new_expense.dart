import 'package:conta/config/theme.dart';
import 'package:flutter/material.dart';

class NewExpenseScreen extends StatefulWidget {
  const NewExpenseScreen({super.key});

  @override
  State<NewExpenseScreen> createState() => _NewExpenseScreenState();
}

class _NewExpenseScreenState extends State<NewExpenseScreen> {
  static const String _titleText = 'Despesa';
  static const String _leadingText = 'Voltar';
  static const String _actionSaveText = 'Salvar';

  List<String> groups = ['Grupo 1', 'Grupo 2', 'Grupo 3'];

  String? selectedGroup;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              DropdownButton<String>(
                isExpanded: true,
                value: selectedGroup,
                hint: const Text('Selecione um grupo'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGroup = newValue!;
                  });
                },
                items: groups.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
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
          onPressed: () {
            // Lógica para salvar a despesa
            Navigator.of(context).pushNamed('/home');
          },
          child: const Text(
            _actionSaveText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 100,
              vertical: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
