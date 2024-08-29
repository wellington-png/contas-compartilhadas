import 'package:conta/screens/group/widgets/debt_status_card.dart';
import 'package:conta/screens/group/widgets/invite_via_email_card.dart';
import 'package:conta/screens/group/widgets/overall_balance_card.dart';
import 'package:conta/screens/group/widgets/room_members_card.dart';
import 'package:conta/screens/group/widgets/title_and_dropdown.dart';
import 'package:flutter/material.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange[50],
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.grey),
            onPressed: () {
              // Ação do botão de configurações
            },
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleAndDropdown(),
              SizedBox(height: 16),
              RoomMembersCard(),
              SizedBox(height: 16),
              OverallBalanceCard(),
              SizedBox(height: 16),
              InviteViaEmailCard(),
              SizedBox(height: 16),
              DebtStatusCard(),
            ],
          ),
        ),
      ),
    );
  }
}
