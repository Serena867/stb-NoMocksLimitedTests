import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:split_the_bill/application_layer/services/bill_service.dart';
import 'package:split_the_bill/application_layer/services/item_service.dart';
import 'package:split_the_bill/application_layer/services/user_service.dart';
import 'package:split_the_bill/domain_layer/entities/bill.dart';
import 'package:split_the_bill/domain_layer/entities/item.dart';
import 'package:split_the_bill/domain_layer/factories/IEntityFactory.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_date.dart';
import 'package:split_the_bill/domain_layer/value_objects/bill/bill_type.dart';
import 'package:split_the_bill/presentation_layer/controllers/bill/bill_controller.dart';
import 'package:split_the_bill/presentation_layer/controllers/bill/bill_item_controller.dart';
import 'package:split_the_bill/presentation_layer/controllers/item/item_controller.dart';
import 'package:split_the_bill/presentation_layer/controllers/user/user_controller.dart';
import 'package:split_the_bill/presentation_layer/user_interface/screens/home_screen.dart';
import 'package:split_the_bill/presentation_layer/user_interface/screens/new_user_screen.dart';
import 'package:uuid/uuid.dart';
import 'dependency_injection/injection.dart';
import 'domain_layer/entities/user.dart';
import 'domain_layer/repository_interfaces/IUserRepository.dart';
import 'domain_layer/value_objects/bill/bill_discount.dart';
import 'domain_layer/value_objects/bill/bill_extra_fees.dart';
import 'domain_layer/value_objects/bill/bill_name.dart';
import 'domain_layer/value_objects/bill/bill_tax.dart';
import 'domain_layer/value_objects/item/item_name.dart';
import 'domain_layer/value_objects/user/user_email.dart';
import 'domain_layer/value_objects/user/user_first_name.dart';
import 'domain_layer/value_objects/user/user_last_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();

  User user1 = User(
      userID: const Uuid().v1(),
      firstName: FirstName.create('Benjamin'),
      lastName: LastName.create('Sisko'),
      email: Email.create('abc123@gmail.com'));
  UserController controller = UserController(userService: getIt<UserService>());
  await controller.addUser(user1);

  User user2 = User(
      userID: const Uuid().v1(),
      firstName: FirstName.create('Julian'),
      lastName: LastName.create('Bashir'),
      email: Email.create('xyz987@gmail.com'));
  await controller.addUser(user2);

  Bill bill1 = Bill(
      billID: const Uuid().v1(),
      billName: BillName.create('bill1'),
      billType: BillType.create('\u{1F39E}  ' 'Entertainment'),
      date: BillDate.create('2022-01-02'),
      extraFees: ExtraFees.create(tip: 5.0),
      discount: Discount.create(),
      tax: Tax.create(tax: 7.0),
      items: {},
      users: [],
      splitEqually: false);
  BillController billController =
      BillController(billService: getIt<BillService>());
  await billController.addBill(bill1);

  Item item1 = Item(
      itemID: const Uuid().v1(),
      itemName: ItemName.create('ruh roh spaghettio'),
      price: 9.99,
      userID: user1.userID,
      billID: bill1.billID);
  ItemController itemController =
      ItemController(itemService: getIt<ItemService>());
  itemController.addItem(item1);

  BillItemController billItemController =
      BillItemController(billService: getIt<BillService>());
  billItemController.addItemToBill(bill1, item1.itemID, 1);

  List<User> users = [];
  users =
      await UserService(userRepository: getIt<IUserRepository>()).getAllUsers();
  bool userExists = users.isEmpty ? false : true;

  return runZonedGuarded(() async {
    runApp(MyApp(userExists: userExists));
  }, (error, stack) {
    if (kDebugMode) {
      print(stack);
      print(error);
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.userExists}) : super(key: key);

  final bool userExists;

  @override
  Widget build(BuildContext context) {
    return userExists == true
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Split the bill',
            home: HomeScreen(billController: getIt<BillController>()),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'New user screen',
            home: NewUserScreen(
                entityFactory: getIt<IEntityFactory>(),
                userController: getIt<UserController>()),
          );
  }
}
