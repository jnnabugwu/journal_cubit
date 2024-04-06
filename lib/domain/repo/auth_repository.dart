import 'package:journal_cubit/domain/models/user.dart';

///As a repo i want to:
///Sign people up
///Sign users in
///help if users forget their password
///

abstract class AuthRepository {
  const AuthRepository();
  Future<UserModel> signIn(String email, String password);
  Future<void> signUp(String name, String email, String password);
  Future<void> forgetPassword(String email);
}
