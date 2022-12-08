import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class DashBoardState extends Equatable {
  final String? imageURL;
  final String? name;
  final String? age;
  const DashBoardState({
    required this.imageURL,
    required this.name,
    required this.age,
  });

  DashBoardState copyWith({
    String? imageURL,
    String? name,
    String? age,
  }) {
    return DashBoardState(
      imageURL: imageURL ?? this.imageURL,
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageURL': imageURL,
      'name': name,
      'age': age,
    };
  }

  factory DashBoardState.fromMap(Map<String, dynamic> map) {
    return DashBoardState(
      imageURL: map['imageURL'],
      name: map['name'],
      age: map['age'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DashBoardState.fromJson(String source) =>
      DashBoardState.fromMap(json.decode(source));

  @override
  String toString() =>
      'DashBoardState(imageURL: $imageURL, name: $name, age: $age)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DashBoardState &&
        other.imageURL == imageURL &&
        other.name == name &&
        other.age == age;
  }

  @override
  int get hashCode => imageURL.hashCode ^ name.hashCode ^ age.hashCode;

  @override
  List<Object?> get props => [imageURL, name, age];
}

@immutable
class InitialDashBoard extends DashBoardState {
  const InitialDashBoard() : super(imageURL: null, name: null, age: null);
  @override
  List<Object?> get props => [imageURL, name, age];
}

@immutable
class DashBoardLoading extends DashBoardState {
  const DashBoardLoading() : super(imageURL: null, name: null, age: null);
  @override
  List<Object?> get props => [imageURL, name, age];
}

@immutable
class DashBoardLoaded extends DashBoardState {
  const DashBoardLoaded(String? imageURL, String? name, String? age)
      : super(imageURL: imageURL, name: name, age: age);
  @override
  List<Object?> get props => [imageURL, name, age];
}

@immutable
class DashBoardError extends DashBoardState {
  const DashBoardError()
      : super(imageURL: null, name: null, age: null);
  @override
  List<Object?> get props => [imageURL, name, age];
}
