import 'package:fpdart/fpdart.dart';
import 'package:newflu/core/error/failures.dart';
import 'package:newflu/core/usecase/usecase.dart';
import 'package:newflu/core/common/entities/user.dart';
import 'package:newflu/feature/auth/domain/repository/auth_repository.dart';

class UserLogIn implements UseCase<User, UserLoginParams> {
  final AuthRepository authrepository;

  UserLogIn(this.authrepository);
  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authrepository.loginInWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
