import 'package:flutter/material.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Categorias de Despesa',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView(
            children: const [
              ListTile(
                leading: Icon(Icons.fastfood, color: Colors.red),
                title: Text('Alimentação'),
                trailing: Text('\$500'),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.green),
                title: Text('Moradia'),
                trailing: Text('\$1,000'),
              ),
              ListTile(
                leading: Icon(Icons.directions_car, color: Colors.blue),
                title: Text('Transporte'),
                trailing: Text('\$150'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
