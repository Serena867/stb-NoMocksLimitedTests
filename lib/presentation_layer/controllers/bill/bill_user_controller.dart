import 'package:async/async.dart';
import 'package:injectable/injectable.dart';
import 'package:split_the_bill/application_layer/services/bill_service.dart';
import '../../../domain_layer/entities/bill.dart';
import '../../../domain_layer/entities/user.dart';

///Current controller and services are setup to accommodate future changes and
///to save time having to plumb them in later.

@Injectable()
class BillUserController {
  final BillService _billService;

  BillUserController({required BillService billService})
      : _billService = billService;

  Future<List<Bill>> getAllBillsWithUser(User user) async {
    return _billService.getAllBillsWithUser(user);
  }

  Future<dynamic> memoizeGetAllBillsWithUser(AsyncMemoizer billMemoizer, User user) async {
    return _billService.memoizeGetAllBillsWithUser(billMemoizer, user);
  }

  addUserToBill(Bill bill, User user) {
    var updated = bill.addUserToBill(user);
   return _billService.updateBill(updated);
  }

  removeUserFromBill(Bill bill, User user) {
    var updated = bill.removeUserFromBill(user);
   return _billService.updateBill(updated);
  }
}
