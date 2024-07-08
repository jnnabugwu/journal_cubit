import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:journal_cubit/core/errors/failures.dart';
import 'package:journal_cubit/domain/models/entry.dart';

abstract class JournalRemoteDataSource {
  const JournalRemoteDataSource();

  ///Need to get journals
  ///add journals
  ///delete journals
  ///update journals

  Future<void> addJournalEntry(
      {required EntryModel entryModel, required String userId});
  Stream<List<EntryModel>> getAllJournals({required String userId});
  Future<void> deleteJournalEntry({required String journalId});
}

class JournalRemoteDataSourceImpl implements JournalRemoteDataSource {
  const JournalRemoteDataSourceImpl(
      {required FirebaseFirestore cloudStoreClient})
      : _cloudStoreClient = cloudStoreClient;

  final FirebaseFirestore _cloudStoreClient;

  @override
  Future<void> addJournalEntry(
      {required EntryModel entryModel, required String userId}) async {
    // TODO: implement addJournalEntry
    // what do i need to do 
    // connect to the cloud doc and use user id 
    try {
     await _cloudStoreClient.collection('users').doc(userId).collection('journal_entries').add(entryModel.toJson());
    } catch (e) {
      ServerFailure(message: e.toString(), statusCode: 500);
    }
    //am i adding a user everytime 
  }

  @override
  Future<void> deleteJournalEntry({required String journalId}) {
    // TODO: implement deleteJournalEntry
    throw UnimplementedError();
  }

  @override
 Stream<List<EntryModel>> getAllJournals({required String userId}) {
  final collection = FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('journal_entries')
      .withConverter(
        fromFirestore: (snapshot, _) => EntryModel.fromFirestore(snapshot, _),
        toFirestore: (entryModel, _) => entryModel.toFirestore(),
      );

  try {
    return collection.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  } catch (e) {
    // Handle the error by emitting an error event in the stream
    return Stream.error(ServerFailure(
      message: 'Error getting journals: ${e.toString()}',
      statusCode: 500,
    ));
  }
  }
  }