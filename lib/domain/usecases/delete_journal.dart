import 'package:journal_cubit/core/usecases/usecases.dart';
import 'package:journal_cubit/core/utils/typedef.dart';
import 'package:journal_cubit/domain/repo/journal_repository.dart';

class DeleteJournalParams {
  final String journalId;
  final String userId;

  const DeleteJournalParams({
    required this.journalId,
    required this.userId,
  });
}

class DeleteJournalUseCase extends UsecaseWithParams<void, DeleteJournalParams> {
  final JournalRepository _repository;

  const DeleteJournalUseCase(this._repository);

  @override
  ResultFuture<void> call(DeleteJournalParams params) {
    return _repository.deleteJournal(
      journalId: params.journalId,
      userId: params.userId,
    );
  }
}