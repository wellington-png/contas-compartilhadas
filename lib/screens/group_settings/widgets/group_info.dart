import 'package:conta/config/theme.dart';
import 'package:conta/screens/group/bloc/group_details/group_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GroupInfo extends StatelessWidget {
  final GroupDetailState state;
  final String groupOwner;

  const GroupInfo({
    super.key,
    required this.state,
    required this.groupOwner,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.person, color: AppColors.primaryBlue, size: 15),
            const SizedBox(width: 10),
            Text(
              'Dono: ${state.group?.ownerName ?? groupOwner}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const Icon(Icons.calendar_today,
                color: AppColors.primaryBlue, size: 15),
            const SizedBox(width: 10),
            Text(
              'Criado em: ${dateFormat.format(state.group?.createdAt ?? DateTime.now())}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
