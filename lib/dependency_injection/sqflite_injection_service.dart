import 'package:sqflite/sqflite.dart';
import '../data_layer/factories/sqflite_database_factory.dart';

class SqfliteInjectionService {
  static Future<Database> initialize() async {
    Database db = await SqfliteDatabaseFactory().setDatabase();
    return db;
  }
}