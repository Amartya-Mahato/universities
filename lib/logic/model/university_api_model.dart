import 'dart:convert';

import 'package:flutter/foundation.dart';

class UniversityApiModel {
  final String alpha_two_code;
  final String name;
  final String country;
  final List<String> web_pages;
  final String state_province;
  final List<String> domains;
  UniversityApiModel({
    required this.alpha_two_code,
    required this.name,
    required this.country,
    required this.web_pages,
    required this.state_province,
    required this.domains,
  });

  UniversityApiModel copyWith({
    String? alpha_two_code,
    String? name,
    String? country,
    List<String>? web_pages,
    String? state_province,
    List<String>? domains,
  }) {
    return UniversityApiModel(
      alpha_two_code: alpha_two_code ?? this.alpha_two_code,
      name: name ?? this.name,
      country: country ?? this.country,
      web_pages: web_pages ?? this.web_pages,
      state_province: state_province ?? this.state_province,
      domains: domains ?? this.domains,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'alpha_two_code': alpha_two_code,
      'name': name,
      'country': country,
      'web_pages': web_pages,
      'state-province': state_province,
      'domains': domains,
    };
  }

  factory UniversityApiModel.fromMap(Map<String, dynamic> map) {
    return UniversityApiModel(
      alpha_two_code: map['alpha_two_code'] ?? '',
      name: map['name'] ?? '',
      country: map['country'] ?? '',
      web_pages: List<String>.from(map['web_pages']),
      state_province: map['state-province'] ?? 'Unknown',
      domains: List<String>.from(map['domains']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UniversityApiModel.fromJson(Map<String, dynamic> source) =>
      UniversityApiModel.fromMap(source);

  @override
  String toString() {
    return 'UniversityApiModel(alpha_tow_code: $alpha_two_code, name: $name, country: $country, web_pages: $web_pages, state_province: $state_province, domains: $domains)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UniversityApiModel &&
        other.alpha_two_code == alpha_two_code &&
        other.alpha_two_code == name &&
        other.country == country &&
        listEquals(other.web_pages, web_pages) &&
        other.state_province == state_province &&
        listEquals(other.domains, domains);
  }

  @override
  int get hashCode {
    return alpha_two_code.hashCode ^
        name.hashCode ^
        country.hashCode ^
        web_pages.hashCode ^
        state_province.hashCode ^
        domains.hashCode;
  }
}
