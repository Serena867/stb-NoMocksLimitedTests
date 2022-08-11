import 'package:injectable/injectable.dart';
import 'package:split_the_bill/data_layer/data_sources/IDatasource.dart';
import '../../domain_layer/entities/bill.dart';
import '../../domain_layer/repository_interfaces/IBillRepository.dart';
import '../models/bill_dto.dart';

@Singleton(as: IBillRepository)
class BillRepository implements IBillRepository {
  final IDatasource _datasource;

  BillRepository({required IDatasource datasource}) : _datasource = datasource;

  @override
  addBill(Bill bill) async {
    var billModel = BillDTO(
      billID: bill.billID,
      billName: bill.billName,
      billType: bill.billType,
      date: bill.date,
      extraFees: bill.extraFees,
      discount: bill.discount,
      tax: bill.tax,
      items: bill.items,
      users: bill.users,
      splitEqually: bill.splitEqually,
    );
    return await _datasource.addBill(billModel);
  }

  @override
  Future<List<BillDTO>> readAllBills() async {
    return await _datasource.readAllBills();
  }

  @override
  Future<BillDTO> readBillById(billID) async {
    return await _datasource.readBillById(billID);
  }

  @override
  updateBill(Bill bill) async {
    var billModel = BillDTO(
      billID: bill.billID,
      billName: bill.billName,
      billType: bill.billType,
      date: bill.date,
      extraFees: bill.extraFees,
      discount: bill.discount,
      tax: bill.tax,
      items: bill.items,
      users: bill.users,
      splitEqually: bill.splitEqually,
    );
    return await _datasource.updateBill(billModel);
  }

  @override
  deleteBill(billID) async {
    return await _datasource.deleteBill(billID);
  }
}
