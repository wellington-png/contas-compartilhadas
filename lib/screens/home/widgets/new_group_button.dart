import 'package:conta/screens/home/bloc/groups/groups_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'create_group_dialog.dart';
import 'package:conta/screens/scanner_qrcode/scanner_qrcode.dart';

class NewGroupButton extends StatelessWidget {
  const NewGroupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () => _showCreateGroupDialog(context),
          icon: const Icon(Icons.add),
          label: const Text('Novo Grupo'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlueAccent,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            minimumSize: const Size(160, 50),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => _navigateToScanner(context),
          icon: const Icon(Icons.qr_code_scanner),
          label: const Text('Escanear'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            minimumSize: const Size(160, 50),
          ),
        ),
      ],
    );
  }

  void _showCreateGroupDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.white,
      builder: (BuildContext modalContext) {
        return BlocProvider.value(
          value: BlocProvider.of<GroupsBloc>(context),
          child: const CreateGroupDialog(),
        );
      },
    );
  }

  void _navigateToScanner(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BarcodeScannerWithOverlay(),
      ),
    );
  }
}
