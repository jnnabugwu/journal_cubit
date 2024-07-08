part of 'entrylist_bloc.dart';

sealed class EntryListEvent extends Equatable {
  const EntryListEvent();

  @override
  List<Object> get props => [];
}

  class LoadEntries extends EntryListEvent{}

  class EntriesLoading extends EntryListEvent {}

  class AddEntry extends EntryListEvent{
    final EntryModel entry;
    final String uid;

    const AddEntry(this.entry, this.uid);
  }

  class UpdateEntry extends EntryListEvent{
    final EntryModel entry;

    const UpdateEntry(this.entry);
  }

  class DeleteEntry extends EntryListEvent{
    final EntryModel entry;

    const DeleteEntry(this.entry);
  }