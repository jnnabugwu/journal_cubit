import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:journal_cubit/domain/usecases/journal_usecases.dart';
import 'package:journal_cubit/presentation/auth_bloc/auth_bloc.dart';
import 'package:journal_cubit/domain/models/entry.dart';

part 'entrylist_event.dart';
part 'entrylist_state.dart';


class EntryListBloc extends Bloc<EntryListEvent, EntryListState> {
  final AddJournalUseCase _addJournalUseCase;
  final GetAllJournalsUseCase _getAllJournalsUseCase;
  final DeleteJournalUseCase _deleteJournalUseCase;
  final UpdateJournalUseCase _updateJournalUseCase;
  final DeleteAllJournalsUseCase _deleteAllJournalsUseCase;
  final AuthBloc _authBloc;
  late final StreamSubscription<AuthState> _authSubscription;

  EntryListBloc({
    required AddJournalUseCase addJournalUseCase,
    required GetAllJournalsUseCase getAllJournalsUseCase,
    required DeleteJournalUseCase deleteJournalUseCase,
    required UpdateJournalUseCase updateJournalUseCase,
    required DeleteAllJournalsUseCase deleteAllJournalsUseCase,
    required AuthBloc authBloc,
  }) : _addJournalUseCase = addJournalUseCase,
       _getAllJournalsUseCase = getAllJournalsUseCase,
       _deleteJournalUseCase = deleteJournalUseCase,
       _updateJournalUseCase = updateJournalUseCase,
       _deleteAllJournalsUseCase = deleteAllJournalsUseCase,
       _authBloc = authBloc,
       super(EntryListInitial(authState: authBloc.state)) {
    
    _authSubscription = _authBloc.stream.listen((authState) {
      if (authState.status == AuthenticationStatus.authenticated && 
          authState.user != null) {
        add(LoadEntries(authState.user!.uid));
      } else if (authState.status == AuthenticationStatus.unauthenticated) {
        add(ResetEntries());
      }
    });
    on<ResetEntries>(_onResetEntries);
    on<AddEntry>(_onAddEntry);
    on<LoadEntries>(_onLoadEntries);
    on<DeleteEntry>(_onDeleteEntry);
    on<EditEntry>(_onEditEntry);
    on<DeleteAllEntries>(_onDeleteAllEntries);
  }

  Future<void> _onAddEntry(AddEntry event, Emitter<EntryListState> emit) async {
    final params = AddJournalParams(
      entryModel: event.entry,
      userId: event.uid,
    );

    final result = await _addJournalUseCase(params);

    result.fold(
      (failure) => emit(EntryListError(failure.message, authState: _authBloc.state)),
      (_) {
        emit(EntryUpdateSuccess('Added Entry', authState: _authBloc.state));
        add(LoadEntries(event.uid)); // Reload entries after adding
      }
    );
  }

  Future<void> _onLoadEntries(LoadEntries event, Emitter<EntryListState> emit) async {
    emit(EntryListLoading(authState: _authBloc.state));
    
    final params = GetAllJournalsParams(userId: event.uid);
    final result = await _getAllJournalsUseCase(params);
    
    result.fold(
      (failure) => emit(EntryListError(failure.message, authState: _authBloc.state)),
      (entries) => emit(EntryListLoaded(entries, authState: _authBloc.state))
    );
  }

  Future<void> _onDeleteEntry(DeleteEntry event, Emitter<EntryListState> emit) async {
    final params = DeleteJournalParams(
      journalId: event.journalId,
      userId: event.uid,
    );

    final result = await _deleteJournalUseCase(params);

    result.fold(
      (failure) => emit(EntryListError(failure.message, authState: _authBloc.state)),
      (_) {
        emit(EntryUpdateSuccess('Journal Deleted', authState: _authBloc.state));
        add(LoadEntries(event.uid)); // Reload entries after deletion
      }
    );
  }

  Future<void> _onEditEntry(EditEntry event, Emitter<EntryListState> emit) async {
    final params = UpdateJournalParams(
      journalId: event.journalId,
      title: event.title,
      content: event.content,
      userId: event.uid,
    );

    final result = await _updateJournalUseCase(params);

    result.fold(
      (failure) => emit(EntryListError(failure.message, authState: _authBloc.state)),
      (_) {
        emit(EntryUpdateSuccess('Journal Edited', authState: _authBloc.state));
        add(LoadEntries(event.uid)); // Reload entries after edit
      }
    );
  }

  Future<void> _onDeleteAllEntries(DeleteAllEntries event, Emitter<EntryListState> emit) async {
    final params = DeleteAllJournalsParams(userId: event.uid);
    final result = await _deleteAllJournalsUseCase(params);

    result.fold(
      (failure) => emit(EntryListError(failure.message, authState: _authBloc.state)),
      (_) {
        emit(EntryUpdateSuccess('All Journals Deleted', authState: _authBloc.state));
        add(LoadEntries(event.uid)); // Reload (empty) entries after deletion
      }
    );
  }

  void _onResetEntries(ResetEntries event, Emitter<EntryListState> emit) {
    emit(EntryListInitial(authState: _authBloc.state));
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}