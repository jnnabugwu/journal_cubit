part of 'entrylist_bloc.dart';

sealed class EntryListState extends Equatable {
  final AuthState authState;

  const EntryListState({required this.authState});
  
  @override
  List<Object> get props => [authState];
}

final class EntryListInitial extends EntryListState {
  const EntryListInitial({required super.authState});
}

class EntryListLoading extends EntryListState {
  const EntryListLoading({required super.authState});
}

class EntryListLoaded extends EntryListState {
  final List<EntryModel> entries;

  const EntryListLoaded(this.entries, {required super.authState});

  @override
  List<Object> get props => [entries, authState];
}

class EntryUpdateSuccess extends EntryListState {
  final String message;

  const EntryUpdateSuccess(this.message, {required super.authState});

  @override
  List<Object> get props => [message, authState];
}

class EntryListError extends EntryListState {
  final String message;
  
  const EntryListError(this.message, {required super.authState});

  @override
  List<Object> get props => [message, authState];
}