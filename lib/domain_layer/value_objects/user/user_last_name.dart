import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../domain_exception.dart';

class LastName extends Equatable {
  static const int MAX_LAST_NAME_LENGTH = 40;
  final String lastName;

  const LastName._({required this.lastName});

  static LastName create(String input) {
    if (input.isEmpty) {
      throw DomainException('Domain exception: Last name can\'t be empty');
    } else if (input.length > MAX_LAST_NAME_LENGTH) {
      throw DomainException(
          'Domain exception: last name can\'t be longer than 40 characters');
    } else {
      return LastName._(lastName: input);
    }
  }

  factory LastName.fromRawJson(String string) =>
      LastName.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory LastName.fromJson(Map<String, dynamic> json) => LastName._(
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        'lastName': lastName,
      };

  @override
  String toString() {
    return 'LastName{lastName: $lastName}';
  }

  @override
  List<Object> get props => [lastName];
}
