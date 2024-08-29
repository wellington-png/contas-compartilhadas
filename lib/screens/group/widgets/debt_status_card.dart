import 'package:flutter/material.dart';
import 'package:conta/screens/group/widgets/debt_status_row.dart';

class DebtStatusCard extends StatelessWidget {
  const DebtStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> debts = [
      {
        'avatarPath': 'assets/images/room-banner.png',
        'name': 'Pluddie',
        'debtAmount': '\$2,937',
        'subName': 'Zebra',
      },
      {
        'avatarPath': 'assets/images/room-banner.png',
        'name': 'Whale',
        'debtAmount': '\$338',
        'subName': 'Zebra',
      },
      {
        'avatarPath': 'assets/images/room-banner.png',
        'name': 'Kitty',
        'debtAmount': '\$1,435',
        'subName': 'Zebra',
      },
            {
        'avatarPath': 'assets/images/room-banner.png',
        'name': 'Kitty',
        'debtAmount': '\$1,435',
        'subName': 'Zebra',
      },
            {
        'avatarPath': 'assets/images/room-banner.png',
        'name': 'Kitty',
        'debtAmount': '\$1,435',
        'subName': 'Zebra',
      },
            {
        'avatarPath': 'assets/images/room-banner.png',
        'name': 'Kitty',
        'debtAmount': '\$1,435',
        'subName': 'Zebra',
      },
            {
        'avatarPath': 'assets/images/room-banner.png',
        'name': 'Kitty',
        'debtAmount': '\$1,435',
        'subName': 'Zebra',
      },
            {
        'avatarPath': 'assets/images/room-banner.png',
        'name': 'Kitty',
        'debtAmount': '\$1,435',
        'subName': 'Zebra',
      },
            {
        'avatarPath': 'assets/images/room-banner.png',
        'name': 'Kitty',
        'debtAmount': '\$1,435',
        'subName': 'Zebra',
      },
            {
        'avatarPath': 'assets/images/room-banner.png',
        'name': 'Kitty',
        'debtAmount': '\$1,435',
        'subName': 'Zebra',
      },
            {
        'avatarPath': 'assets/images/room-banner.png',
        'name': 'Kitty',
        'debtAmount': '\$1,435',
        'subName': 'Zebra',
      },
    ];

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dívidas Pendentes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...debts.map((debt) {
              return Column(
                children: [
                  DebtStatusRow(
                    avatarPath: debt['avatarPath']!,
                    name: debt['name']!,
                    debtAmount: debt['debtAmount']!,
                    subName: debt['subName']!,
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 30,
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
