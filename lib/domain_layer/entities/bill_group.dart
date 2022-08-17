import 'package:split_the_bill/data_layer/models/bill_group_dto.dart';
import 'package:split_the_bill/domain_layer/domain_exception.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/groups/group_name.dart';
import 'bill.dart';

typedef BillID = String;

class BillGroup {
  final String groupID;
  final GroupName groupName;
  final List<BillID> bills;

  const BillGroup(
      {required this.groupID, required this.groupName, required this.bills});

  BillGroup addBillToList(Bill bill) {
    for (var each in bills) {
      each == bill
          ? throw DomainException("Error: Can't add duplicate bill")
          : null;
    }
    final copy = bills;
    copy.add(bill.billID);
    return BillGroup(groupID: groupID, groupName: groupName, bills: copy);
  }

  BillGroup removeBillFromList(Bill bill) {
    final copy = bills;
    copy.isNotEmpty && copy.contains(bill)
        ? copy.remove(bill)
        : throw DomainException("Error: Bill not found. Unable to remove bill");
    return BillGroup(groupID: groupID, groupName: groupName, bills: copy);
  }
}
