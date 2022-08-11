import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:split_the_bill/domain_layer/domain_exception.dart';

class ItemName extends Equatable {
  final String itemName;

  const ItemName._({required this.itemName});

  static ItemName create(String itemName) {
    if (itemName.isEmpty) {
      throw DomainException('Item name is empty or null');
    } else {
      return ItemName._(itemName: itemName);
    }
  }

  factory ItemName.fromRawJson(String string) =>
      ItemName.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory ItemName.fromJson(Map<String, dynamic> json) => ItemName._(
        itemName: json['itemName'],
      );

  Map<String, dynamic> toJson() => {
        'itemName': itemName,
      };

  @override
  String toString() {
    return 'ItemName{itemName: $itemName}';
  }

  @override
  List<Object> get props => [itemName];
}
