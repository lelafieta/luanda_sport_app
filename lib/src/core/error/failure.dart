// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  final String? code;
  final String? detail;

  const Failure({
    required this.message,
    this.code,
    this.detail,
  });

  @override
  List<Object> get props => [message, code!, detail!];

  Failure copyWith({
    String? message,
    String? code,
    String? detail,
  }) {
    return Failure(
      message: message ?? this.message,
      code: code ?? this.code,
      detail: detail ?? this.detail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'code': code,
      'detail': detail,
    };
  }

  factory Failure.fromMap(Map<String, dynamic> map) {
    return Failure(
      message: map['message'] as String,
      code: map['code'] != null ? map['code'] as String : null,
      detail: map['detail'] != null ? map['detail'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Failure.fromJson(String source) =>
      Failure.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
