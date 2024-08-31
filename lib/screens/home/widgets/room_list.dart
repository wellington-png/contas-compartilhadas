import 'package:conta/config/routes/router.dart';
import 'package:conta/config/theme.dart';
import 'package:conta/screens/home/bloc/groups/groups_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomList extends StatefulWidget {
  const RoomList({super.key});

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  // void _getGroupDetails(int id) {
  //   context.read<GroupDetailsBloc>().add(
  //         GetGroupDetailsEvent(
  //           id: id,
  //         ),
  //       );
  // }

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
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Meus Grupos',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Expanded(
              child: state.groups != null && state.groups!.isNotEmpty
                  ? ListView.builder(
                      itemCount: state.groups?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: AppColors.primaryYellow,
                            child: Icon(
                              Icons.group,
                              color: AppColors.textBigTitle,
                            ),
                          ),
                          title: Text(
                            state.groups![index].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textBigTitle,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.arrow_forward_ios),
                            onPressed: () {
                              // _getGroupDetails(state.groups![index].id);
                              Future.delayed(const Duration(milliseconds: 500), () {
                                Navigator.of(context).pushNamed(Routes.group, arguments: state.groups![index].id);
                              });
                            },
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
}
