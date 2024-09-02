import 'package:conta/screens/graficos/graficos.dart';
import 'package:conta/screens/group/bloc/group_details/group_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TitleAndDropdown extends StatelessWidget {
  const TitleAndDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupDetailsBloc, GroupDetailState>(
        builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${state.group!.members.length.toString()} Membro(s)',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const GraficosScreen(),
              ),
            ),
            icon: const Icon(Icons.bar_chart, color: Colors.brown),
          )
        ],
      );
    });
  }
}
