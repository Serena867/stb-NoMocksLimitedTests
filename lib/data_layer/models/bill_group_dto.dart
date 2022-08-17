import 'dart:convert';


//TODO: add value object for groupName

typedef BillID = String;

class BillGroupDTO {
  final String groupID;
  final String groupName;
  final List<BillID> bills;

  BillGroupDTO(
      {required this.groupID, required this.groupName, required this.bills});

  factory BillGroupDTO.fromRawJson(String string) =>
      BillGroupDTO.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  //TODO: Fix to/from json

  factory BillGroupDTO.fromJson(Map<String, dynamic> json) => BillGroupDTO(
      groupID: json['groupID'], groupName: json['groupName'], bills: []);

  Map<String, dynamic> toJson() => {
    "groupID": groupID,
    "groupName": groupName,
    //"bills": json.encode(List<dynamic>.from(bills.map((data) => data.toJson()))),
  };

  @override
  String toString() {
    return 'billGroup{groupID: $groupID, groupName: $groupName, bills: $bills}';
  }

}
