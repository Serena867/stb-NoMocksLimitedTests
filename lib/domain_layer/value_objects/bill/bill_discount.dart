import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:split_the_bill/domain_layer/domain_exception.dart';

class Discount extends Equatable {
  final double dollarValue;
  final double percentageValue;

  const Discount._({required this.dollarValue, required this.percentageValue});

  static Discount create(
      {double dollarValue = 0.0, double percentageValue = 0.0}) {
    if (dollarValue < 0.0 || percentageValue < 0.0) {
      throw DomainException('Discount values can\'t be below 0');
    } else {
      return Discount._(
          dollarValue: dollarValue, percentageValue: percentageValue);
    }
  }

  factory Discount.fromRawJson(String string) =>
      Discount.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory Discount.fromJson(Map<String, dynamic> json) => Discount._(
        dollarValue: double.parse(json["dollarValue"].toString()),
        percentageValue: double.parse(json["percentageValue"].toString()),
      );

  Map<String, dynamic> toJson() => {
        'dollarValue': dollarValue,
        'percentageValue': percentageValue,
      };

  @override
  String toString() {
    return 'Discount{dollarValue: $dollarValue, percentageValue: $percentageValue}';
  }

  @override
  List<Object> get props => [dollarValue, percentageValue];
}
