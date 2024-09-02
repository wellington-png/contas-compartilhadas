import 'package:conta/config/theme.dart';
import 'package:flutter/material.dart';

import './widgets/avatar_header.dart';
import 'widgets/new_group_button.dart';
import './widgets/room_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.bgPeach,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AvatarHeader(),
                  SizedBox(height: 20),
                  NewGroupButton(),
                  SizedBox(height: 20),
                  Expanded(
                    child: RoomList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
