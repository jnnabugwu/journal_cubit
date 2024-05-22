import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:journal_cubit/domain/models/entry.dart';

abstract class JournalRemoteDataSource {
  const JournalRemoteDataSource();

  ///Need to get journals
  ///add journals
  ///delete journals
  ///update journals

  Future<void> addJournalEntry(
      {required EntryModel entryModel, required String userId});
  Future<List<EntryModel>> getAllJournals({required String userId});
  Future<void> deleteJournalEntry({required String journalId});
}

class JournalRemoteDataSourceImpl implements JournalRemoteDataSource {
  const JournalRemoteDataSourceImpl(
      {required FirebaseFirestore cloudStoreClient})
      : _cloudStoreClient = cloudStoreClient;

  final FirebaseFirestore _cloudStoreClient;

  @override
  Future<void> addJournalEntry(
      {required EntryModel entryModel, required String userId}) {
    // TODO: implement addJournalEntry
    // what do i need
    throw UnimplementedError();
  }

  @override
  Future<void> deleteJournalEntry({required String journalId}) {
    // TODO: implement deleteJournalEntry
    throw UnimplementedError();
  }

  @override
  Future<List<EntryModel>> getAllJournals({required String userId}) {
    // TODO: implement getAllJournals
    throw UnimplementedError();
  }
}
