import 'package:conta/config/assets/avatar.dart';
import 'package:conta/domain/models/entities/user/user_entity.dart';
import 'package:conta/screens/home/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditUser extends StatefulWidget {
  const EditUser({super.key});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  late final TextEditingController nameController;
  late final TextEditingController fixedIncomeController;

  void _submitData() {
    final String nickname = nameController.text;
    final double? fixedIncome = double.tryParse(fixedIncomeController.text);

    if (nickname.isNotEmpty && fixedIncome != null) {
      final state = context.read<UserBloc>().state;

      if (state.user != null) {
        UserEntity userUpdate = UserEntity(
          id: state.user!.id,
          name: nickname,
          fixedIncome: fixedIncome,
          avatar: state.avatar ?? state.user!.avatar,
          email: state.user!.email,
          accountType: state.user!.accountType,
        );

        context.read<UserBloc>().add(UpdateUserEvent(userUpdate));

        Navigator.pop(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    fixedIncomeController = TextEditingController();

    final UserState state = context.read<UserBloc>().state;

    if (state.user != null) {
      nameController.text = state.user!.name;
      fixedIncomeController.text = state.user!.fixedIncome.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            color: Color(0xFFFFFFFF),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Indicador superior
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Voltar'),
                  ),
                  const Text(
                    'Editar perfil',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: _submitData,
                    child: const Text('Feito'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nome',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: 'Pluddie',
                          border: UnderlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Renda Fixa',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: fixedIncomeController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'R\$ 0,00',
                          border: UnderlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Avatar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 200,
                        child: GridView.count(
                          crossAxisCount: 4,
                          shrinkWrap: true,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          padding: const EdgeInsets.only(top: 8),
                          children: Avatar.values.map((avatar) {
                            return GestureDetector(
                              onTap: () {
                                context.read<UserBloc>().add(UpdateAvatarUserEvent(avatar: avatar));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: state.avatar == avatar
                                        ? Colors.blueAccent
                                        : Colors.transparent,
                                    width: 4.0,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.blueGrey[100],
                                  backgroundImage: AssetImage(avatar.fullPath),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
