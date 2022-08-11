import 'package:split_the_bill/domain_layer/value_objects/user/user_last_name.dart';
import '../../domain_layer/value_objects/user/user_email.dart';
import '../../domain_layer/value_objects/user/user_first_name.dart';


class UserDTO {
  final String userID;
  final FirstName firstName;
  final LastName lastName;
  final Email email;

  UserDTO({
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory UserDTO.fromJson(Map<String, dynamic> parsedJson) => UserDTO(
        userID: parsedJson["userID"],
        firstName: FirstName.fromRawJson(parsedJson['firstName']),
        lastName: LastName.fromRawJson(parsedJson['lastName']),
        email: Email.fromRawJson(parsedJson['email']),
      );

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'firstName': firstName.toRawJson(),
        'lastName': lastName.toRawJson(),
        'email': email.toRawJson(),
      };

  @override
  String toString() {
    return 'User{userID: $userID, firstName: $firstName, lastName: $lastName, email: $email}';
  }
}
