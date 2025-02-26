import 'package:journal_cubit/core/usecases/usecases.dart';
import 'package:journal_cubit/core/utils/typedef.dart';
import 'package:journal_cubit/domain/repo/journal_repository.dart';

class DeleteAllJournalsParams {
  final String userId;

  const DeleteAllJournalsParams({required this.userId});
}

class DeleteAllJournalsUseCase extends UsecaseWithParams<void, DeleteAllJournalsParams> {
  final JournalRepository _repository;

  const DeleteAllJournalsUseCase(this._repository);

  @override
  ResultFuture<void> call(DeleteAllJournalsParams params) async {
    return await _repository.deleteAllJournals(userId: params.userId);
  }
}