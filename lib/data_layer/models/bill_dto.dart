import 'dart:convert';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_date.dart';
import '../../domain_layer/entities/bill.dart';
import '../../domain_layer/entities/user.dart';
import '../../domain_layer/value_objects/bill/bill_discount.dart';
import '../../domain_layer/value_objects/bill/bill_extra_fees.dart';
import '../../domain_layer/value_objects/bill/bill_name.dart';
import '../../domain_layer/value_objects/bill/bill_tax.dart';
import '../../domain_layer/value_objects/bill/bill_type.dart';

class BillDTO{
  final String billID;
  final BillName billName;
  final BillType billType;
  final BillDate date;
  final ExtraFees extraFees;
  final Discount discount;
  final Tax tax;
  final Map<ItemID, int> items;
  final List<User> users;
  final bool splitEqually;

  BillDTO({
    required this.billID,
    required this.billName,
    required this.billType,
    required this.date,
    required this.extraFees,
    required this.discount,
    required this.tax,
    required this.items,
    required this.users,
    required this.splitEqually,
  });

  factory BillDTO.fromRawJson(String string) => BillDTO.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory BillDTO.fromJson(Map<String, dynamic> json) => BillDTO(
      billID: json["billID"],
      billName: BillName.fromRawJson(json["billName"]),
      billType: BillType.fromRawJson(json["billType"]),
      date: BillDate.fromRawJson(json["date"]),
      extraFees: ExtraFees.fromRawJson(json["extraFees"]),
      discount: Discount.fromRawJson(json["discount"]),
      tax: Tax.fromRawJson(json["tax"]),
      items: Map.from(jsonDecode(json["items"])).map((k,v) => MapEntry<ItemID, int>(k, v)),
      users: List<User>.from(jsonDecode(json['users']).map((data) => User.fromJson(data))),
      splitEqually: json["splitEqually"] == '1' ? true : false);

  Map<String, dynamic> toJson() => {
        "billID": billID,
        "billName": billName.toRawJson(),
        "billType": billType.toRawJson(),
        "date": date.toRawJson(),
        "extraFees": extraFees.toRawJson(),
        "discount": discount.toRawJson(),
        "tax": tax.toRawJson(),
        "items": json.encode(Map.from(items).map((k, v) => MapEntry<String, dynamic>(k, v))),
        "users": json.encode(List<dynamic>.from(users.map((data) => data.toJson()))),
        "splitEqually": splitEqually == true ? '1' : '0'
      };


  @override
  String toString() {
    return 'bill{billID: $billID, billName: $billName, billType: $billType, date: $date, extraFees: $extraFees, discount: $discount, tax: $tax, items: $items, users: $users, splitEqually: $splitEqually}'; // extraFees: $extraFees
  }
}
