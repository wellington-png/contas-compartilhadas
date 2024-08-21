import 'package:conta/config/theme.dart';
import 'package:flutter/material.dart';

class GroupSettings extends StatefulWidget {
  const GroupSettings({super.key});

  @override
  State<GroupSettings> createState() => _GroupSettingsState();
}

class _GroupSettingsState extends State<GroupSettings> {
  static const String _titleText = 'Configurações';
  static const String _leadingText = 'Voltar';
  static const String _actionSaveText = 'Salvar';
  // static const String _deleteGroupText = 'Apagar Grupo';

  // Informações do grupo
  final String groupOwner = 'João da Silva';
  final String creationDate = '15 de Agosto de 2024';

  List<String> members = [
    'Membro 1',
    'Membro 2',
    'Membro 3',
    // Adicione mais membros conforme necessário
  ];


  void _deleteGroup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apagar Grupo'),
        content: const Text('Você tem certeza que deseja apagar este grupo?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // Lógica para apagar o grupo
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Voltar para a tela anterior
            },
            child: const Text('Apagar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          _titleText,
          style: TextStyle(
              color: AppColors.textBigTitle, fontWeight: FontWeight.bold),
        ),
        leading: const TextButton(onPressed: null, child: Text(_leadingText)),
        leadingWidth: 70,
        centerTitle: true,
        actions: const [
          TextButton(
            onPressed: null,
            child: Text(
              _actionSaveText,
              style: TextStyle(
                  color: AppColors.textBigTitle, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Image.asset('assets/images/room-banner.png'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person,
                        color: AppColors.primaryBlue, size: 15),
                    const SizedBox(width: 10),
                    Text(
                      'Dono: $groupOwner',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      color: AppColors.primaryBlue,
                      size: 15,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Criado em: $creationDate',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.house_outlined,
                    color: AppColors.primaryBlue, size: 30),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Nome do grupo',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _deleteGroup,
        backgroundColor: Colors.red,
        child: const Icon(Icons.delete),
      ),
    );
  }
}
