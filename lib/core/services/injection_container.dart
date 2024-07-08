import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:journal_cubit/data/datasources/journal_remote_datasource.dart';
import 'package:journal_cubit/data/repo/auth_repo_impl.dart';
import 'package:journal_cubit/domain/repo/auth_repository.dart';
import 'package:journal_cubit/presentation/auth_bloc/auth_bloc.dart';
import 'package:journal_cubit/presentation/entrylist_bloc/entrylist_bloc.dart';
import 'package:journal_cubit/presentation/usecases/forgot_password.dart';
import 'package:journal_cubit/presentation/usecases/sign_in.dart';
import 'package:journal_cubit/presentation/usecases/sign_up.dart';
import 'package:journal_cubit/data/datasources/auth_remote_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initAuth();
}

Future<void> _initAuth() async {
  sl
    ..registerFactory(
      () => AuthBloc(
        signIn: sl(),
        signUp: sl(),
        forgotPassword: sl(),
      ),
    )
    
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(
      () => SignUp(sl()),
    )
    ..registerLazySingleton(() => ForgotPassword(sl()))
    ..registerLazySingleton<AuthRepository>(() => AuthRepoImpl(sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(() =>
        AuthRemoteDataSourceImpl(authClient: sl(), cloudStoreClient: sl()))
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerFactory(() => EntryListBloc(sl(), sl()))
    ..registerLazySingleton<JournalRemoteDataSource>(() => 
        JournalRemoteDataSourceImpl(cloudStoreClient: sl()));
}
