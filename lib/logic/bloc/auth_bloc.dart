import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universities/logic/event/auth_event.dart';
import 'package:universities/logic/repository/auth/auth.dart';
import 'package:universities/logic/state/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthStateLogedOut(email: null)) {
    on<AuthEventLogIn>((event, emit) => _onLogInEvent(event, emit));
    on<AuthEventLogOut>((event, emit) => _onLogOutEvent(event, emit));
    on<AuthEventRegister>((event, emit) => _onRegisterEvent(event, emit));
    on<AuthEventRestPassword>(
        (event, emit) => _onLogResetPasswordEvent(event, emit));
  }

  void _onLogInEvent(AuthEventLogIn event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading(email: null));
    try {
      await Auth.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(AuthStateLogedIn(email: event.email));
    } catch (e) {
      emit(const AuthStateLogInFailed(email: null));
    }
  }

  void _onLogOutEvent(AuthEventLogOut evvent, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading(email: null));
    try {
      await Auth.signOut();
      emit(const AuthStateLogedOut(email: null));
    } catch (e) {
      throw Exception(e);
    }
  }

  void _onRegisterEvent(
      AuthEventRegister event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading(email: null));
    try {
      await Auth.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(AuthStateRegisterd(email: event.email));
    } catch (e) {
      emit(const AuthStateRegisterFailed(email: null));
    }
  }

  void _onLogResetPasswordEvent(
      AuthEventRestPassword event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading(email: null));
    try {
      await Auth.sendPasswordResetEmail(email: event.email);
      emit(AuthStateLogedIn(email: event.email));
    } catch (e) {
      emit(const AuthStateLogedOut(email: null));
    }
  }
}
