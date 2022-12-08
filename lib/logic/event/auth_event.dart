import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

@immutable
class AuthEventLogIn extends AuthEvent {
  final String email;
  final String password;
  const AuthEventLogIn({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

@immutable
class AuthEventLogOut extends AuthEvent {
  final String email;
  final String password;
  const AuthEventLogOut({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

@immutable
class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;
  const AuthEventRegister({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

@immutable
class AuthEventRestPassword extends AuthEvent {
  final String email;
  const AuthEventRestPassword({required this.email});
  @override
  List<Object?> get props => [email];
}
