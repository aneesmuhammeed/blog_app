import 'package:fpdart/fpdart.dart';
import 'package:newflu/core/error/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, String>> loginInWithEmailPassword({
    required String email,
    required String password,
  });
}
