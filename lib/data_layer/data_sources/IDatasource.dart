import '../models/bill_dto.dart';
import '../models/item_dto.dart';
import '../models/user_dto.dart';

abstract class IDatasource{
  addBill(BillDTO bill);
  Future<List<BillDTO>> readAllBills();
  Future<BillDTO> readBillById(billID);
  updateBill(BillDTO billModel);
  deleteBill(billID);
  addItem(ItemDTO item);
  Future<List<ItemDTO>> readAllItems();
  Future<ItemDTO> readItemById(itemID);
  Future<ItemDTO> readItemByUserId(userID);
  Future<List<ItemDTO>> readItemByBillId(billID);
  updateItem(ItemDTO itemModel);
  deleteItem(itemID);
  addUser(UserDTO user);
  Future<List<UserDTO>> readAllUsers();
  Future<UserDTO> readUserById(userID);
  updateUser(UserDTO userModel);
  deleteUser(userID);
}