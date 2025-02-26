//I want to add journal, get journals, delete, journals
import 'package:journal_cubit/core/utils/typedef.dart';
import 'package:journal_cubit/domain/models/entry.dart';

abstract class JournalRepository {
  ResultFuture<void> addJournal({required EntryModel entryModel, required String userId});
  ResultFuture<void> deleteJournal({required String journalId, required String userId});
  ResultFuture<List<EntryModel>> getAllJournals({required String userId});
  ResultFuture<void> updateJournal({
    required String journalId,
    required String title,
    required String content,
    required String userId
  });
  ResultFuture<void> deleteAllJournals({required String userId});
}


