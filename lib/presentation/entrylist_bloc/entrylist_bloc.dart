import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:journal_cubit/data/datasources/journal_remote_datasource.dart';
import 'package:journal_cubit/domain/models/entry.dart';

part 'entrylist_event.dart';
part 'entrylist_state.dart';

class EntryListBloc extends Bloc<EntryListEvent, EntryListState> {
  final JournalRemoteDataSource _dataSource;

  EntryListBloc(this._dataSource) : super(EntryListInitial()) {
    on<AddEntry>((event, emit) async {
        try{
          await _dataSource.addJournalEntry(entryModel: event.entry, userId: event.uid);
          emit(const EntryUpdateSuccess('Added Entry'));
        }catch (e){
          emit(const EntryListError('didnt add entry'));
        }
    });
    on<LoadEntries>(_getEntries);
    on<DeleteEntry>(_deleteJournal);
    on<EditEntry>(_editJournal);
  
  }

   Future<void> _getEntries(LoadEntries event, Emitter<EntryListState> emit) async {
    ///get entries from firestore
    var entries = _dataSource.getAllJournals(userId: event.uid);
    emit(EntryListLoaded(entries)); 

  }

  Future<void> _deleteJournal(DeleteEntry event, Emitter<EntryListState> emit) async {
    try {
    _dataSource.deleteJournalEntry(journalId: event.journalId, uid: event.uid);
    emit(const EntryUpdateSuccess('Journal Deleted'));
    } catch(e){
      emit(const EntryListError('Journal did not delete'));
    }
  }

  Future<void> _editJournal(EditEntry event, Emitter<EntryListState> emit) async {
    try{
      _dataSource.updateJournalEntry(journalId: event.journalId, title: event.title, content: event.content);
      emit(const EntryUpdateSuccess('Journal Edited'));
    }catch(e){
      emit(const EntryListError('Journal did not update'));
    }
  }
 
}
