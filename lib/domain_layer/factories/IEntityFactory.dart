import 'package:split_the_bill/domain_layer/value_objects/bill/bill_date.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_discount.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/groups/group_name.dart';
import '../../data_layer/models/bill_group_dto.dart';
import '../entities/bill.dart';
import '../entities/bill_group.dart';
import '../entities/item.dart';
import '../entities/user.dart';
import '../value_objects/bill/bill_extra_fees.dart';
import '../value_objects/bill/bill_name.dart';
import '../value_objects/bill/bill_tax.dart';
import '../value_objects/bill/bill_type.dart';
import '../value_objects/item/item_name.dart';
import '../value_objects/user/user_email.dart';
import '../value_objects/user/user_first_name.dart';
import '../value_objects/user/user_last_name.dart';

abstract class IEntityFactory {
  Bill newBill(
      {required String billID,
      required BillName billName,
      required BillType billType,
      required BillDate date,
      required ExtraFees extraFees,
      required Discount discount,
      required Tax tax,
      required Map<ItemID, int> items,
      required List<User> users,
      required bool splitEqually});

  User newUser({
    required String userID,
    required FirstName firstName,
    required LastName lastName,
    required Email email,
  });

  Item newItem({
    required String itemID,
    required ItemName itemName,
    required double price,
    required String userID,
    required String billID,
  });

  BillGroup newGroup(
      {required String groupID,
        required GroupName groupName,
        required List<BillID> bills});
}
