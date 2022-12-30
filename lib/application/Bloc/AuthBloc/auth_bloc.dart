import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:lace_it/function/user_auth.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<Toggle>((event, emit) {
      emit(AuthState(isLogin: !state.isLogin));
    });

    on<AuthLogin>((event, emit) async {
      final user = await UserAuth.login(
          context: event.context, password: event.password, email: event.email);
    });

    on<AuthSignUp>((event, emit) async {
      await UserAuth.signUp(
        context: event.context,
        password: event.password,
        email: event.email,
      );
      log('Addedddd');
      await UserAuth.addUser(
        event.password,
      );
      emit(state);
    });
  }
}
