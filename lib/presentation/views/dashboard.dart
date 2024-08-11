import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal_cubit/core/common/i_field.dart';
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
    var size = MediaQuery.of(context).size;
    final width = size.width;

    return BlocConsumer<AuthBloc, AuthState>(
      builder: (context, authState) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(padding: EdgeInsets.only(right: width * .45 ),child: Text(authState.user?.name ?? 'Hello not signed in'))
            ]
          ),
          body: BlocConsumer<EntryListBloc, EntryListState>(
            builder: (context, entryListState) {
              //
              return Column(
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IField(
                      controller: titleController,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IField(
                      controller: contentController,
                      textLines: 6,
                      inputDecoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            // overwriting the default padding helps with that puffy look
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                    ),
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
                          return Dismissible(
                              key: ValueKey(doc['journalId']),
                              background: showBackground(0),
                              secondaryBackground: showBackground(1),
                              onDismissed: (_) {
                                context.read<EntryListBloc>().add(DeleteEntry(
                                  authState.user!.uid, doc['journalId']
                                  ));
                              },
                            confirmDismiss: (_) {
                              return showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Are you sure?'),
                                    content: const Text('Do you really want to delete?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, false),
                                        child: const Text('NO'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context,true),
                                        child: const Text('Yes'),
                                      )
                                    ],
                                  );
                                });
                            },
                            child:   Card(
                            child: ListTile(
                              onTap: () {
                                showJournal(doc['title'], doc['content'],
                                 doc['journalId'], authState.user!.uid);
                              },
                              title: Text(doc['title'] ?? ''),
                              subtitle: Text(doc['content'] ?? ''),
                              trailing: Text(doc['lastUpdated'].toDate().toString()),
                            ),
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
                CoreUtils.showSnackBar(context, state.message);
              }
              if (state is EntryListError) {
                CoreUtils.showSnackBar(context, state.message);
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

  Widget showBackground(int direction){
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 30,
        color: Colors.white
      )
    );
  }

  showJournal(String title, String content, String journalId, String uid){
    final entryListBloc = context.read<EntryListBloc>();
    final TextEditingController contentPopupController = TextEditingController(
          text: content
        );
    final TextEditingController titlePopupController = TextEditingController(
      text: title
    );
    bool isNotEditting = true;


    return showDialog(
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(builder: (context,setState){
          return SimpleDialog(
          title: const Text('Edit'),
          children: [
            Column(
              children: [
                /// Need to show the same thing from the creation screen
                /// two text fields 
                /// an edit button and a save button 
                IField(
                    controller: titlePopupController,
                    enabled: !isNotEditting,
                  ),
                  const SizedBox(height: 20),
                  IField(
                    controller: contentPopupController,
                    textLines: 6,
                    enabled: !isNotEditting,
                    inputDecoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            // overwriting the default padding helps with that puffy look
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                  ),
               const SizedBox(
                    height: 30,
                ),
                ElevatedButton(onPressed: () {
                  setState(() {
                    isNotEditting = false;
                  });
                }, 
                child: const Text('Edit Journal')
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: isNotEditting ? null : () {
                  setState(() {
                    entryListBloc.add(EditEntry(journalId, titlePopupController.value.text,
                     contentPopupController.value.text, uid));
                    isNotEditting = true;
                    Navigator.of(context).pop();
                  });
                }, 
                child: const Text('Save Edits Journal')
                )
              ],
            )
          ],
        );
        });
    });
  }
}