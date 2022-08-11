import '../../data_layer/models/bill_dto.dart';
import '../entities/bill.dart';

abstract class IBillRepository {
  addBill(Bill bill);
  Future<List<BillDTO>> readAllBills();
  Future<BillDTO> readBillById(billID);
  updateBill(Bill bill);
  deleteBill(billID);
}