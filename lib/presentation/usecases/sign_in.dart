import 'package:equatable/equatable.dart';
import 'package:journal_cubit/core/usecases/usecases.dart';
import 'package:journal_cubit/core/utils/typedef.dart';
import 'package:journal_cubit/domain/models/user.dart';
import 'package:journal_cubit/domain/repo/auth_repository.dart';

class SignIn extends UsecaseWithParams<UserModel, SignInParams> {
  SignIn(this._repo);

  final AuthRepository _repo;
  @override
  ResultFuture<UserModel> call(SignInParams params) =>
      _repo.signIn(email: params.email, password: params.password);
}

class SignInParams extends Equatable {
  final String email;
  final String password;

  const SignInParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
