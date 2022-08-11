import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:split_the_bill/domain_layer/domain_exception.dart';

class BillType extends Equatable {
  final String billType;

  const BillType._({required this.billType});

  static BillType create(String type) {
    if (type.isEmpty) {
      throw DomainException('Bill type cannot be null or empty');
    } else {
      return BillType._(billType: type);
    }
  }

  factory BillType.fromRawJson(String string) =>
      BillType.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory BillType.fromJson(Map<String, dynamic> json) => BillType._(
        billType: json['billType'],
      );

  Map<String, dynamic> toJson() => {
        'billType': billType,
      };

  @override
  String toString() {
    return 'BillType{billType: $billType}';
  }

  @override
  List<Object> get props => [billType];
}
