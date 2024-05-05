import 'package:dartz/dartz.dart';
import 'package:journal_cubit/core/errors/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
