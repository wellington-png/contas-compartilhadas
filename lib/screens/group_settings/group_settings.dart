import 'package:conta/config/theme.dart';
import 'package:conta/screens/group/bloc/group_details/group_details_bloc.dart';
import 'package:conta/screens/home/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class GroupSettings extends StatefulWidget {
  const GroupSettings({super.key});

  @override
  State<GroupSettings> createState() => _GroupSettingsState();
}

class _GroupSettingsState extends State<GroupSettings> {
  static const String _titleText = 'Configurações';
  static const String _leadingText = 'Voltar';
  static const String _actionSaveText = 'Salvar';

  final String groupOwner = 'DONO';
  late TextEditingController _groupNameController;

  @override
  void initState() {
    super.initState();
    final state = BlocProvider.of<GroupDetailsBloc>(context).state;
    _groupNameController = TextEditingController(text: state.group?.name ?? '');
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  void _updateGroupName(int id) {
    final newName = _groupNameController.text;

    if (newName.isNotEmpty) {
      context.read<GroupDetailsBloc>().add(
            UpdateGroupNameEvent(id: id, name: newName),
          );
    } else {
      _showErrorSnackBar();
    }
  }

  void _deleteGroup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apagar Grupo'),
        content: const Text('Você tem certeza que deseja apagar este grupo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Apagar'),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Erro ao carregar detalhes do grupo'),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        _titleText,
        style: TextStyle(
          color: AppColors.textBigTitle,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: const TextButton(onPressed: null, child: Text(_leadingText)),
      leadingWidth: 70,
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text(
            _actionSaveText,
            style: TextStyle(
              color: AppColors.textBigTitle,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGroupInfo(GroupDetailState state) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.person, color: AppColors.primaryBlue, size: 15),
            const SizedBox(width: 10),
            Text(
              'Dono: ${state.group?.ownerName ?? groupOwner}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const Icon(Icons.calendar_today,
                color: AppColors.primaryBlue, size: 15),
            const SizedBox(width: 10),
            Text(
              'Criado em: ${dateFormat.format(state.group?.createdAt ?? DateTime.now())}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGroupNameField(int ownerId, int userId, int groupId) {
    bool isNotZero = ownerId != 0 && userId != 0;
    bool isOwner = ownerId == userId;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Icon(Icons.house_outlined,
              color: AppColors.primaryBlue, size: 30),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _groupNameController,
              decoration: const InputDecoration(hintText: 'Nome do grupo'),
              enabled: isNotZero && isOwner,
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: AppColors.primaryBlue),
            onPressed:
                isNotZero && isOwner ? () => _updateGroupName(groupId) : null,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupDetailsBloc, GroupDetailState>(
      listener: (context, state) {
        if (state.status == GroupDetailStatus.failure) {
          _showErrorSnackBar();
        }
        if (state.status == GroupDetailStatus.success) {
          final groupId = state.group?.id; // Acesse o id do grupo
          if (groupId != null) {
            context
                .read<GroupDetailsBloc>()
                .add(GetGroupDetailsEvent(id: groupId));
          }
        }
      },
      builder: (context, state) {
        final stateUser = BlocProvider.of<UserBloc>(context).state;
        int ownerId = state.group?.owner ?? 0;
        int userId = stateUser.user?.id ?? 0;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/images/room-banner.png'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildGroupInfo(state),
                ),
                const SizedBox(height: 20),
                _buildGroupNameField(ownerId, userId, state.group?.id ?? 0),
                const SizedBox(height: 20),
                const SizedBox(height: 10),
                ExpansionTile(
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  title: const Text(
                    'Membros',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  initiallyExpanded: true,
                  children: [
                    ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: state.group?.members.length ?? 0,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final member = state.group!.members[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(member.name[0]),
                            ),
                            title: Text(member.name),
                            trailing: ownerId != member.id && ownerId == userId
                                ? IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return AlertDialog(
                                            title: const Text('Remover Membro'),
                                            content: const Text(
                                                'Você tem certeza que deseja remover este membro do grupo?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(dialogContext)
                                                      .pop(); // Fecha o diálogo
                                                },
                                                child: const Text('Cancelar'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  final group = state.group;
                                                  if (group != null) {
                                                    context
                                                        .read<
                                                            GroupDetailsBloc>()
                                                        .add(
                                                          RemoveMemberEvent(
                                                            id: group.id,
                                                            memberId: member.id,
                                                          ),
                                                        );
                                                    Navigator.of(dialogContext)
                                                        .pop(); // Fecha o diálogo
                                                  } else {
                                                    _showErrorSnackBar();
                                                  }
                                                },
                                                child: const Text('Remover'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _deleteGroup,
            backgroundColor: Colors.red,
            child: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
