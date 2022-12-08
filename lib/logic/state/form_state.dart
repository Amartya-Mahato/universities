import 'package:equatable/equatable.dart';

abstract class FormsState extends Equatable {
  final String? message;
  const FormsState({required this.message});

  @override
  List<Object?> get props => [message];
}

class FormSubmittingState extends FormsState {
  const FormSubmittingState() : super(message: null);

  @override
  List<Object?> get props => [message];
}

class FormSubmittedState extends FormsState {
  const FormSubmittedState() : super(message: null);

  @override
  List<Object?> get props => [message];
}

class FormSubmitError extends FormsState {
  const FormSubmitError({required String? message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}
