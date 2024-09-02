import 'package:conta/screens/group_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conta/screens/home/bloc/groups/groups_bloc.dart';

class CreateGroupDialog extends StatefulWidget {
  const CreateGroupDialog({super.key});

  @override
  State<CreateGroupDialog> createState() => _CreateGroupDialogState();
}

class _CreateGroupDialogState extends State<CreateGroupDialog> {
  final TextEditingController groupNameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    // Solicita foco no campo de entrada quando o diálogo é exibido
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupsBloc, GroupsState>(
      listener: (context, state) {
        if (state.status == GroupsStatus.failure) {
          // Exibe uma mensagem de erro se a criação do grupo falhar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Falha ao criar o grupo: ${state.errorMessage ?? 'Erro desconhecido'}'),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state.status == GroupsStatus.success) {
          // ir para a tela GroupSuccessScreen
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const GroupSuccessScreen(),
            ),
          );
          // Navigator.of(context).pop(); // Fecha o diálogo após sucesso
        }
      },
      child: AlertDialog(
        title: const Text('Novo Grupo'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: groupNameController,
                    decoration: InputDecoration(
                      labelText: 'Nome do Grupo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorText: errorMessage,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'O nome do grupo é obrigatório';
                      }
                      return null;
                    },
                    autofocus: true, // Define foco automático no campo
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        String groupName = groupNameController.text;
                        // Adiciona o evento para criar o grupo
                        context
                            .read<GroupsBloc>()
                            .add(CreateGroupEvent(groupName));
                      } else {
                        setState(() {
                          errorMessage = 'Por favor, insira um nome válido';
                        });
                      }
                    },
                    child: const Text('Criar'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
