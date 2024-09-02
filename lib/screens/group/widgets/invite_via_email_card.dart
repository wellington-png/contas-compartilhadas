import 'package:conta/config/services/http_service_impl.dart';
import 'package:conta/domain/repositories/group/group_repository.dart';
import 'package:conta/domain/repositories/group/group_repository_impl.dart';
import 'package:conta/screens/group/bloc/invite/invite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'dart:typed_data';

class InviteViaEmailCard extends StatelessWidget {
  final int? groupId;
  const InviteViaEmailCard({super.key, this.groupId});

  Future<void> _showQRCodeModal(BuildContext context,
      {required String qrCode}) async {
    Uint8List decodedBytes = base64Decode(qrCode);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'QR Code',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Container(
                  width: 150,
                  height: 150,
                  color: Colors.grey[300],
                  child: Image.memory(decodedBytes),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Fechar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return BlocConsumer<InviteBloc, InviteState>(
      listener: (context, state) {
        if (state.status == InviteStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Convite enviado com sucesso!'),
              duration: Duration(seconds: 2),
            ),
          );
          emailController.clear();
        } else if (state.status == InviteStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Não foi possível enviar o convite. talvez o usuário não exista.'),
              duration:  Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Convite via Email',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.qr_code,
                          size: 30, color: Colors.grey),
                      onPressed: () async {
                        if (groupId != null) {
                          GroupRepository groupRepository = GroupRepositoryImpl(
                              httpService: HttpServiceImpl());

                          final result =
                              await groupRepository.inviteQrcode(groupId!);

                          result.fold(
                            (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Erro ao carregar o QR Code: ${error.message}'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            (qrCode) {
                              _showQRCodeModal(context, qrCode: qrCode);
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Entre com endereço de email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon:
                          const Icon(Icons.send, size: 30, color: Colors.blue),
                      onPressed: () {
                        String email = emailController.text.trim();
                        if (email.isNotEmpty) {
                          final inviteBloc =
                              BlocProvider.of<InviteBloc>(context);
                          inviteBloc.add(
                              SendInviteEvent(groupId: groupId!, email: email));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Por favor, insira um endereço de email válido.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
