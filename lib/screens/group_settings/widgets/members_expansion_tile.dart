import 'package:conta/screens/group/bloc/group_details/group_details_bloc.dart';
import 'package:flutter/material.dart';

class MembersExpansionTile extends StatelessWidget {
  final GroupDetailState state;
  final int ownerId;
  final int userId;
  final Function(int memberId) onRemoveMember;

  const MembersExpansionTile({
    super.key,
    required this.state,
    required this.ownerId,
    required this.userId,
    required this.onRemoveMember,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.transparent),
      ),
      title: const Text(
        'Membros',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      initiallyExpanded: true,
      children: [
        ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: state.group?.members.length ?? 0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final member = state.group!.members[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(member.name[0]),
                ),
                title: Text(member.name),
                trailing: ownerId != member.id && ownerId == userId
                    ? IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => onRemoveMember(member.id),
                      )
                    : null,
              ),
            );
          },
        ),
      ],
    );
  }
}
