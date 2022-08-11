// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sqflite/sqflite.dart' as _i3;

import '../application_layer/services/bill_service.dart' as _i19;
import '../application_layer/services/item_service.dart' as _i12;
import '../application_layer/services/user_service.dart' as _i14;
import '../data_layer/data_sources/IDatasource.dart' as _i4;
import '../data_layer/data_sources/sqflite_data_source.dart' as _i5;
import '../data_layer/factories/EntityFactory.dart' as _i7;
import '../data_layer/factories/sqflite_database_factory.dart' as _i13;
import '../data_layer/repositories/bill_repository.dart' as _i16;
import '../data_layer/repositories/item_repository.dart' as _i9;
import '../data_layer/repositories/user_repository.dart' as _i11;
import '../domain_layer/factories/IEntityFactory.dart' as _i6;
import '../domain_layer/repository_interfaces/IBillRepository.dart' as _i15;
import '../domain_layer/repository_interfaces/IItemRepository.dart' as _i8;
import '../domain_layer/repository_interfaces/IUserRepository.dart' as _i10;
import '../presentation_layer/controllers/bill/bill_controller.dart' as _i21;
import '../presentation_layer/controllers/bill/bill_item_controller.dart'
    as _i22;
import '../presentation_layer/controllers/bill/bill_user_controller.dart'
    as _i20;
import '../presentation_layer/controllers/item/item_controller.dart' as _i17;
import '../presentation_layer/controllers/user/user_controller.dart' as _i18;
import 'sqflite_injection_module.dart'
    as _i23; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final sqfliteInjectionModule = _$SqfliteInjectionModule();
  await gh.factoryAsync<_i3.Database>(() => sqfliteInjectionModule.data,
      preResolve: true);
  gh.singleton<_i4.IDatasource>(
      _i5.SqfliteDatasource(database: get<_i3.Database>()));
  gh.factory<_i6.IEntityFactory>(() => _i7.EntityFactory());
  gh.singleton<_i8.IItemRepository>(
      _i9.ItemRepository(datasource: get<_i4.IDatasource>()));
  gh.singleton<_i10.IUserRepository>(
      _i11.UserRepository(datasource: get<_i4.IDatasource>()));
  gh.factory<_i12.ItemService>(
      () => _i12.ItemService(itemRepository: get<_i8.IItemRepository>()));
  gh.singleton<_i13.SqfliteDatabaseFactory>(_i13.SqfliteDatabaseFactory());
  gh.factory<_i14.UserService>(
      () => _i14.UserService(userRepository: get<_i10.IUserRepository>()));
  gh.singleton<_i15.IBillRepository>(
      _i16.BillRepository(datasource: get<_i4.IDatasource>()));
  gh.factory<_i17.ItemController>(
      () => _i17.ItemController(itemService: get<_i12.ItemService>()));
  gh.factory<_i18.UserController>(
      () => _i18.UserController(userService: get<_i14.UserService>()));
  gh.factory<_i19.BillService>(() => _i19.BillService(
      billRepository: get<_i15.IBillRepository>(),
      itemService: get<_i12.ItemService>()));
  gh.factory<_i20.BillUserController>(
      () => _i20.BillUserController(billService: get<_i19.BillService>()));
  gh.factory<_i21.BillController>(
      () => _i21.BillController(billService: get<_i19.BillService>()));
  gh.factory<_i22.BillItemController>(
      () => _i22.BillItemController(billService: get<_i19.BillService>()));
  return get;
}

class _$SqfliteInjectionModule extends _i23.SqfliteInjectionModule {}
