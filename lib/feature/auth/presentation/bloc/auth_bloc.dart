import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflu/feature/auth/domain/entities/user.dart';
import 'package:newflu/feature/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({required UserSignUp userSignUp})
    : _userSignUp = userSignUp,
      super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final res = await _userSignUp(
        UserSignUpParams(
          password: event.password,
          email: event.email,
          name: event.name,
        ),
      );
      res.fold(
        (l) => emit(AuthFailure(l.message)),
        (user) => emit(AuthSucess(user)),
      );
    });
  }
}
