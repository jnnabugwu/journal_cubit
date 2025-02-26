import 'package:journal_cubit/core/usecases/usecases.dart';
import 'package:journal_cubit/core/utils/typedef.dart';
import 'package:journal_cubit/domain/repo/journal_repository.dart';

class UpdateJournalParams {
  final String journalId;
  final String title;
  final String content;
  final String userId;

  const UpdateJournalParams({
    required this.journalId,
    required this.title,
    required this.content,
    required this.userId,
  });
}

class UpdateJournalUseCase extends UsecaseWithParams<void, UpdateJournalParams> {
  final JournalRepository _repository;

  const UpdateJournalUseCase(this._repository);

  @override
  ResultFuture<void> call(UpdateJournalParams params) async {
    return await _repository.updateJournal(
      journalId: params.journalId,
      title: params.title,
      content: params.content,
      userId: params.userId,
    );
  }
}