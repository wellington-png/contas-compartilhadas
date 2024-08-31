import 'package:conta/screens/group/bloc/group_details/group_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OverallBalanceCard extends StatelessWidget {
  const OverallBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocBuilder<GroupDetailsBloc, GroupDetailState>(
          builder: (context, state) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.arrow_downward, color: Colors.red),
                        SizedBox(width: 4),
                        Text(
                          'Despesas',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      state.group!.totalExpenses.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.arrow_upward, color: Colors.green),
                        SizedBox(width: 4),
                        Text(
                          'Saldo',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      state.group!.totalFixedIncome.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
    });
  }
}
