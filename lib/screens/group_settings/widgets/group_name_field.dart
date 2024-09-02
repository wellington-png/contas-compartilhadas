import 'package:conta/config/theme.dart';
import 'package:flutter/material.dart';

class GroupNameField extends StatelessWidget {
  final TextEditingController groupNameController;
  final int ownerId;
  final int userId;
  final int groupId;
  final Function(int) onUpdateGroupName;

  const GroupNameField({
    super.key,
    required this.groupNameController,
    required this.ownerId,
    required this.userId,
    required this.groupId,
    required this.onUpdateGroupName,
  });

  @override
  Widget build(BuildContext context) {
    bool isNotZero = ownerId != 0 && userId != 0;
    bool isOwner = ownerId == userId;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Icon(Icons.house_outlined,
              color: AppColors.primaryBlue, size: 30),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: groupNameController,
              decoration: const InputDecoration(hintText: 'Nome do grupo'),
              enabled: isNotZero && isOwner,
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: AppColors.primaryBlue),
            onPressed: isNotZero && isOwner
                ? () => onUpdateGroupName(groupId)
                : null,
          ),
        ],
      ),
    );
  }
}

