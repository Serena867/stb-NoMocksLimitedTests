import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:split_the_bill/domain_layer/value_objects/user/user_email.dart';
import 'package:split_the_bill/domain_layer/value_objects/user/user_first_name.dart';
import '../value_objects/user/user_last_name.dart';

class User extends Equatable{
  final String userID;
  final FirstName firstName;
  final LastName lastName;
  final Email email;

  const User({
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory User.fromRawJson(String string) => User.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    userID: json["userID"],
    firstName: FirstName.fromJson(json["firstName"]),
    lastName: LastName.fromJson(json["lastName"]),
    email: Email.fromJson(json["email"]),
  );

  Map<String, dynamic> toJson() => {
    "userID": userID,
    "firstName": firstName.toJson(),
    "lastName": lastName.toJson(),
    "email": email.toJson(),
  };

  @override
  String toString(){
    return 'User{userID: $userID, firstName: $firstName, lastName: $lastName, email: $email}';
  }

  @override
  List<Object?> get props => [userID, firstName, lastName, email];

}
