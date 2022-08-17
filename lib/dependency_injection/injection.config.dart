// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sqflite/sqflite.dart' as _i3;

import '../application_layer/services/bill_service.dart' as _i22;
import '../application_layer/services/group_service.dart' as _i17;
import '../application_layer/services/item_service.dart' as _i14;
import '../application_layer/services/user_service.dart' as _i16;
import '../data_layer/data_sources/IDatasource.dart' as _i4;
import '../data_layer/data_sources/sqflite_data_source.dart' as _i5;
import '../data_layer/factories/EntityFactory.dart' as _i7;
import '../data_layer/factories/sqflite_database_factory.dart' as _i15;
import '../data_layer/repositories/bill_repository.dart' as _i19;
import '../data_layer/repositories/group_repository.dart' as _i9;
import '../data_layer/repositories/item_repository.dart' as _i11;
import '../data_layer/repositories/user_repository.dart' as _i13;
import '../domain_layer/factories/IEntityFactory.dart' as _i6;
import '../domain_layer/repository_interfaces/IBillRepository.dart' as _i18;
import '../domain_layer/repository_interfaces/IGroupRepository.dart' as _i8;
import '../domain_layer/repository_interfaces/IItemRepository.dart' as _i10;
import '../domain_layer/repository_interfaces/IUserRepository.dart' as _i12;
import '../presentation_layer/controllers/bill/bill_controller.dart' as _i25;
import '../presentation_layer/controllers/bill/bill_item_controller.dart'
    as _i26;
import '../presentation_layer/controllers/bill/bill_user_controller.dart'
    as _i23;
import '../presentation_layer/controllers/groups/group_controller.dart' as _i24;
import '../presentation_layer/controllers/item/item_controller.dart' as _i20;
import '../presentation_layer/controllers/user/user_controller.dart' as _i21;
import 'sqflite_injection_module.dart'
    as _i27; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i8.IGroupRepository>(
      _i9.GroupRepository(datasource: get<_i4.IDatasource>()));
  gh.singleton<_i10.IItemRepository>(
      _i11.ItemRepository(datasource: get<_i4.IDatasource>()));
  gh.singleton<_i12.IUserRepository>(
      _i13.UserRepository(datasource: get<_i4.IDatasource>()));
  gh.factory<_i14.ItemService>(
      () => _i14.ItemService(itemRepository: get<_i10.IItemRepository>()));
  gh.singleton<_i15.SqfliteDatabaseFactory>(_i15.SqfliteDatabaseFactory());
  gh.factory<_i16.UserService>(
      () => _i16.UserService(userRepository: get<_i12.IUserRepository>()));
  gh.factory<_i17.GroupService>(
      () => _i17.GroupService(groupRepository: get<_i8.IGroupRepository>()));
  gh.singleton<_i18.IBillRepository>(
      _i19.BillRepository(datasource: get<_i4.IDatasource>()));
  gh.factory<_i20.ItemController>(
      () => _i20.ItemController(itemService: get<_i14.ItemService>()));
  gh.factory<_i21.UserController>(
      () => _i21.UserController(userService: get<_i16.UserService>()));
  gh.factory<_i22.BillService>(() => _i22.BillService(
      billRepository: get<_i18.IBillRepository>(),
      itemService: get<_i14.ItemService>()));
  gh.factory<_i23.BillUserController>(
      () => _i23.BillUserController(billService: get<_i22.BillService>()));
  gh.factory<_i24.GroupController>(
      () => _i24.GroupController(groupService: get<_i17.GroupService>()));
  gh.factory<_i25.BillController>(
      () => _i25.BillController(billService: get<_i22.BillService>()));
  gh.factory<_i26.BillItemController>(
      () => _i26.BillItemController(billService: get<_i22.BillService>()));
  return get;
}

class _$SqfliteInjectionModule extends _i27.SqfliteInjectionModule {}
