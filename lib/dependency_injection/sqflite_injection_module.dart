import 'package:injectable/injectable.dart';
import 'package:split_the_bill/dependency_injection/sqflite_injection_service.dart';
import 'package:sqflite/sqflite.dart';

@module
abstract class SqfliteInjectionModule {
  @preResolve
  Future<Database> get data => SqfliteInjectionService.initialize();
}
