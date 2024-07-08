import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journal_cubit/domain/models/user.dart';
import 'package:journal_cubit/presentation/usecases/forgot_password.dart';
import 'package:journal_cubit/presentation/usecases/sign_in.dart';
import 'package:journal_cubit/presentation/usecases/sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignIn signIn,
    required SignUp signUp,
    required ForgotPassword forgotPassword,
  })  : _signIn = signIn,
        _signUp = signUp,
        _forgotPassword = forgotPassword,
        super(const AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(const AuthLoading());
    });
    on<SignInEvent>(_signInHandler);
    on<SignUpEvent>(_signUpHandler);
    on<ForgotPasswordEvent>(_forgotPasswordHandler);
  }

  final SignIn _signIn;
  final SignUp _signUp;
  final ForgotPassword _forgotPassword;

  Future<UserModel?> _signInHandler(
      SignInEvent event, Emitter<AuthState> emit) async {
    final result = await _signIn(
        SignInParams(email: event.email, password: event.password));

    result.fold((failure) => emit(AuthError(failure.errorMessage)), (user) {
      print('logging user');
      print(user);
      emit(SignedIn(user));
    });
  }

  Future<void> _signUpHandler(
      SignUpEvent event, Emitter<AuthState> emit) async {
    final result = await _signUp(SignUpParams(
        email: event.email, name: event.name, password: event.password));

    result.fold((failure) => emit(AuthError(failure.errorMessage)),
        (_) => (const SignedUp()));
  }

  Future<void> _forgotPasswordHandler(
      ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    final result = await _forgotPassword(event.email);

    result.fold((failure) => emit(AuthError(failure.errorMessage)),
        (_) => emit(const ForgotPasswordSent()));
  }
}
