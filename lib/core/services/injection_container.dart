import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:journal_cubit/data/datasources/auth_remote_data_source.dart';
import 'package:journal_cubit/data/datasources/journal_remote_datasource.dart';
import 'package:journal_cubit/data/repo/auth_repo_impl.dart';
import 'package:journal_cubit/data/repo/journal_repository.dart';
import 'package:journal_cubit/domain/repo/auth_repository.dart';
import 'package:journal_cubit/domain/repo/journal_repository.dart';
import 'package:journal_cubit/domain/usecases/journal_usecases.dart';
import 'package:journal_cubit/presentation/auth_bloc/auth_bloc.dart';
import 'package:journal_cubit/presentation/entrylist_bloc/entrylist_bloc.dart';
import 'package:journal_cubit/domain/usecases/auth_usecases.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core & External
  await _initExternal();
  
  // Features
  await _initAuth();
  await _initJournal();
}

Future<void> _initExternal() async {
  // Firebase
  sl
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => const FlutterSecureStorage());
}

Future<void> _initAuth() async {
  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      authClient: sl(),
      cloudStoreClient: sl(),
    ),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepoImpl(sl()),
  );

  // Use Cases
  sl
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignUp(sl()))
    ..registerLazySingleton(() => ForgotPassword(sl()));

  // Blocs
  sl.registerFactory(
    () => AuthBloc(
      signIn: sl(),
      signUp: sl(),
      forgotPassword: sl(),
      storage: sl(),
    ),
  );
}

Future<void> _initJournal() async {
  // Data Sources
  sl.registerLazySingleton<JournalRemoteDataSource>(
    () => JournalRemoteDataSourceImpl(cloudStoreClient: sl()),
  );

  // Repositories
  sl.registerLazySingleton<JournalRepository>(
    () => JournalRepositoryImpl(sl()),
  );

  // Use Cases
  sl
    ..registerLazySingleton(() => AddJournalUseCase(sl()))
    ..registerLazySingleton(() => GetAllJournalsUseCase(sl()))
    ..registerLazySingleton(() => DeleteJournalUseCase(sl()))
    ..registerLazySingleton(() => UpdateJournalUseCase(sl()))
    ..registerLazySingleton(() => DeleteAllJournalsUseCase(sl()));

  // Blocs
  sl.registerFactoryParam<EntryListBloc, AuthBloc, void>(
    (authBloc, _) => EntryListBloc(
      addJournalUseCase: sl(),
      getAllJournalsUseCase: sl(),
      deleteJournalUseCase: sl(),
      updateJournalUseCase: sl(),
      deleteAllJournalsUseCase: sl(),
      authBloc: authBloc,
    ),
  );
}