import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:split_the_bill/domain_layer/domain_exception.dart';

class Tax extends Equatable {
  final double tax;

  const Tax._({required this.tax});

  static Tax create({double tax = 0.0}) {
    if (tax < 0.0) {
      throw DomainException('Tax cannot be null or less than 0');
    } else {
      return Tax._(tax: tax);
    }
  }

  factory Tax.fromRawJson(String string) => Tax.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory Tax.fromJson(Map<String, dynamic> json) => Tax._(
        tax: double.parse(json["tax"].toString()),
      );

  Map<String, dynamic> toJson() => {
        'tax': tax,
      };

  @override
  String toString() {
    return 'Tax{tax: $tax}';
  }

  @override
  List<Object> get props => [tax];
}
