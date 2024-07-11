part of 'entrylist_bloc.dart';

sealed class EntryListState extends Equatable {
  const EntryListState();
  
  @override
  List<Object> get props => [];
}

final class EntryListInitial extends EntryListState {}

class EntryListLoading extends EntryListState {}

class EntryListLoaded extends EntryListState {
  final List<EntryModel> entries;

  const EntryListLoaded(this.entries);
}

class EntryUpdateSuccess extends EntryListState {
  final String message;

  const EntryUpdateSuccess(this.message);
}

class EntryListError extends EntryListState {
  final String message;
  
  const EntryListError(this.message);
}