import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:universities/logic/model/university_api_model.dart';

class UniversityApiState extends Equatable {
  final List<UniversityApiModel>? universities;
  const UniversityApiState({
    required this.universities,
  });

  UniversityApiState copyWith({
    List<UniversityApiModel>? universities,
  }) {
    return UniversityApiState(
      universities: universities ?? this.universities,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'universities': universities?.map((x) => x.toMap()).toList(),
    };
  }

  factory UniversityApiState.fromMap(Map<String, dynamic> map) {
    return UniversityApiState(
      universities: map['universities'] != null
          ? List<UniversityApiModel>.from(
              map['universities']?.map((x) => UniversityApiModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UniversityApiState.fromJson(String source) =>
      UniversityApiState.fromMap(json.decode(source));

  @override
  String toString() => 'UniversityApiState(universities: $universities)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UniversityApiState &&
        listEquals(other.universities, universities);
  }

  @override
  int get hashCode => universities.hashCode;

  @override
  List<Object?> get props => [universities];
}

@immutable
class UniversityApiInitialState extends UniversityApiState {
  const UniversityApiInitialState() : super(universities: null);
  @override
  List<Object?> get props => [universities];
}

@immutable
class UniversityApiLoadedState extends UniversityApiState {
  const UniversityApiLoadedState(
      {required List<UniversityApiModel> universities})
      : super(universities: universities);
  @override
  List<Object?> get props => [universities];
}

@immutable
class UniversityApiErrorState extends UniversityApiState {
  UniversityApiErrorState()
      : super(universities: null);
  @override
  List<Object?> get props => [universities];
}
