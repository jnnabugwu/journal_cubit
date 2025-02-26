part of 'entrylist_bloc.dart';

sealed class EntryListEvent extends Equatable {
  const EntryListEvent();

  @override
  List<Object> get props => [];
}

class ResetEntries extends EntryListEvent {}

class LoadEntries extends EntryListEvent {
  final String uid;

  const LoadEntries(this.uid);

  @override
  List<Object> get props => [uid];
}

class AddEntry extends EntryListEvent {
  final EntryModel entry;
  final String uid;

  const AddEntry(this.entry, this.uid);

  @override
  List<Object> get props => [entry, uid];
}

class DeleteAllEntries extends EntryListEvent {
  final String uid;

  const DeleteAllEntries(this.uid);

  @override
  List<Object> get props => [uid];
}

class DeleteEntry extends EntryListEvent {
  final String uid;
  final String journalId;

  const DeleteEntry(this.uid, this.journalId);

  @override
  List<Object> get props => [uid, journalId];
}

class EditEntry extends EntryListEvent {
  final String journalId;
  final String title;
  final String content;
  final String uid;

  const EditEntry(this.journalId, this.title, this.content, this.uid);

  @override
  List<Object> get props => [journalId, title, content, uid];
}