import 'package:conta/config/routes/router.dart';
import 'package:conta/config/theme.dart';
import 'package:conta/screens/home/bloc/groups/groups_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class RoomList extends StatefulWidget {
  const RoomList({super.key});

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsBloc, GroupsState>(builder: (context, state) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Meus Grupos',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh, color: AppColors.primaryYellow),
                    onPressed: () {
                      // Dispara o evento para recarregar os grupos
                      context.read<GroupsBloc>().add(const GetGroupsEvent());
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: state.groups != null && state.groups!.isNotEmpty
                  ? ListView.builder(
                      itemCount: state.groups?.length,
                      itemBuilder: (context, index) {
                        final group = state.groups![index];
                        return Slidable(
                          key: ValueKey(group.id),

                          // Configuração do ActionPane no lado direito
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (_) {
                                  _showDeleteConfirmationDialog(
                                    context,
                                    group.id,
                                    () {
                                      context.read<GroupsBloc>().add(
                                        DeleteGroupEvent(group.id),
                                      );
                                    },
                                  );
                                },
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Excluir',
                              ),
                            ],
                          ),

                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: AppColors.primaryYellow,
                              child: Icon(
                                Icons.group,
                                color: AppColors.textBigTitle,
                              ),
                            ),
                            title: Text(
                              group.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBigTitle,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  Routes.group,
                                  arguments: group.id,
                                );
                              },
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Nenhum grupo disponível no momento.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      );
    });
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, int groupId, VoidCallback onDelete) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir Grupo'),
          content: const Text('Você tem certeza que deseja excluir este grupo?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                onDelete();
                Navigator.of(context).pop();
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }
}
