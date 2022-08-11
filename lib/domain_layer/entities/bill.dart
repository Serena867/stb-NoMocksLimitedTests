import 'package:split_the_bill/domain_layer/entities/user.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_date.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_discount.dart';
import '../domain_exception.dart';
import '../value_objects/bill/bill_extra_fees.dart';
import '../value_objects/bill/bill_name.dart';
import '../value_objects/bill/bill_tax.dart';
import '../value_objects/bill/bill_type.dart';

typedef ItemID = String;

class Bill {
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

  const Bill({
    required this.billID,
    required this.billName,
    required this.billType,
    required this.date,
    required this.extraFees,
    required this.discount,
    required  this.tax,
    required  this.items,
    required  this.users,
    required  this.splitEqually,
  });

  Bill addItemToBill(ItemID item, int quantity) {
    final copy = Map<ItemID, int>.from(items);
    quantity <= 0
        ? throw DomainException('Error: Quantity at or below 0')
        : copy[item] = quantity + (copy[item] ?? 0);
    return Bill(
        billID: billID,
        billName: billName,
        billType: billType,
        date: date,
        extraFees: extraFees,
        discount: discount,
        tax: tax,
        items: copy,
        users: users,
        splitEqually: splitEqually);
  }

  Bill updateItemQuantity(ItemID item, int quantity) {
    var copy = Map<ItemID, int>.from(items);
    if (quantity == 0) {
      return this;
    }
    if (quantity > 0) {
      copy[item] = (copy[item] ?? 0) + quantity;
    } else {
      copy[item]! <= quantity.abs()
          ? copy.remove(item)
          : copy[item] = (copy[item] ?? 0) + quantity;
    }
    return Bill(
        billID: billID,
        billName: billName,
        billType: billType,
        date: date,
        extraFees: extraFees,
        discount: discount,
        tax: tax,
        items: copy,
        users: users,
        splitEqually: splitEqually);
  }

  Bill deleteItemFromBill(ItemID item) {
    final copy = Map<ItemID, int>.from(items);
    copy.containsKey(item) ? copy.remove(item) : null;
    return Bill(
        billID: billID,
        billName: billName,
        billType: billType,
        date: date,
        extraFees: extraFees,
        discount: discount,
        tax: tax,
        items: copy,
        users: users,
        splitEqually: splitEqually);
  }

  Bill addUserToBill(User user) {
    for (var inList in users) {
      inList == user
          ? throw DomainException("Error: Can't add duplicate user")
          : null;
    }
    final copy = users;
    copy.add(user);
    return Bill(
        billID: billID,
        billName: billName,
        billType: billType,
        date: date,
        extraFees: extraFees,
        discount: discount,
        tax: tax,
        items: items,
        users: copy,
        splitEqually: splitEqually);
  }

  Bill removeUserFromBill(User user) {
    final copy = users;
    copy.isNotEmpty && copy.contains(user)
        ? copy.remove(user)
        : throw DomainException("Error: User ID not found.");
    return Bill(
        billID: billID,
        billName: billName,
        billType: billType,
        date: date,
        extraFees: extraFees,
        discount: discount,
        tax: tax,
        items: items,
        users: copy,
        splitEqually: splitEqually);
  }
}
