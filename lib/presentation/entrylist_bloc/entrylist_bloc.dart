import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:journal_cubit/data/datasources/journal_remote_datasource.dart';
import 'package:journal_cubit/domain/models/entry.dart';
import 'package:journal_cubit/presentation/auth_bloc/auth_bloc.dart';

part 'entrylist_event.dart';
part 'entrylist_state.dart';

class EntryListBloc extends Bloc<EntryListEvent, EntryListState> {
  final JournalRemoteDataSource _dataSource;
  final AuthBloc _authBloc;
  late final StreamSubscription<AuthState> _authSubscription;

  EntryListBloc({
    required JournalRemoteDataSource dataSource,
    required AuthBloc authBloc,
  }) : _dataSource = dataSource,
       _authBloc = authBloc,
       super(EntryListInitial(authState: authBloc.state)) {
    
    // Subscribe to AuthBloc state changes
    _authSubscription = _authBloc.stream.listen((authState) {
      if (authState.status == AuthenticationStatus.authenticated && authState.user != null) {
        add(LoadEntries(authState.user!.uid));
      } else if (authState.status == AuthenticationStatus.unauthenticated) {
        add(ResetEntries());
      }
    });


    on<ResetEntries>(_onResetEntries);
    on<AddEntry>(_onAddEntry);
    on<LoadEntries>(_getEntries);
    on<DeleteEntry>(_deleteJournal);
    on<EditEntry>(_editJournal);
  }




    Future<void> _onAddEntry(AddEntry event, Emitter<EntryListState> emit) async {
      try {
        await _dataSource.addJournalEntry(entryModel: event.entry, userId: event.uid);
        emit(EntryUpdateSuccess('Added Entry', authState: _authBloc.state));
        final updatedEntries = _dataSource.getAllJournals(userId: event.uid);
        emit(EntryListLoaded(updatedEntries, authState: _authBloc.state)); 
      } catch (e) {
        emit(EntryListError('didnt add entry', authState: _authBloc.state));
      }
    }



  Future<void> _getEntries(LoadEntries event, Emitter<EntryListState> emit) async {
    var entries = _dataSource.getAllJournals(userId: event.uid);
    emit(EntryListLoaded(entries, authState: _authBloc.state)); 
  }

  Future<void> _deleteJournal(DeleteEntry event, Emitter<EntryListState> emit) async {
    try {
      _dataSource.deleteJournalEntry(journalId: event.journalId, uid: event.uid);
      final updatedEntries = _dataSource.getAllJournals(userId: event.uid);
      emit(EntryUpdateSuccess('Journal Deleted', authState: _authBloc.state));
      emit(EntryListLoaded(updatedEntries,  authState: _authBloc.state));
    } catch(e) {
      emit(EntryListError('Journal did not delete', authState:  _authBloc.state));
    }
  }

  Future<void> _editJournal(EditEntry event, Emitter<EntryListState> emit) async {
    try {
      _dataSource.updateJournalEntry(
        journalId: event.journalId, 
        title: event.title, 
        content: event.content, 
        uid: event.uid
      );
      emit(EntryUpdateSuccess('Journal Edited', authState: _authBloc.state));
      final updatedEntries = _dataSource.getAllJournals(userId: event.uid);
      emit(EntryListLoaded(updatedEntries, authState: _authBloc.state));      
    } catch(e) {
      emit(EntryListError('Journal did not update', authState: _authBloc.state));
    }
  }

  Future<void> _onResetEntries(ResetEntries event, Emitter<EntryListState> emit) async {
    try{
      emit(EntryListInitial(authState: _authBloc.state));
    } catch(e){
      emit(EntryListError('Did not reset', authState: _authBloc.state));
    }
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }


}