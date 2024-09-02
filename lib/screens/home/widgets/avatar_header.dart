import 'package:conta/screens/home/bloc/user/user_bloc.dart';
import 'package:conta/screens/home/widgets/edit_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvatarHeader extends StatefulWidget {
  const AvatarHeader({super.key});

  @override
  State<AvatarHeader> createState() => _AvatarHeaderState();
}

class _AvatarHeaderState extends State<AvatarHeader> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state.status == UserStatus.success && state.user != null) {
          final user = state.user!;
          final avatarPath = user.avatar.fullPath;
          return Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(avatarPath),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'ID #${user.id.toString().padLeft(4, '0')}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'R\$ ${user.fixedIncome.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    barrierColor: Colors.transparent,
                    backgroundColor: Colors.white,
                    builder: (BuildContext modalContext) {
                      return BlocProvider.value(
                        value: BlocProvider.of<UserBloc>(context),
                        child: const EditUser(),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.settings),
                color: Colors.grey,
              ),
            ],
          );
        } else if (state.status == UserStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(
            child: Text(
              'Erro ao carregar usuário',
              style: TextStyle(color: Colors.red),
            ),
          );
        }
      },
    );
  }
}
