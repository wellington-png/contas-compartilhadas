import 'package:conta/screens/group/bloc/group_details/group_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomMembersCard extends StatelessWidget {
  const RoomMembersCard({super.key});

  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Limite de 3 CircleAvatar
                  for (var i = 0; i < 3; i++)
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/room-banner.png'),
                        child: Icon(Icons.person),
                      ),
                    ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: const Icon(
                      Icons.add_circle_outline_outlined,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              // O texto "Membros" fica alinhado à direita
              const Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Membros',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
