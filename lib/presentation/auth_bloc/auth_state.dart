part of 'auth_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }
class AuthState extends Equatable {
  final AuthenticationStatus status;
  final UserModel? user;


  const AuthState({required this.status, this.user});
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial({required super.status});
}

class AuthLoading extends AuthState {
  const AuthLoading({required super.status});
}

class SignedIn extends AuthState {
  const SignedIn({required super.status, super.user});


}

class ForgotPasswordSent extends AuthState {
  const ForgotPasswordSent({required super.status});
}

class SignedUp extends AuthState {
  const SignedUp({required super.status, super.user});
}

class AuthError extends AuthState {
  const AuthError({required super.status, required this.message});

  final String message;

  @override
  List<String> get props => [message];
}
