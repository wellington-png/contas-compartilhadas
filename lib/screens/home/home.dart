import 'package:conta/screens/home/widgets/draggable_scrollable_sheet_widget.dart';
import 'package:flutter/material.dart';

import './widgets/avatar_header.dart';
import './widgets/new_room_button.dart';
import './widgets/room_list.dart';
import './widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Stack(
        children: [
          SafeArea(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AvatarHeader(),
                  SizedBox(height: 20),
                  NewRoomButton(),
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
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
