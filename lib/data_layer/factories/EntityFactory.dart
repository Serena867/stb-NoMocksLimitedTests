import 'package:injectable/injectable.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_date.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_discount.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/groups/group_name.dart';
import 'package:split_the_bill/domain_layer/value_objects/item/item_name.dart';
import 'package:split_the_bill/domain_layer/value_objects/user/user_first_name.dart';
import 'package:split_the_bill/domain_layer/value_objects/user/user_last_name.dart';
import '../../domain_layer/entities/bill.dart';
import '../../domain_layer/entities/bill_group.dart';
import '../../domain_layer/entities/item.dart';
import '../../domain_layer/entities/user.dart';
import '../../domain_layer/factories/IEntityFactory.dart';
import '../../domain_layer/value_objects/bill/bill_extra_fees.dart';
import '../../domain_layer/value_objects/bill/bill_name.dart';
import '../../domain_layer/value_objects/bill/bill_tax.dart';
import '../../domain_layer/value_objects/bill/bill_type.dart';
import '../../domain_layer/value_objects/user/user_email.dart';
import '../models/bill_group_dto.dart';

@Injectable(as: IEntityFactory)
class EntityFactory implements IEntityFactory {
  @override
  Bill newBill({
    required String billID,
    required BillName billName,
    required BillType billType,
    required BillDate date,
    required ExtraFees extraFees,
    required Discount discount,
    required Tax tax,
    required Map<ItemID, int> items,
    required List<User> users,
    required bool splitEqually,
  }) {
    return Bill(
        billID: billID,
        billName: billName,
        billType: billType,
        date: date,
        extraFees: extraFees,
        discount: discount,
        tax: tax,
        items: items,
        users: users,
        splitEqually: splitEqually);
  }

  @override
  User newUser({
    required String userID,
    required FirstName firstName,
    required LastName lastName,
    required Email email,
  }) {
    return User(
        userID: userID, firstName: firstName, lastName: lastName, email: email);
  }

  @override
  Item newItem({
    required String itemID,
    required ItemName itemName,
    required double price,
    required String userID,
    required String billID,
  }) {
    return Item(
        itemID: itemID,
        itemName: itemName,
        price: price,
        userID: userID,
        billID: billID);
  }

  @override
  BillGroup newGroup(
      {required String groupID,
      required GroupName groupName,
      required List<BillID> bills}) {
    return BillGroup(groupID: groupID, groupName: groupName, bills: bills);
  }
}
