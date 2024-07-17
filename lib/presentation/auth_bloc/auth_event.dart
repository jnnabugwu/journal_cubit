part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignInEvent extends AuthEvent {
  //does signing in give me a token 
  const SignInEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<String> get props => [email, password];
}

class ForgotPasswordEvent extends AuthEvent {
  const ForgotPasswordEvent({required this.email});

  final String email;

  @override
  List<String> get props => [email];
}

class SignUpEvent extends AuthEvent {
  const SignUpEvent(
      {required this.email, required this.password, required this.name});

  final String email;
  final String password;
  final String name;

  @override
  List<String> get props => [email, password, name];
}

class LoggedIn extends AuthEvent{
final String token;

const LoggedIn({required this.token});

  @override
  List<Object> get props => [token];
}

class LoggedOut extends AuthEvent{
  @override
  List<Object> get props => [];
  
}

class AppStarted extends AuthEvent{
  @override
  List<Object> get props => [];

}