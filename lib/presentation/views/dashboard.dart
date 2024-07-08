import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal_cubit/domain/models/entry.dart';
import 'package:journal_cubit/presentation/auth_bloc/auth_bloc.dart';
import 'package:journal_cubit/presentation/entrylist_bloc/entrylist_bloc.dart';
import 'package:uuid/uuid.dart';

///What does the dashboard page need 
/// a place to see the count in the right hand corner 
/// A stream builder 

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const routeName = '/dashboard';

  final Uuid uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    final TextEditingController contentController = TextEditingController();
    final TextEditingController titleController = TextEditingController();

    return Scaffold(
      //add place to update journal 
      
      //give two textfields one long 

      appBar: AppBar(actions: const [Text('Whats on your mind?')],),

    body: BlocConsumer<EntryListBloc, EntryListState>(
      listener: (context, state) {
        // TODO: implement listener
      },builder: (context, entryListState) {
        return BlocConsumer<AuthBloc,AuthState>(builder: (context, authState)
       {
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
            ),
          if(authState is SignedIn)
            ElevatedButton(onPressed: 
            () {
              context.read<EntryListBloc>().add(AddEntry(EntryModel(
                title: titleController.value.text, content: contentController.value.text,
                 lastUpdated: DateTime.now(), journalId: uuid.v4()),
                 authState.user.uid));
            }
            , child: const Text('Enter whats on your mind'))
          ],
        );
      }, listener: (BuildContext context, AuthState state) {  },

    );
        },
    ));
  }
}