import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  final String? email;
  const AuthState({required this.email});
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading({required String? email})
      : super(email: email);

  @override
  List<Object?> get props => [email];
}

class AuthStateLogedIn extends AuthState {
  const AuthStateLogedIn({required String? email})
      : super(email: email);

  @override
  List<Object?> get props => [email];
}

class AuthStateLogedOut extends AuthState {
  const AuthStateLogedOut({required String? email})
      : super(email: email);

  @override
  List<Object?> get props => [email];
}

class AuthStateLogInFailed extends AuthState {
  const AuthStateLogInFailed({required String? email})
      : super(email: email);

  @override
  List<Object?> get props => [email];
}


class AuthStateRegisterFailed extends AuthState {
  const AuthStateRegisterFailed({required String? email})
      : super(email: email);

  @override
  List<Object?> get props => [email];
}

class AuthStateRegisterd extends AuthState {
  const AuthStateRegisterd({required String? email})
      : super(email: email);

  @override
  List<Object?> get props => [email];
}
