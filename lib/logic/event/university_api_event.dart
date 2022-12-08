import 'package:equatable/equatable.dart';

abstract class UniversityApiEvent extends Equatable {
  const UniversityApiEvent();
}

class UniversityApiInitializeEvent extends UniversityApiEvent {
  const UniversityApiInitializeEvent();
  @override
  List<Object?> get props => [];
}
