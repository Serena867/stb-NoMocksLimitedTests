import '../../domain_layer/value_objects/item/item_name.dart';

class ItemDTO {
  final String itemID;
  final ItemName itemName;
  final double price;
  final String userID;
  final String billID;

  ItemDTO({
    required this.itemID,
    required this.itemName,
    required this.price,
    required this.userID,
    required this.billID,
  });

  factory ItemDTO.fromJson(Map<String, dynamic> json) => ItemDTO(
        itemID: json["itemID"],
        itemName: ItemName.fromRawJson(json["itemName"]),
        price: double.parse(json["price"]),
        userID: json["userID"],
        billID: json["billID"],
      );

  Map<String, dynamic> toJson() => {
        "itemID": itemID,
        "itemName": itemName.toRawJson(),
        "price": price,
        "userID": userID,
        "billID": billID
      };

  @override
  String toString() {
    return 'individualItems{itemID: $itemID, itemName: $itemName, price: $price, userID: $userID, billID: $billID}';
  }
}
