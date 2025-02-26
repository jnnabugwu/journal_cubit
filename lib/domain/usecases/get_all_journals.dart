import 'package:journal_cubit/core/usecases/usecases.dart';
import 'package:journal_cubit/core/utils/typedef.dart';
import 'package:journal_cubit/domain/models/entry.dart';
import 'package:journal_cubit/domain/repo/journal_repository.dart';

class GetAllJournalsParams {
  final String userId;

  const GetAllJournalsParams({required this.userId});
}

class GetAllJournalsUseCase extends UsecaseWithParams<List<EntryModel>, GetAllJournalsParams> {
  final JournalRepository _repository;

  const GetAllJournalsUseCase(this._repository);

  @override
  ResultFuture<List<EntryModel>> call(GetAllJournalsParams params) {
    return _repository.getAllJournals(userId: params.userId);
  }
}