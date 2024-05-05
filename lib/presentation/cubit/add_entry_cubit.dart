import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_entry_state.dart';

class AddEntryCubit extends Cubit<AddEntryState> {
  AddEntryCubit() : super(AddEntryInitial());
}
