import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:split_the_bill/domain_layer/domain_exception.dart';

class FirstName extends Equatable {
  static const int MAX_FIRST_NAME_LENGTH = 40;
  final String firstName;

  const FirstName._({required this.firstName});

  static FirstName create(String input) {
    if (input.isEmpty) {
      throw DomainException('Domain exception: First name can\'t be null');
    } else if (input.length > MAX_FIRST_NAME_LENGTH) {
      throw DomainException(
          'Domain exception: First name can\'t be longer than 40 characters');
    } else {
      return FirstName._(firstName: input);
    }
  }

  factory FirstName.fromRawJson(String string) => FirstName.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory FirstName.fromJson(Map<String, dynamic> json) => FirstName._ (
        firstName: json['firstName'],
  );

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
  };

  @override
  String toString() {
    return 'FirstName{firstName: $firstName}';
  }

  @override
  List<Object> get props => [firstName];
}
