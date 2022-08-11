import 'package:async/async.dart';
import 'package:injectable/injectable.dart';
import 'package:split_the_bill/application_layer/services/bill_service.dart';
import '../../../domain_layer/entities/bill.dart';

///Current controller and services are setup to accommodate future changes and
///to save time having to plumb them in later.

@Injectable()
class BillController {
  final BillService _billService;

  BillController({required BillService billService}) : _billService = billService;

  Future<Bill> getBillById(String id) {
    return _billService.getBillById(id);
  }

  Future<dynamic> memoizeGetBillById(AsyncMemoizer billMemoizer, String id) {
    return _billService.memoizeGetBIllById(billMemoizer, id);
  }

  Future<List<Bill>> getAllBills() {
    return _billService.getAllBills();
  }

  Future<dynamic> memoizeGetAllBills(AsyncMemoizer billMemoizer){
    return _billService.memoizeGetAllBillData(billMemoizer);
  }

  Future<List<double>> calculateBillTotals(String id){
    return _billService.calculateBillTotals(id);
  }

  updateBill(Bill bill) {
    return _billService.updateBill(bill);
  }

  addBill(Bill bill){
    return _billService.addBill(bill);
  }

  deleteBill(String id){
   return _billService.deleteBill(id);
  }
}