//I want to add journal, get journals, delete, journals
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:journal_cubit/core/errors/failures.dart';
import 'package:journal_cubit/domain/models/entry.dart';

abstract class JournalRepository {
  const JournalRepository();
  Future<void> addJournal({required EntryModel entryModel, required String userId});
  Future<void> delete({required int journalId});
  Future<List<EntryModel>> getAllJournals({required String userId});
}

class JournalRemoteDataSourceImpl implements JournalRepository{
  const JournalRemoteDataSourceImpl(
    {required FirebaseFirestore cloudStoreClient}
  ) : _cloudStoreClient = cloudStoreClient;

  final FirebaseFirestore _cloudStoreClient;

  @override
  Future<void> addJournal(
    {required EntryModel entryModel, required String userId}
  ) async {
    try {
    await _cloudStoreClient.collection('users').doc(userId)
    .collection('journal_entries').add(entryModel.toJson());
  }catch(e){
    ServerFailure(message: e.toString(),statusCode: 500);
  }
  }
  
  @override
  Future<void> delete({required int journalId}) {
    // TODO: implement delete
    throw UnimplementedError();
  }
  
  @override
  Future<List<EntryModel>> getAllJournals({required String userId}) {
    // TODO: implement getAllJournals
    throw UnimplementedError();
  }
  
}