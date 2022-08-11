import '../../data_layer/models/item_dto.dart';
import '../entities/item.dart';

abstract class IItemRepository {
  addItem(Item item);
  Future<List<ItemDTO>> readAllItems();
  Future<ItemDTO> readItemById(itemID);
  Future<ItemDTO> readItemsByUserId(userID);
  Future<List<ItemDTO>> readItemsByBillId(billID);
  updateItem(Item item);
  deleteItem(itemID);
}