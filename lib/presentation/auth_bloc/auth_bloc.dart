import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:journal_cubit/core/services/user_cache.dart';
import 'package:journal_cubit/domain/models/user.dart';
import 'package:journal_cubit/presentation/usecases/forgot_password.dart';
import 'package:journal_cubit/presentation/usecases/sign_in.dart';
import 'package:journal_cubit/presentation/usecases/sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

const storage = FlutterSecureStorage();
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserCache _userCache;

  AuthBloc({
    required SignIn signIn,
    required SignUp signUp,
    required ForgotPassword forgotPassword,
    required FlutterSecureStorage storage,
  })  : _signIn = signIn,
        _signUp = signUp,
        _forgotPassword = forgotPassword,
        _userCache = UserCache(storage),
        super(const AuthInitial(status: AuthenticationStatus.unknown)) {
    on<AuthEvent>((event, emit) {
      // emit(AuthState(status: AuthenticationStatus.authenticated,user: user));
    });
    on<SignInEvent>(_signInHandler);
    on<SignUpEvent>(_signUpHandler);
    on<ForgotPasswordEvent>(_forgotPasswordHandler);
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
    on<CheckCachedUser>(_onCheckCachedUser);
  }

  final SignIn _signIn;
  final SignUp _signUp;
  final ForgotPassword _forgotPassword;

  Future<AuthState> _checkForCachedUsers() async {
    try {
      final user = await _userCache.getUser();
      if (user != null) {
        return AuthState(status: AuthenticationStatus.authenticated, user: user);
      } else {
       return const AuthState(status: AuthenticationStatus.unauthenticated);
      }
    } catch (e) {
     return const AuthState(status: AuthenticationStatus.unauthenticated);
    }
  }

  Future<void> _onCheckCachedUser(CheckCachedUser event, Emitter<AuthState> emit) async {
    if (state.status == AuthenticationStatus.unknown) {
      final newState = await _checkForCachedUsers();
      emit(newState);
    }
  }

  Future<void> _signInHandler(
      SignInEvent event, Emitter<AuthState> emit) async {
    final result = await _signIn(
        SignInParams(email: event.email, password: event.password));

    result.fold((failure) => emit(AuthError(status:
    AuthenticationStatus.unauthenticated,message: failure.message)),
            (user) {
      _userCache.saveUser(user);
      emit(
        SignedIn(status: AuthenticationStatus.authenticated, user: user),
      );
    });
  }

  Future<void> _signUpHandler(
      SignUpEvent event, Emitter<AuthState> emit) async {
    final result = await _signUp(SignUpParams(
        email: event.email, name: event.name, password: event.password));

    result.fold((failure) {
      emit(AuthError(message: failure.errorMessage,
    status: AuthenticationStatus.unauthenticated));
    },
        (_) {
           emit(
               const SignedUp(status: AuthenticationStatus.unauthenticated)
           );
        },
    );

  }

  Future<void> _forgotPasswordHandler(
      ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    final result = await _forgotPassword(event.email);

    result.fold((failure) => emit(AuthError(message: failure.errorMessage,
    status: AuthenticationStatus.unauthenticated)),
        (_) => emit(const ForgotPasswordSent(status: AuthenticationStatus.unauthenticated)));
  }
  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final token = await storage.read(key: 'auth_token');
    if(token != null ) {
      final cachedUser = await _userCache.getUser();
      if (cachedUser != null){
      emit(AuthState(status: AuthenticationStatus.authenticated, user: cachedUser)
      );
      emit(SignedIn(status: AuthenticationStatus.authenticated, user: cachedUser));

      } else {
        final user = await _getUserFromToken(token);
        if(user!=null) {
          await _userCache.saveUser(user);
          emit(AuthState(status: AuthenticationStatus.authenticated,user: user));
        }else{
          emit(const AuthState(status: AuthenticationStatus.unauthenticated));
        }
      }
    }
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    await storage.write(key: 'auth_token', value: event.token);
    final user = await _getUserFromToken(event.token);
    if (user != null){
      await _userCache.saveUser(user);
      emit(AuthState(status: AuthenticationStatus.authenticated, user: user));
    }
  }


  void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async{
    await storage.delete(key: 'auth_token');
    await _userCache.clearUser();
    emit(const AuthState(status: AuthenticationStatus.unauthenticated));
  }

  Future<UserModel?> _getUserFromToken(String token) async {
    try{
      final FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.signInWithCustomToken(token);
      if(userCredential.user != null){

      UserModel user = UserModel(email: userCredential.user!.email!, 
      name: userCredential.user!.displayName ?? 'User', uid: userCredential.user!.uid);
        
      return user; 
      }
    } catch(e){
      print('Error getting user from Firebase token: $e');
      return null;
    }
    return null;
  }


}
