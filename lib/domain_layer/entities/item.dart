import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../value_objects/item/item_name.dart';

class Item extends Equatable {
  final String itemID;
  final ItemName itemName;
  final double price;
  final String userID;
  final String billID;

  const Item({
    required this.itemID,
    required this.itemName,
    required this.price,
    required this.userID,
    required this.billID,
  });

  factory Item.fromRawJson(String string) => Item.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemID: json["itemID"],
        itemName: json["itemName"],
        price: json["price"],
        userID: json["userID"],
        billID: json["billID"],
      );

  Map<String, dynamic> toJson() => {
        "itemID": itemID,
        "itemName": itemName,
        "price": price,
        "userID": userID,
        "billID": billID,
      };

  @override
  String toString() {
    return 'Item{itemID: $itemID, itemName: $itemName, price: $price, userID: $userID, billID: $billID}';
  }

  @override
  List<Object?> get props => [itemID, itemName, price, userID, billID];
}
