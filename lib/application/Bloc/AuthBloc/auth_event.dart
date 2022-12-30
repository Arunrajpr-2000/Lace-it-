part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class Toggle extends AuthEvent {
  // Toggle({required this.context});
  // final context;
}

class AuthLogin extends AuthEvent {
  AuthLogin(
      {required this.email, required this.password, required this.context});
  String email;
  String password;
  final context;
}

class AuthSignUp extends AuthEvent {
  AuthSignUp({
    required this.email,
    required this.password,
    required this.context,
  });
  String email;
  String password;

  final context;
}
