import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:journal_cubit/data/datasources/auth_remote_data_source.dart';
import 'package:journal_cubit/data/datasources/journal_remote_datasource.dart';
import 'package:journal_cubit/data/repo/auth_repo_impl.dart';
import 'package:journal_cubit/domain/repo/auth_repository.dart';
import 'package:journal_cubit/presentation/auth_bloc/auth_bloc.dart';
import 'package:journal_cubit/presentation/entrylist_bloc/entrylist_bloc.dart';
import 'package:journal_cubit/presentation/usecases/forgot_password.dart';
import 'package:journal_cubit/presentation/usecases/sign_in.dart';
import 'package:journal_cubit/presentation/usecases/sign_up.dart';

final sl = GetIt.instance;

Future<void> init() async {
  
  // Then initialize other dependencies
  await _initAuth();
  await _initJournal();
}

Future<void> _initAuth() async {
  // Firebase instances
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepoImpl(sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      authClient: sl(),
      cloudStoreClient: sl(),
    ),
  );

  // Use cases
  sl
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignUp(sl()))
    ..registerLazySingleton(() => ForgotPassword(sl()));

  // Storage
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  // Blocs
  sl
    .registerFactory(
      () => AuthBloc(
        signIn: sl(),
        signUp: sl(),
        forgotPassword: sl(),
        storage: sl(),
      ),
    );
    
}

Future<void> _initJournal() async {

  //Journal Remote DataSource
  sl.registerLazySingleton<JournalRemoteDataSource>(
    () => JournalRemoteDataSourceImpl(cloudStoreClient: sl())
  );

  sl.registerFactoryParam<EntryListBloc, AuthBloc, void>(
    (authBloc, _) => EntryListBloc(
      dataSource: sl(),
      authBloc: authBloc,
    ),
  );
}