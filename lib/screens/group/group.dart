import 'package:conta/screens/expenses/bloc/expense/expense_bloc.dart';
import 'package:conta/screens/group/bloc/group_details/group_details_bloc.dart';
import 'package:conta/screens/group/widgets/debt_status_card.dart';
import 'package:conta/screens/group/widgets/invite_via_email_card.dart';
import 'package:conta/screens/group/widgets/overall_balance_card.dart';
import 'package:conta/screens/group/widgets/room_members_card.dart';
import 'package:conta/screens/group/widgets/title_and_dropdown.dart';
import 'package:conta/screens/group_settings/group_settings.dart';
import 'package:conta/screens/home/bloc/groups/groups_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final groupBloc = BlocProvider.of<GroupDetailsBloc>(context);
    final expenseBloc = BlocProvider.of<ExpenseBloc>(context);
    if (groupBloc.state.group == null) {
      final int groupId = ModalRoute.of(context)!.settings.arguments as int;
      groupBloc.add(GetGroupDetailsEvent(id: groupId));
    }
    expenseBloc.add(ExpenseListRequested(
        groupId: ModalRoute.of(context)!.settings.arguments as int,
        month: DateTime.now().month,
        year: DateTime.now().year));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupDetailsBloc, GroupDetailState>(
      builder: (context, state) {
        if (state.status == GroupDetailStatus.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status == GroupDetailStatus.failure) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Detalhes do grupo'),
            ),
            body: const Center(
              child: Column(
                children: [
                  const Text(
                    'Erro ao carregar detalhes do grupo',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        }

        if (state.group == null) {
          return const Scaffold(
            body: Center(child: Text('Nenhum detalhe do grupo disponível')),
          );
        }

        return Scaffold(
          backgroundColor: Colors.orange[50],
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.orange[50],
            title: Text(state.group!.name),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.grey),
                onPressed: () {
                  final bloc = BlocProvider.of<GroupDetailsBloc>(context);
                  if (bloc.state.group != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: bloc,
                          child: const GroupSettings(),
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Detalhes do grupo ainda não carregados.'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleAndDropdown(),
                  const SizedBox(height: 16),
                  const RoomMembersCard(),
                  const SizedBox(height: 16),
                  const OverallBalanceCard(),
                  const SizedBox(height: 16),
                  InviteViaEmailCard(groupId: state.group!.id),
                  const SizedBox(height: 16),
                  DebtStatusCard(groupId: state.group!.id),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
