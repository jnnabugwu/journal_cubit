import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:journal_cubit/domain/models/entry.dart';

abstract class JournalRemoteDataSource {
  Future<void> addJournalEntry({required EntryModel entryModel, required String userId});
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllJournals({required String userId});
  Future<void> deleteJournalEntry({required String journalId, required String uid});
  Future<void> updateJournalEntry({
    required String journalId,
    required String title,
    required String content,
    required String uid
  });
  Future<void> deleteAllJournalEntires({required String uid});
}

class JournalRemoteDataSourceImpl implements JournalRemoteDataSource {
  final FirebaseFirestore _cloudStoreClient;

  const JournalRemoteDataSourceImpl({required FirebaseFirestore cloudStoreClient})
      : _cloudStoreClient = cloudStoreClient;

  @override
  Future<void> addJournalEntry({
    required EntryModel entryModel,
    required String userId
  }) async {
    await Future.wait([
      _cloudStoreClient.collection('journal_entries').add(entryModel.toJson()),
      _cloudStoreClient.collection('users').doc(userId).update({
        'journalEntriesIds': FieldValue.arrayUnion([entryModel.journalId])
      }),
    ]);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllJournals({
    required String userId
  }) {
    return _cloudStoreClient
        .collection('journal_entries')
        .where('userId', isEqualTo: userId)
        .snapshots();
  }

  @override
  Future<void> deleteJournalEntry({
    required String journalId,
    required String uid
  }) async {
    var doc = await _cloudStoreClient.collection('journal_entries')
        .where('journalId', isEqualTo: journalId)
        .get();
    
    if (doc.docs.isEmpty) {
      throw Exception('Journal entry not found');
    }

    var docId = doc.docs.first.id;
    await Future.wait([
      _cloudStoreClient.collection('journal_entries').doc(docId).delete(),
      _cloudStoreClient.collection('users').doc(uid).update({
        'journalEntriesIds': FieldValue.arrayRemove([journalId]),
      })
    ]);
  }

  @override
  Future<void> updateJournalEntry({
    required String journalId,
    required String title,
    required String content,
    required String uid
  }) async {
    var doc = await _cloudStoreClient.collection('journal_entries')
        .where('journalId', isEqualTo: journalId)
        .get();
    
    if (doc.docs.isEmpty) {
      throw Exception('Journal entry not found');
    }

    var docId = doc.docs.first.id;
    await _cloudStoreClient.collection('journal_entries').doc(docId).update({
      'title': title,
      'content': content,
      'lastUpdated': DateTime.now()
    });
  }

  @override
  Future<void> deleteAllJournalEntires({required String uid}) async {
    const int batchSize = 500;
    CollectionReference journalsRef = _cloudStoreClient.collection('journal_entries');
    bool hasMoreEntries = true;

    while (hasMoreEntries) {
      final QuerySnapshot snapshot = await journalsRef
          .where('userId', isEqualTo: uid)
          .limit(batchSize)
          .get();

      if (snapshot.docs.isEmpty) {
        hasMoreEntries = false;
        continue;
      }

      WriteBatch batch = _cloudStoreClient.batch();
      for (DocumentSnapshot doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
      hasMoreEntries = snapshot.docs.length >= batchSize;
    }
  }
}