import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:split_the_bill/domain_layer/domain_exception.dart';

class BillDate extends Equatable {
  final String billDate;

  const BillDate._({required this.billDate});

  static BillDate create(String inputDate) {
    final formatter = DateFormat('yyyy-MM-dd');
    if (inputDate.isNotEmpty) {
      try {
        formatter.parseStrict(inputDate);
      } catch (error) {
        throw DomainException('Invalid date: format error try yyyy-MM-dd');
      }
    } else {
      throw DomainException('Invalid date: Date cannot be empty or null');
    }
    return BillDate._(billDate: inputDate);
  }

  factory BillDate.fromRawJson(String string) =>
      BillDate.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory BillDate.fromJson(Map<String, dynamic> json) => BillDate._(
        billDate: json['billDate'],
      );

  Map<String, dynamic> toJson() => {
        'billDate': billDate,
      };

  DateTime toDate() => DateTime.parse(billDate);

  @override
  String toString() {
    return billDate;
  }

  @override
  List<Object> get props => [billDate];
}
