import 'package:bloc/bloc.dart';
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
  }
}
