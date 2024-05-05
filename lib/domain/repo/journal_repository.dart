//I want to add journal, get journals, delete, journals
import 'package:journal_cubit/domain/models/entry.dart';

abstract class JournalRepository {
  const JournalRepository();
  Future<void> addJournal({required EntryModel entryModel});
  Future<void> delete({int journalId});
  Future<List<EntryModel>> getAllJournals();
}
