part of 'auth_bloc.dart';

@immutable
class AuthState {
  AuthState({
    required this.isLogin,
  });
  bool isLogin;
}

class AuthInitial extends AuthState {
  AuthInitial() : super(isLogin: true);
}
