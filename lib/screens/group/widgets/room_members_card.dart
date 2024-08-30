import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomMembersCard extends StatelessWidget {
  const RoomMembersCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/room-banner.png'),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Icons.add, color: Colors.blue),
                ),
              ],
            ),
            const Expanded(child:  Text('Membros')),
          ],
        ),
      ),
    );
  }
}