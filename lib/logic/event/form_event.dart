import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class FormEvent extends Equatable {
  const FormEvent();
}

class FormSubmissionEvent extends FormEvent {
  final String name;
  final String email;
  final int age;
  final Uint8List image;
  const FormSubmissionEvent(
      {required this.name, required this.age, required this.image, required this.email});
  @override
  List<Object?> get props => [name, age, image];
}
