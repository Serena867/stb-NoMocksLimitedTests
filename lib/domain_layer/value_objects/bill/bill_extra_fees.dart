import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:split_the_bill/domain_layer/domain_exception.dart';

class ExtraFees extends Equatable {
  final double dollarValue;
  final double percentageValue;
  final double tip;

  const ExtraFees._(
      {required this.dollarValue,
      required this.percentageValue,
      required this.tip});

  static ExtraFees create(
      {double dollarValue = 0.0,
      double percentageValue = 0.0,
      double tip = 0.0}) {
    if (dollarValue < 0.0 || percentageValue < 0.0 || tip < 0.0) {
      throw DomainException(
          'Domain exception: fees can\'t be null or less than 0');
    } else {
      return ExtraFees._(
          dollarValue: dollarValue, percentageValue: percentageValue, tip: tip);
    }
  }

  factory ExtraFees.fromRawJson(String string) =>
      ExtraFees.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory ExtraFees.fromJson(Map<String, dynamic> json) => ExtraFees._(
        dollarValue: double.parse(json["dollarValue"].toString()),
        percentageValue: double.parse(json["percentageValue"].toString()),
        tip: double.parse(json["tip"].toString()),
      );

  Map<String, dynamic> toJson() => {
        'dollarValue': dollarValue,
        'percentageValue': percentageValue,
        'tip': tip,
      };

  @override
  String toString() {
    return 'ExtraFees{dollarValue: $dollarValue, percentageValue: $percentageValue, tip: $tip}';
  }

  @override
  List<Object> get props => [dollarValue, percentageValue, tip];
}
