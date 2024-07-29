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
  Stream<QuerySnapshot<EntryModel>> getAllJournals({required String userId});
  Future<void> deleteJournalEntry({required String journalId, required String uid});
}

class JournalRemoteDataSourceImpl implements JournalRemoteDataSource {
  const JournalRemoteDataSourceImpl(
      {required FirebaseFirestore cloudStoreClient})
      : _cloudStoreClient = cloudStoreClient;

  final FirebaseFirestore _cloudStoreClient;

  @override
  Future<void> addJournalEntry(
      {required EntryModel entryModel, required String userId}) async {
    try {
    
     await Future.wait([
        _cloudStoreClient.collection('journal_entries').add(entryModel.toJson()),
        _cloudStoreClient.collection('users').doc(userId).update({
          'journalEntriesIds' : FieldValue.arrayUnion([entryModel.journalId])
        })
     ]);

    } catch (e) {
      print('Something went wrong: ${e.toString()}');
      ServerFailure(message: e.toString(), statusCode: 500);
    }
    //am i adding a user everytime 
  }

  @override
  Future<void> deleteJournalEntry({required String journalId,required String uid}) {
    throw UnimplementedError();
  }

  @override
  Stream<QuerySnapshot<EntryModel>> getAllJournals({required String userId}) {
    // TODO: implement getAllJournals
    final collection = FirebaseFirestore.instance.collection('journal_entries').where('userId', isEqualTo: userId)
    .withConverter(fromFirestore: (snapshot,_) => EntryModel.fromFirestore(snapshot,_), toFirestore: (entryModel, _) => entryModel.toFirestore());
    try{
      return collection.snapshots();
    } catch (e) {
      ServerFailure(message: e.toString(), statusCode: 500);
    }
    throw ServerFailure(message: 'Something went wrong in getting all the journals', statusCode: 500);
  } 
}
 