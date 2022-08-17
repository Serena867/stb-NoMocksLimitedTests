import 'dart:convert';
import 'package:split_the_bill/domain_layer/value_objects/bill/groups/group_name.dart';

import '../../domain_layer/entities/bill_group.dart';

//TODO: add value object for groupName

class BillGroupDTO {
  final String groupID;
  final GroupName groupName;
  final List<BillID> bills;

  BillGroupDTO(
      {required this.groupID, required this.groupName, required this.bills});

  factory BillGroupDTO.fromRawJson(String string) =>
      BillGroupDTO.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory BillGroupDTO.fromJson(Map<String, dynamic> json) => BillGroupDTO(
        groupID: json["groupID"],
        groupName: GroupName.fromRawJson(json["groupName"]),
        bills: List<String>.from(jsonDecode(json["bills"]).map((data) => (data))),
      );

  Map<String, dynamic> toJson() => {
        "groupID": groupID,
        "groupName": groupName.toRawJson(),
        "bills": jsonEncode(List<dynamic>.from(bills.map((data) => data))),
      };

  @override
  String toString() {
    return 'billGroup{groupID: $groupID, groupName: $groupName, bills: $bills}';
  }
}
