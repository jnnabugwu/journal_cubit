import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'entries_list_state.dart';

class EntriesListCubit extends Cubit<EntriesListState> {
  EntriesListCubit() : super(EntriesListInitial());
}
