import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:split_the_bill/domain_layer/domain_exception.dart';

class GroupName extends Equatable {
  final String groupName;

  const GroupName._({required this.groupName});

  static GroupName create(String groupName) {
    if (groupName.isEmpty) {
      throw DomainException("Error: Group name can't be empty or null");
    } else {
      return GroupName._(groupName: groupName);
    }
  }

  factory GroupName.fromRawJson(String string) =>
      GroupName.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory GroupName.fromJson(Map<String, dynamic> json) =>
      GroupName._(groupName: json['groupName']);

  Map<String, dynamic> toJson() => {'groupName': groupName};

  @override
  String toString() {
    return 'GroupName{groupName: $groupName}';
  }

  @override
  List<Object?> get props => [groupName];
}
