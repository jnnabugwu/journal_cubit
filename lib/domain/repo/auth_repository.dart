import 'package:journal_cubit/core/utils/typedef.dart';
import 'package:journal_cubit/domain/models/user.dart';

///As a repo i want to:
///Sign people up
///Sign users in
///help if users forget their password
///

abstract class AuthRepository {
  const AuthRepository();
  ResultFuture<UserModel> signIn(
      {required String email, required String password});
  ResultFuture<void> signUp(
      {required String name, required String email, required String password});
  ResultFuture<void> forgotPassword(String email);
  Future<String> getCurrentUserId();
}
