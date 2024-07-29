import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal_cubit/core/utils/core_utils.dart';
import 'package:journal_cubit/domain/models/entry.dart';
import 'package:journal_cubit/presentation/auth_bloc/auth_bloc.dart';
import 'package:journal_cubit/presentation/entrylist_bloc/entrylist_bloc.dart';
import 'package:uuid/uuid.dart';
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static const routeName = '/dashboard';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final Uuid uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(CheckCachedUser());
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController contentController = TextEditingController();
    final TextEditingController titleController = TextEditingController();
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (context, authState) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Text(authState.user?.name ?? 'Hello not signed in')
            ]
          ),
          body: BlocConsumer<EntryListBloc, EntryListState>(
            builder: (context, entryListState) {
              //
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
                            journalId: uuid.v4(),
                            userId: authState.user!.uid
                          ),
                          authState.user!.uid
                        ));
                        titleController.clear();
                        contentController.clear();
                      },
                      child: const Text('Enter what\'s on your mind')
                    ),
                   const SizedBox(height: 10),
                   ///How do i access the stream from state. 
                   if (entryListState is EntryListLoaded)
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: entryListState.entries,
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var doc = snapshot.data!.docs[index];
                          return Card(
                            child: ListTile(
                              title: Text(doc['title'] ?? ''),
                              subtitle: Text(doc['content'] ?? ''),
                              trailing: Text(doc['lastUpdated'].toDate().toString()),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
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
      }, listener: (BuildContext context, AuthState authState) {
    if (authState.status == AuthenticationStatus.authenticated && authState.user != null) {
    context.read<EntryListBloc>().add(LoadEntries(authState.user!.uid));
    }
    },
    );
  }
}