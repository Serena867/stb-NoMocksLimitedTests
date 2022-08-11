import 'package:async/async.dart';
import 'package:injectable/injectable.dart';
import 'package:split_the_bill/domain_layer/repository_interfaces/IBillRepository.dart';
import '../../domain_layer/entities/bill.dart';
import '../../domain_layer/entities/item.dart';
import '../../domain_layer/entities/user.dart';
import 'item_service.dart';

///Current controller and services are setup to accommodate future changes and
///to save time having to plumb them in later.

@Injectable()
class BillService {
  final IBillRepository _billRepository;
  final ItemService _itemService;

  BillService(
      {required IBillRepository billRepository,
      required ItemService itemService})
      : _billRepository = billRepository,
        _itemService = itemService;

  Future<Bill> getBillById(String id) async {
    var data = await _billRepository.readBillById(id);
    var billModel = Bill(
        billID: data.billID,
        billName: data.billName,
        billType: data.billType,
        date: data.date,
        extraFees: data.extraFees,
        discount: data.discount,
        tax: data.tax,
        items: data.items,
        users: data.users,
        splitEqually: data.splitEqually);
    return billModel;
  }

  Future<dynamic> memoizeGetBIllById(
      AsyncMemoizer billByIdMemoizer, String id) async {
    return billByIdMemoizer.runOnce(() async {
      await Future.delayed(const Duration(microseconds: 5));
      return getBillById(id);
    });
  }

  Future<List<Bill>> getAllBills() async {
    List<Bill> bills = [];
    var data = await _billRepository.readAllBills();
    for (var billData in data) {
      var billModel = Bill(
          billID: billData.billID,
          billName: billData.billName,
          billType: billData.billType,
          date: billData.date,
          extraFees: billData.extraFees,
          discount: billData.discount,
          tax: billData.tax,
          items: billData.items,
          users: billData.users,
          splitEqually: billData.splitEqually);
      bills.add(billModel);
    }
    return bills;
  }

  Future<dynamic> memoizeGetAllBillData(AsyncMemoizer billMemoizer) async {
    return billMemoizer.runOnce(() async {
      await Future.delayed(const Duration(microseconds: 5));
      return getAllBills();
    });
  }

  Future<List<Bill>> getAllBillsWithUser(User user) async {
    List<Bill> billsWithUser = [];
    var data = await _billRepository.readAllBills();
    for (var billData in data) {
      if (billData.users.contains(user)) {
        Bill billModel = Bill(billID: billData.billID,
            billName: billData.billName,
            billType: billData.billType,
            date: billData.date,
            extraFees: billData.extraFees,
            discount: billData.discount,
            tax: billData.tax,
            items: billData.items,
            users: billData.users,
            splitEqually: billData.splitEqually);
        billsWithUser.add(billModel);
      }
    }
    return billsWithUser;
  }

  Future<dynamic> memoizeGetAllBillsWithUser(AsyncMemoizer billMemoizer, User user) async {
    return billMemoizer.runOnce(() async {
      await Future.delayed(const Duration(microseconds: 5));
      return getAllBillsWithUser(user);
    });
  }

  Future<List<double>> calculateBillTotals(String id) async {
    List<double> totals = [];
    Bill bill = await getBillById(id);
    double subTotal = 0;
    List<Item> items = [];
    items = await _itemService.getAllItemsByBillId(id);
    for (var each in items) {
      for (ItemID billKey in bill.items.keys) {
        subTotal += each.price * bill.items[billKey]!;
      }
    }
    double billSubTotal =
        ((bill.extraFees.dollarValue + subTotal) - bill.discount.dollarValue) *
            ((100.0 + bill.extraFees.percentageValue) / 100.0) *
            ((100.0 - bill.discount.percentageValue) / 100.0);
    double billTotal =
        subTotal * ((bill.tax.tax / 100.0) + 1.0) + bill.extraFees.tip;
    totals.add(billSubTotal);
    totals.add(billTotal);
    return totals;
  }

  updateBill(Bill bill) async {
    return await _billRepository.updateBill(bill);
  }

  addBill(Bill bill) async {
    return await _billRepository.addBill(bill);
  }

  deleteBill(String id) async {
    return await _billRepository.deleteBill(id);
  }
}
