import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal_cubit/core/utils/core_utils.dart';
import 'package:journal_cubit/domain/models/entry.dart';
import 'package:journal_cubit/presentation/auth_bloc/auth_bloc.dart';
import 'package:journal_cubit/presentation/bloc/entrylist_bloc.dart';
import 'package:uuid/uuid.dart';
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  
  static const routeName = '/dashboard';

  final Uuid uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    final TextEditingController contentController = TextEditingController();
    final TextEditingController titleController = TextEditingController();

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Text(authState.user?.name ?? 'Hello not signed in')
            ]
          ),
          body: BlocConsumer<EntryListBloc, EntryListState>(
            builder: (context, entryListState) {
              return Column(
                children: [
                  const SizedBox(height: 50),
                  TextField(
                    controller: titleController,
                    style: const TextStyle(color: Colors.green, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: contentController,
                    style: const TextStyle(color: Colors.black),
                    maxLines: 6,
                  ),
                  if (authState.status == AuthenticationStatus.authenticated)
                    ElevatedButton(
                      onPressed: () {
                        context.read<EntryListBloc>().add(AddEntry(
                          EntryModel(
                            content: contentController.text,
                            title: titleController.text,
                            lastUpdated: DateTime.now(),
                            journalId: uuid.v4()
                          ),
                          'lkalkcasjclkasc'
                        ));
                      },
                      child: const Text('Enter what\'s on your mind')
                    )
                ]
              );
            },
            listener: (BuildContext context, EntryListState state) {
              if (state is EntryUpdateSuccess) {
                CoreUtils.showSnackBar(context, 'Added your note');
              }
              if (state is EntryListError) {
                CoreUtils.showSnackBar(context, 'Something went wrong');
              }
            },
          ),
        );
      },
    );
  }
}