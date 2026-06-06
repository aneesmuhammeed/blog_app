import 'package:fpdart/fpdart.dart';
import 'package:newflu/core/error/exceptions.dart';
import 'package:newflu/core/error/failures.dart';
import 'package:newflu/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:newflu/feature/auth/domain/entities/user.dart';
import 'package:newflu/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> loginInWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signUpWithEmailPassword(
        password: password,
        email: email,
        name: name,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
