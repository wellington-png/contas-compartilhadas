import 'package:flutter/material.dart';

class MembersTab extends StatelessWidget {
  const MembersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Membros',
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
                leading: Icon(Icons.person, color: Colors.orange),
                title: Text('João'),
                trailing: Text('Contribuição: \$300'),
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.purple),
                title: Text('Maria'),
                trailing: Text('Contribuição: \$450'),
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.pink),
                title: Text('Pedro'),
                trailing: Text('Contribuição: \$500'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
