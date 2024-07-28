part of 'entrylist_bloc.dart';

sealed class EntryListEvent extends Equatable {
  const EntryListEvent();

  @override
  List<Object> get props => [];
}

class LoadEntries extends EntryListEvent{
  final String uid;

  const LoadEntries(this.uid);
}

class EntriesLoading extends EntryListEvent{}

class AddEntry extends EntryListEvent{
  final EntryModel entry;
  final String uid;

  const AddEntry(this.entry,this.uid);
}

class DeleteEntry extends EntryListEvent{
  final String uid;
  final String journalId;

  const DeleteEntry(this.uid,this.journalId);
}