import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/src/either.dart';
import 'package:newflu/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:newflu/core/error/failures.dart';
import 'package:newflu/core/usecase/usecase.dart';
import 'package:newflu/core/common/entities/user.dart';
import 'package:newflu/feature/auth/domain/usecases/current_user.dart';
import 'package:newflu/feature/auth/domain/usecases/user_log_in.dart';
import 'package:newflu/feature/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogIn _userLogIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required this._userSignUp,
    required this._userLogIn,
    required this._currentUser,
    required this._appUserCubit,
  }) : super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogIn>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(
      UserSignUpParams(
        password: event.password,
        email: event.email,
        name: event.name,
      ),
    );
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (user) => _emitAuthSucess(user, emit),
    );
  }

  void _onAuthLogin(AuthLogIn event, Emitter<AuthState> emit) async {
    final res = await _userLogIn(
      UserLoginParams(password: event.password, email: event.email),
    );
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (user) => _emitAuthSucess(user, emit),
    );
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());
    res.fold((l) => emit(AuthFailure(l.message)), (r) {
      _emitAuthSucess(r, emit);
    });
  }

  void _emitAuthSucess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSucess(user));
  }
}
