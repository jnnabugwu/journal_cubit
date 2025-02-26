import 'package:equatable/equatable.dart';
import 'package:journal_cubit/core/usecases/usecases.dart';
import 'package:journal_cubit/core/utils/typedef.dart';
import 'package:journal_cubit/domain/repo/auth_repository.dart';

class SignUp extends UsecaseWithParams<void, SignUpParams> {
  final AuthRepository _repo;
  SignUp(this._repo);

  @override
  ResultFuture<void> call(SignUpParams params) => _repo.signUp(
      email: params.email, name: params.name, password: params.password);
}

class SignUpParams extends Equatable {
  final String email;
  final String password;
  final String name;

  const SignUpParams(
      {required this.email, required this.name, required this.password});

  @override
  List<Object?> get props => [email, password, name];
}
