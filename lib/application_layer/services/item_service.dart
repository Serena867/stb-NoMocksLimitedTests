import 'package:async/async.dart';
import 'package:injectable/injectable.dart';
import 'package:split_the_bill/domain_layer/repository_interfaces/IItemRepository.dart';
import '../../domain_layer/entities/item.dart';

///Current controller and services are setup to accommodate future changes and
///to save time having to plumb them in later.

@Injectable()
class ItemService {
  final IItemRepository _itemRepository;

  ItemService({required IItemRepository itemRepository})
      : _itemRepository = itemRepository;

  Future<Item> getItemById(String id) async {
    var data = await _itemRepository.readItemById(id);
    Item item = Item(
        itemID: data.itemID,
        itemName: data.itemName,
        price: data.price,
        userID: data.userID,
        billID: data.billID);
    return item;
  }

  Future<dynamic> memoizeGetItemById(
      AsyncMemoizer itemMemoizer, String id) async {
    return itemMemoizer.runOnce(() async {
      await Future.delayed(const Duration(microseconds: 5));
      return getItemById(id);
    });
  }

  Future<List<Item>> getAllItemsByBillId(String billID) async {
    List<Item> items = [];
    var data = await _itemRepository.readItemsByBillId(billID);
    for (var itemData in data) {
      Item item = Item(
          itemID: itemData.itemID,
          itemName: itemData.itemName,
          price: itemData.price,
          userID: itemData.userID,
          billID: itemData.billID);
      items.add(item);
    }
    return items;
  }

  Future<dynamic> memoizeGetAllItemsByBillId(
      AsyncMemoizer itemMemoizer, String id) async {
    return itemMemoizer.runOnce(() async {
      await Future.delayed(const Duration(microseconds: 5));
      return getAllItemsByBillId(id);
    });
  }

  Future<List<Item>> getAllItems() async {
    List<Item> items = [];
    var data = await _itemRepository.readAllItems();
    for (var itemData in data) {
      Item item = Item(
          itemID: itemData.itemID,
          itemName: itemData.itemName,
          price: itemData.price,
          userID: itemData.itemID,
          billID: itemData.billID);
      items.add(item);
    }
    return items;
  }

  Future<dynamic> memoizeGetAllItems(AsyncMemoizer itemMemoizer) async {
    return itemMemoizer.runOnce(() async {
      await Future.delayed(const Duration(microseconds: 5));
      return getAllItems();
    });
  }

  updateItem(Item item) async {
    return await _itemRepository.updateItem(item);
  }

  addItem(Item item) async {
    return await _itemRepository.addItem(item);
  }

  deleteItem(Item item) async {
    return await _itemRepository.deleteItem(item.itemID);
  }
}
