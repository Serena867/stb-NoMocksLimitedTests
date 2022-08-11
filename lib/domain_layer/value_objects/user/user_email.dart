import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:split_the_bill/domain_layer/domain_exception.dart';

//TODO: Add validation including regex

class Email extends Equatable {
  final String email;

  const Email._({required this.email});

  static Email create(String email) {
    if (email.isEmpty) {
      throw DomainException('Domain exception: Email is empty or null');
    } else {
      return Email._(email: email);
    }
  }

  factory Email.fromRawJson(String string) =>
      Email.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory Email.fromJson(Map<String, dynamic> json) => Email._(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
      };

  @override
  String toString() {
    return 'Email{email: $email}';
  }

  @override
  List<Object> get props => [email];
}
