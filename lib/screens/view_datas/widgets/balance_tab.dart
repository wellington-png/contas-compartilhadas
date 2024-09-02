import 'package:flutter/material.dart';

class BalanceTab extends StatefulWidget {
  const BalanceTab({super.key});

  @override
  State<BalanceTab> createState() => _BalanceTabState();
}

class _BalanceTabState extends State<BalanceTab> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        const Text(
          'Balance \$170',
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
                trailing: Text('\$1,654 (48%)',
                    style: TextStyle(fontSize: 18, color: Colors.blue)),
                title: Text('Expense'),
              ),
              ListTile(
                trailing: Text('\$1,824 (52%)',
                    style: TextStyle(fontSize: 18, color: Colors.yellow)),
                title: Text('Income'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
