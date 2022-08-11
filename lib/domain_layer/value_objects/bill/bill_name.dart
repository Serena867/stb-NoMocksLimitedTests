import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:split_the_bill/domain_layer/domain_exception.dart';

class BillName extends Equatable {
  final String billName;

  const BillName._({required this.billName});

  static BillName create(String billName) {
    if (billName.isEmpty) {
      throw DomainException('Bill name is empty or null');
    } else {
      return BillName._(billName: billName);
    }
  }

  factory BillName.fromRawJson(String string) =>
      BillName.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory BillName.fromJson(Map<String, dynamic> json) => BillName._(
        billName: json['billName'],
      );

  Map<String, dynamic> toJson() => {
        'billName': billName,
      };

  @override
  String toString() {
    return 'BillName{billName: $billName}';
  }

  @override
  List<Object?> get props => [billName];
}
