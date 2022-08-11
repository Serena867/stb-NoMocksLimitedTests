import 'package:injectable/injectable.dart';
import 'package:split_the_bill/application_layer/services/bill_service.dart';
import '../../../domain_layer/entities/bill.dart';


///Current controller and services are setup to accommodate future changes and
///to save time having to plumb them in later.

@Injectable()
class BillItemController {
  final BillService _billService;

  BillItemController({required BillService billService})
      : _billService = billService;

  addItemToBill(Bill bill, ItemID item, int quantity) {
    var updated = bill.addItemToBill(item, quantity);
    return _billService.updateBill(updated);
  }

  updateItemQuantity(Bill bill, ItemID item, int quantity) {
    var updated = bill.updateItemQuantity(item, quantity);
    return _billService.updateBill(updated);
  }

  deleteItemFromBill(Bill bill, ItemID item) {
    var updated = bill.deleteItemFromBill(item);
    return _billService.updateBill(updated);
  }
}
