import 'package:async/async.dart';
import 'package:injectable/injectable.dart';
import 'package:split_the_bill/application_layer/services/item_service.dart';
import '../../../domain_layer/entities/item.dart';

///Current controller and services are setup to accommodate future changes and
///to save time having to plumb them in later.

@Injectable()
class ItemController{
  final ItemService _itemService;

  ItemController({required ItemService itemService}) : _itemService = itemService;

  Future<Item> getItemById(String id) async {
    return _itemService.getItemById(id);
  }

  Future<dynamic> memoizeGetItemById(AsyncMemoizer itemMemoizer, String id) async {
    return _itemService.memoizeGetItemById(itemMemoizer, id);
  }

  Future<List<Item>> getAllItemsByBillId(String id) async {
    return _itemService.getAllItemsByBillId(id);
  }

  Future<dynamic> memoizeGetAllItemsByBillId(AsyncMemoizer itemMemoizer, String id) async {
    return _itemService.memoizeGetAllItemsByBillId(itemMemoizer, id);
  }

  Future<List<Item>> getAllItems() async {
    return _itemService.getAllItems();
  }

  Future<dynamic> memoizeGetAllItems(AsyncMemoizer itemMemoizer) async {
    return _itemService.memoizeGetAllItems(itemMemoizer);
  }

  updateItem(Item item) {
    return _itemService.updateItem(item);
  }

  addItem(Item item) {
    return _itemService.addItem(item);
  }

  deleteItem(Item item){
    return _itemService.deleteItem(item);
  }

}