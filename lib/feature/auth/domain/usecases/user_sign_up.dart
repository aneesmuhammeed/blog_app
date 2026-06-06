// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:newflu/core/error/failures.dart';
import 'package:newflu/core/usecase/usecase.dart';
import 'package:newflu/feature/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<String, UserSignUpParams> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String password;
  final String email;
  final String name;
  UserSignUpParams({
    required this.password,
    required this.email,
    required this.name,
  });
}
