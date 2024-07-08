import 'package:dartz/dartz.dart';
import 'package:journal_cubit/core/errors/exception.dart';
import 'package:journal_cubit/core/errors/failures.dart';
import 'package:journal_cubit/core/utils/typedef.dart';
import 'package:journal_cubit/data/datasources/auth_remote_data_source.dart';
import 'package:journal_cubit/domain/models/user.dart';
import 'package:journal_cubit/domain/repo/auth_repository.dart';

class AuthRepoImpl implements AuthRepository {
  const AuthRepoImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<void> forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<UserModel> signIn(
      {required String email, required String password}) async {
    try {
      final result =
          await _remoteDataSource.signIn(email: email, password: password);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      await _remoteDataSource.signUp(
          email: email, name: name, password: password);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
  @override
  Future<String> getCurrentUserId()async{
    
    String uid = await _remoteDataSource.getCurrentUserId();
    return uid;
  }
}
