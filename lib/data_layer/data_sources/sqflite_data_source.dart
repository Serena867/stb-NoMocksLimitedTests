import 'package:injectable/injectable.dart';
import 'package:split_the_bill/data_layer/models/item_dto.dart';
import 'package:sqflite/sqflite.dart';
import '../models/bill_dto.dart';
import '../models/bill_group_dto.dart';
import '../models/user_dto.dart';
import 'IDatasource.dart';

@Singleton(as: IDatasource)
class SqfliteDatasource implements IDatasource {
  final Database _database;

  const SqfliteDatasource({required Database database}) : _database = database;

  @override
  addBill(BillDTO billModel) async {
    return await _database.insert('bills', billModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<BillDTO>> readAllBills() async {
    List<BillDTO> bills = [];
    var maps = await _database.query('bills');
    if (maps.isEmpty) {
      return [];
    }
    for (var data in maps) {
      BillDTO bill = BillDTO.fromJson(data);
      bills.add(bill);
    }
    return bills;
  }

  @override
  Future<BillDTO> readBillById(billID) async {
    var maps =
        await _database.query('bills', where: 'billID=?', whereArgs: [billID]);
    return BillDTO.fromJson(maps.first);
  }

  @override
  updateBill(BillDTO billModel) async {
    return await _database.update('bills', billModel.toJson(),
        where: 'billID=?', whereArgs: [billModel.billID]);
  }

  @override
  deleteBill(billID) async {
    return await _database
        .rawDelete('${'DELETE FROM bills WHERE billID' '=\'' + billID}\'');
  }

  @override
  addItem(ItemDTO itemModel) async {
    return await _database.insert('items', itemModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<ItemDTO>> readAllItems() async {
    List<ItemDTO> items = [];
    var maps = await _database.query('items');
    if (maps.isEmpty) {
      return [];
    }
    for (var data in maps) {
      ItemDTO item = ItemDTO.fromJson(data);
      items.add(item);
    }
    return items;
  }

  @override
  Future<ItemDTO> readItemById(itemID) async {
    var maps =
        await _database.query('items', where: 'itemID=?', whereArgs: [itemID]);
    return ItemDTO.fromJson(maps.first);
  }

  @override
  Future<ItemDTO> readItemByUserId(userID) async {
    var maps =
        await _database.query('items', where: 'userID=?', whereArgs: [userID]);
    return ItemDTO.fromJson(maps.first);
  }

  @override
  Future<List<ItemDTO>> readItemByBillId(billID) async {
    List<ItemDTO> items = [];
    var maps =
        await _database.query('items', where: 'billID=?', whereArgs: [billID]);
    if (maps.isEmpty) {
      return [];
    }
    for (var data in maps) {
      ItemDTO item = ItemDTO.fromJson(data);
      items.add(item);
    }
    return items;
  }

  @override
  updateItem(ItemDTO itemModel) async {
    return await _database.update('items', itemModel.toJson(),
        where: 'itemID=?', whereArgs: [itemModel.toJson()['itemID']]);
  }

  @override
  deleteItem(itemID) async {
    print('\n\n\n\n\n');
    print(itemID);
    print('\n\n\n\n\n\n');
    return await _database
        .rawDelete('${'DELETE FROM items WHERE itemID' + '=\'' + itemID}\'');
  }

  @override
  addUser(UserDTO userModel) async {
    return await _database.insert('users', userModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<UserDTO>> readAllUsers() async {
    List<UserDTO> users = [];
    var maps = await _database.query('users');
    if (maps.isEmpty) {
      return [];
    }
    for (var data in maps) {
      UserDTO user = UserDTO.fromJson(data);
      users.add(user);
    }
    return users;
  }

  @override
  Future<UserDTO> readUserById(userID) async {
    var maps =
        await _database.query('users', where: 'userID=?', whereArgs: [userID]);
    return UserDTO.fromJson(maps.first);
  }

  @override
  updateUser(UserDTO userModel) async {
    return await _database.update('users', userModel.toJson(),
        where: 'userID=?', whereArgs: [userModel.toJson()['userID']]);
  }

  @override
  deleteUser(userID) async {
    return await _database
        .rawDelete('${'DELETE FROM users WHERE userID' '=\'' + userID}\'');
  }

  @override
  addGroup(BillGroupDTO groupModel) async {
    return await _database.insert('groups', groupModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<BillGroupDTO>> readAllGroups() async {
    List<BillGroupDTO> groups = [];
    var maps = await _database.query('groups');
    if (maps.isEmpty) {
      return [];
    }
    for (var data in maps) {
      BillGroupDTO group = BillGroupDTO.fromJson(data);
      groups.add(group);
    }
    return groups;
  }

  @override
  Future<BillGroupDTO> readGroupById(groupID) async {
    var maps = await _database
        .query('groups', where: 'groupID=?', whereArgs: [groupID]);
    return BillGroupDTO.fromJson(maps.first);
  }

  @override
  updateGroup(BillGroupDTO groupModel) async {
    return await _database.update('groups', groupModel.toJson(),
        where: 'groupID=?', whereArgs: [groupModel.toJson()['groupID']]);
  }

  @override
  deleteGroup(groupID) async {
    return await _database
        .rawDelete('${'DELETE FROM groups WHERE groupID' '=\'' + groupID}\'');
  }
}
