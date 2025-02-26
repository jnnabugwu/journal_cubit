import 'package:journal_cubit/core/usecases/usecases.dart';
import 'package:journal_cubit/core/utils/typedef.dart';
import 'package:journal_cubit/domain/models/entry.dart';
import 'package:journal_cubit/domain/repo/journal_repository.dart';

class AddJournalParams {
  final EntryModel entryModel;
  final String userId;

  const AddJournalParams({
    required this.entryModel,
    required this.userId,
  });
}

class AddJournalUseCase extends UsecaseWithParams<void, AddJournalParams> {
  final JournalRepository _repository;

  const AddJournalUseCase(this._repository);

  @override
  ResultFuture<void> call(AddJournalParams params) async {
    return await _repository.addJournal(
      entryModel: params.entryModel,
      userId: params.userId,
    );
  }
}