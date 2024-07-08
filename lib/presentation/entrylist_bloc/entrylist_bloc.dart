import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journal_cubit/data/datasources/auth_remote_data_source.dart';
import 'package:journal_cubit/data/datasources/journal_remote_datasource.dart';
import 'package:journal_cubit/domain/models/entry.dart';

part 'entrylist_event.dart';
part 'entrylist_state.dart';

class EntryListBloc extends Bloc<EntryListEvent, EntryListState> {
  final JournalRemoteDataSource _dataSource;
  
  late Stream<List<EntryModel>> dataStream;
  late String uid;
  final AuthRemoteDataSource _authRemoteDataSource;
  
  //add [this._dataSource] is intializing it
  EntryListBloc(this._dataSource, this._authRemoteDataSource) : super(EntrylistInitial()) {
    on<LoadEntries>((event, emit) async {
      // TODO: implement event handler
      uid = await _authRemoteDataSource.getCurrentUserId();
      try{
        emit(EntryListLoading());
        final entries = _dataSource.getAllJournals(userId: uid);
        dataStream = entries;

        dataStream.listen((event) {
          (event) {
            emit(EntryListLoaded(event.data));
          }; 
        });
      }
      catch (e) {
          throw 'Couldnt get journals';
      }
    });

    on<AddEntry>((event, emit) async {
      try{
        emit(EntryListLoading());
        await _dataSource.addJournalEntry(entryModel: event.entry, userId: event.uid);
        emit(const EntryUpdateSuccess('Added Entry'));
      } catch (e) {
        emit(const EntryListError('Didnt add entry'));
        throw 'Didnt add entry';
      }
    });
  }
}
