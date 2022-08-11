import 'package:injectable/injectable.dart';
import 'package:split_the_bill/data_layer/data_sources/IDatasource.dart';
import 'package:split_the_bill/data_layer/models/item_dto.dart';
import '../../domain_layer/entities/item.dart';
import '../../domain_layer/repository_interfaces/IItemRepository.dart';

@Singleton(as: IItemRepository)
class ItemRepository implements IItemRepository {
  final IDatasource _datasource;

  ItemRepository({required IDatasource datasource}) : _datasource = datasource;

  @override
  addItem(Item item) async {
    var itemModel = ItemDTO(
        itemID: item.itemID,
        itemName: item.itemName,
        price: item.price,
        userID: item.userID,
        billID: item.billID);
    return await _datasource.addItem(itemModel);
  }

  @override
  Future<List<ItemDTO>> readAllItems() async {
    return await _datasource.readAllItems();
  }

  @override
  Future<ItemDTO> readItemById(itemID) async {
    return await _datasource.readItemById(itemID);
  }

  @override
  Future<ItemDTO> readItemsByUserId(userID) async {
    return await _datasource.readItemByUserId(userID);
  }

  @override
  Future<List<ItemDTO>> readItemsByBillId(billID) async {
    return await _datasource.readItemByBillId(billID);
  }

  @override
  updateItem(Item item) async {
    var itemModel = ItemDTO(
      itemID: item.itemID,
        itemName: item.itemName,
        price: item.price,
        userID: item.userID,
        billID: item.billID);
    return await _datasource.updateItem(itemModel);
  }

  @override
  deleteItem(itemID) async {
    return await _datasource.deleteItem(itemID);
  }
}
