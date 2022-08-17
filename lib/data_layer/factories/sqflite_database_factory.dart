import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

@Singleton()
class SqfliteDatabaseFactory {
  Future<Database> setDatabase() async {
    String path = await getDatabasesPath();
    String databasePath = join(path, 'stb.db');
    var database =
        await openDatabase(databasePath, version: 1, onCreate: _buildDatabase, onUpgrade: _upgradeDatabase);
    return database;
  }

  void _buildDatabase(Database database, int version) async {
    await _createBillTable(database);
    await _createUserTable(database);
    await _createItemTable(database);
    await _createGroupsTable(database);
  }

  Future<void> _upgradeDatabase(Database database, int oldVersion, int newVersion) async {
  //Insert on update logic here if/when needed
  }

  _createBillTable(Database database) async {
    await database
        .execute(
          """CREATE TABLE bills(billID TEXT PRIMARY KEY, billName TEXT NOT NULL, billType TEXT NOT NULL, date TEXT NOT NULL, extraFees TEXT, discount TEXT, tax TEXT, items TEXT, users TEXT, splitEqually TEXT NOT NULL)""",
        )
        .then((_) => print('Creating bills table...'))
        .catchError((e) => print('Failed to create bill table: $e')); //
  }

  _createUserTable(database) async {
    await database
        .execute(
          """CREATE TABLE users(userID TEXT PRIMARY KEY, firstName TEXT, lastName TEXT, email TEXT)""",
        )
        .then((_) => print('Creating users table...'))
        .catchError((e) => print('Failed to create user table: $e'));
  }

  _createItemTable(database) async {
    await database
        .execute(
          """CREATE TABLE items(itemID TEXT PRIMARY KEY, itemName TEXT, price TEXT, userID TEXT, billID TEXT, FOREIGN KEY(userID) REFERENCES users(userID), FOREIGN KEY(billID) REFERENCES bills(billID))""",
        )
        .then((_) => print('Creating items table...'))
        .catchError((e) => print('Failure creating item table: $e'));
  }

  _createGroupsTable(database) async {
    await database
        .execute(
      """CREATE TABLE groups(groupID TEXT PRIMARY KEY, groupName TEXT, bills TEXT)""",
    )
        .then((_) => print('Creating groups table...'))
        .catchError((e) => print('Failed to create groups table: $e'));
  }
}
