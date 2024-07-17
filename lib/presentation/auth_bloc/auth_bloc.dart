import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:journal_cubit/domain/models/user.dart';
import 'package:journal_cubit/presentation/usecases/forgot_password.dart';
import 'package:journal_cubit/presentation/usecases/sign_in.dart';
import 'package:journal_cubit/presentation/usecases/sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

const storage = FlutterSecureStorage();
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignIn signIn,
    required SignUp signUp,
    required ForgotPassword forgotPassword,
  })  : _signIn = signIn,
        _signUp = signUp,
        _forgotPassword = forgotPassword,
        super(const AuthInitial(status: AuthenticationStatus.unauthenticated)) {
    on<AuthEvent>((event, emit) {
      emit( const AuthLoading(status: AuthenticationStatus.unknown));
    });
    on<SignInEvent>(_signInHandler);
    on<SignUpEvent>(_signUpHandler);
    on<ForgotPasswordEvent>(_forgotPasswordHandler);
  }

  final SignIn _signIn;
  final SignUp _signUp;
  final ForgotPassword _forgotPassword;

  Future<void> _signInHandler(
      SignInEvent event, Emitter<AuthState> emit) async {
    final result = await _signIn(
        SignInParams(email: event.email, password: event.password));

    result.fold((failure) => emit(AuthError(status: AuthenticationStatus.unauthenticated,message: failure.message)), (user) {
      print('logging user');
      print(user);
      emit(
        SignedIn(status: AuthenticationStatus.authenticated, user: user),
      );
    });
  }

  Future<void> _signUpHandler(
      SignUpEvent event, Emitter<AuthState> emit) async {
    final result = await _signUp(SignUpParams(
        email: event.email, name: event.name, password: event.password));

    result.fold((failure) => emit(AuthError(message: failure.errorMessage, 
    status: AuthenticationStatus.unauthenticated)),
        (_) => (const SignedUp(status: AuthenticationStatus.unauthenticated)));
  }

  Future<void> _forgotPasswordHandler(
      ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    final result = await _forgotPassword(event.email);

    result.fold((failure) => emit(AuthError(message: failure.errorMessage,
    status: AuthenticationStatus.unauthenticated)),
        (_) => emit(const ForgotPasswordSent(status: AuthenticationStatus.unauthenticated)));
  }
  void onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final token = await storage.read(key: 'auth_token');
    if(token != null ) {
      final user = await _getUserFromToken(token);
      emit(AuthState(status: AuthenticationStatus.authenticated, user: user));
    }
  }

  void onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    await storage.write(key: 'auth_token', value: event.token);
    final user = await _getUserFromToken(event.token);
    emit(AuthState(status: AuthenticationStatus.authenticated, user: user));
  }

  void onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async{
    await storage.delete(key: 'auth_token');
    emit(const AuthState(status: AuthenticationStatus.unauthenticated));
  }

  Future<UserModel?> _getUserFromToken(String token) async {
    try{
      final FirebaseAuth auth = FirebaseAuth.instance;

      UserCredential userCredential = await auth.signInWithCustomToken(token);
      print(userCredential.user);
      UserModel user = UserModel(email: userCredential.user!.email!, 
      name: userCredential.user!.displayName!, uid: userCredential.user!.uid);

      return user; 
    } catch(e){
      print('Error getting user from Firebase token: $e');
      return null;
    }
  }
}
