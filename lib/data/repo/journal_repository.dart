import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:journal_cubit/core/errors/failures.dart';
import 'package:journal_cubit/data/datasources/journal_remote_datasource.dart';
import 'package:journal_cubit/domain/models/entry.dart';
import 'package:dartz/dartz.dart';
import 'package:journal_cubit/domain/repo/journal_repository.dart';


class JournalRepositoryImpl implements JournalRepository {
  final JournalRemoteDataSource _remoteDataSource;

  JournalRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, void>> addJournal({
    required EntryModel entryModel,
    required String userId
  }) async {
    try {
      await _remoteDataSource.addJournalEntry(
        entryModel: entryModel,
        userId: userId
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(
        message: 'Failed to add journal entry',
        statusCode: 500
      ));
    }
  }

  @override
  Future<Either<Failure, void>> deleteJournal({
    required String journalId,
    required String userId
  }) async {
    try {
      await _remoteDataSource.deleteJournalEntry(
        journalId: journalId,
        uid: userId
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(
        message: 'Failed to delete journal entry',
        statusCode: 500
      ));
    }
  }

  @override
  Future<Either<Failure, List<EntryModel>>> getAllJournals({
    required String userId
  }) async {
    try {
      final journalStream = _remoteDataSource.getAllJournals(userId: userId);
      
      // Convert the stream to a Future<List<EntryModel>>
      final snapshot = await journalStream.first;
      final entries = snapshot.docs.map((doc) {
        return EntryModel.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>, null);
      }).toList();
      
      return Right(entries);
    } catch (e) {
      print(e.toString);
      return Left(ServerFailure(
        message: e.toString(),
        statusCode: 500
      ));
    }
  }

  @override
  Future<Either<Failure, void>> updateJournal({
    required String journalId,
    required String title,
    required String content,
    required String userId
  }) async {
    try {
      await _remoteDataSource.updateJournalEntry(
        journalId: journalId,
        title: title,
        content: content,
        uid: userId
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(
        message: 'Failed to update journal entry',
        statusCode: 500
      ));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAllJournals({
    required String userId
  }) async {
    try {
      await _remoteDataSource.deleteAllJournalEntires(uid: userId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(
        message: 'Failed to delete all journal entries',
        statusCode: 500
      ));
    }
  }
}