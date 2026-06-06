import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflu/feature/auth/domain/entities/user.dart';
import 'package:newflu/feature/auth/domain/usecases/user_log_in.dart';
import 'package:newflu/feature/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogIn _userLogIn;
  AuthBloc({required this._userSignUp, required this._userLogIn})
    : super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogIn>(_onAuthLogin);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
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
  }

  
  void _onAuthLogin(AuthLogIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLogIn(
      UserLoginParams(
        password: event.password,
        email: event.email,
      ),
    );
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (user) => emit(AuthSucess(user)),
    );
  }
}
