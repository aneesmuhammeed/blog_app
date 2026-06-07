part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String password;
  final String name;
  final String email;

  AuthSignUp({required this.password, required this.name, required this.email});
}

final class AuthLogIn extends AuthEvent {
  final String password;
  final String email;

  AuthLogIn({required this.password, required this.email});
}

final class AuthIsUserLoggedIn extends AuthEvent{}