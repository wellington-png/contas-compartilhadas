import 'package:conta/screens/home/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './draggable_scrollable_sheet_widget.dart'; // Atualize o caminho conforme necessário

class AvatarHeader extends StatefulWidget {
  const AvatarHeader({super.key});

  @override
  State<AvatarHeader> createState() => _AvatarHeaderState();
}

class _AvatarHeaderState extends State<AvatarHeader> {
  bool isExpanded = false;

  void _toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      return Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/bgimg1.png'),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.user?.name ?? '',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Text(
                'ID #0309',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                barrierColor: Colors.transparent,
                isScrollControlled: false,
                backgroundColor: Colors.transparent,

                builder: (context) {
                  return const DraggableScrollableSheetWidget();
                },
              );
            },
            icon: const Icon(Icons.settings),
            color: Colors.grey,
          ),
        ],
      );
    });
  }
}
