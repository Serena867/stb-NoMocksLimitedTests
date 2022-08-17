import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:split_the_bill/dependency_injection/injection.dart';
import 'package:split_the_bill/domain_layer/factories/IEntityFactory.dart';
import 'package:split_the_bill/presentation_layer/controllers/bill/bill_controller.dart';
import 'package:split_the_bill/presentation_layer/controllers/bill/bill_item_controller.dart';
import 'package:split_the_bill/presentation_layer/controllers/item/item_controller.dart';
import 'package:split_the_bill/presentation_layer/controllers/user/user_controller.dart';
import '../../../domain_layer/entities/bill.dart';
import '../../../domain_layer/entities/item.dart';
import '../../../domain_layer/entities/user.dart';
import '../dialogs/add_item_dialog.dart';
import '../dialogs/user_selection_dialog.dart';
import '../widgets/general_app_bar.dart';
import '../widgets/home_app_bar.dart';

//TODO: Completely rebuild the way this is displayed as it looks horrible

class SplitTheBillUnequallyScreen extends StatefulWidget {
  const SplitTheBillUnequallyScreen({Key? key, required this.billInputID})
      : super(key: key);
  final String billInputID;

  @override
  State<SplitTheBillUnequallyScreen> createState() =>
      _SplitTheBillUnequallyScreenState();
}

class _SplitTheBillUnequallyScreenState
    extends State<SplitTheBillUnequallyScreen> {
  double billSubtotal = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generalAppBar(context, jumpToHome: true),
      body: _BuildBody(
          billID: widget.billInputID,
          billController: getIt<BillController>(),
          itemController: getIt<ItemController>(),
          userController: getIt<UserController>(),
          billItemController: getIt<BillItemController>()),
    );
  }
}

class _BuildBody extends StatefulWidget {
  const _BuildBody(
      {required this.billID,
      required this.billController,
      required this.itemController,
      required this.userController,
      required this.billItemController});

  final String billID;
  final BillController billController;
  final ItemController itemController;
  final UserController userController;
  final BillItemController billItemController;

  @override
  State<_BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<_BuildBody> {
  late Future<Bill> _currentBill;
  late Future<List<Item>> _items;
  late Future<List<User>> _users;
  List<User> _selectedUsers = [];
  late Future<List<double>> _billTotals;
  double total = 0;

  @override
  void initState() {
    super.initState();
    _currentBill = widget.billController.getBillById(widget.billID);
    _items = widget.itemController.getAllItemsByBillId(widget.billID);
    _users = widget.userController.getAllUsers();
    _billTotals = widget.billController.calculateBillTotals(widget.billID);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        _currentBill,
        _items,
        _users,
        _billTotals,
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          _selectedUsers = snapshot.data![0].users;
          return Column(
            children: [
              Container(height: 10),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  _currentBill != null
                      ? '${snapshot.data![0].billType.billType.substring(0, snapshot.data![0].billType.billType.indexOf(' '))} ${snapshot.data![0].billName.billName}'
                      : "ERROR PROCESSING DATA",
                  style: TextStyle(fontSize: Get.width * 0.085),
                ),
              ),
              Container(height: 15),
              _userSelectionButton(context),
              Container(height: 10),
              _displayUserData(snapshot.data![0], snapshot.data![1], snapshot.data![2]),
              _displayBillValues(snapshot.data![0], snapshot.data![3]),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

 Widget _userSelectionButton(BuildContext context){
  return ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return UserSelectionDialog(
                  billInputID: widget.billID,
                  billController: getIt<BillController>(),
                  userController: getIt<UserController>(),
                );
              });
        },
        child: Text(
          'Add friend to bill',
          style: TextStyle(fontSize: Get.width * 0.050),
        ));
  }

  Widget _displayUserData(Bill currentBill, List<Item> items, List<User> users){
    return Expanded(
      child: ListView.builder(
        primary: true,
        shrinkWrap: true,
        itemCount: _selectedUsers != null ? _selectedUsers.length : 0,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(),
            child: Card(
              elevation: 0,
              child: ListTile(
                subtitle: Column(
                  children: [
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index2) {
                        return Padding(
                            padding: const EdgeInsets.only(),
                            child: _selectedUsers[index].userID ==
                                items[index2].userID
                                ? Card(
                              elevation: 0,
                              child: ListTile(
                                title: Text(
                                    'Item: ${items[index2].itemName.itemName}',
                                    style: TextStyle(
                                        fontSize:
                                        Get.width * 0.048,
                                        fontWeight:
                                        FontWeight.w600)),
                                subtitle: Text(
                                    'Price: \$${items[index2].price}',
                                    style: TextStyle(
                                        fontSize:
                                        Get.width * 0.048,
                                        fontWeight:
                                        FontWeight.w600)),
                                contentPadding:
                                const EdgeInsets.only(
                                    top: 2, bottom: 0),
                                visualDensity:
                                const VisualDensity(
                                    vertical: -4),
                                trailing: IconButton(
                                  onPressed: () async {
                                    _deleteItem(index, currentBill, items);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            )
                                : null);
                      },
                    ),
                  ],
                ),
                title: Ink(
                  padding: const EdgeInsets.only(
                      top: 4, left: 8, right: 8, bottom: 4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius:
                    BorderRadius.all(Radius.circular(15)),
                    gradient: LinearGradient(colors: [
                      Color(0xFF29dde3),
                      Color(0xFF6EC6CA)
                    ]),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          _selectedUsers.isNotEmpty
                              ? '${_selectedUsers[index].firstName.firstName} ${_selectedUsers[index].lastName.lastName}'
                              : 'Please enter a user',
                          style:
                          TextStyle(fontSize: Get.width * 0.055),
                        ),
                      ),
                      Container(width: Get.width * 0.4),
                      TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AddItemDialog(
                                    itemController:
                                    getIt<ItemController>(),
                                    userController:
                                    getIt<UserController>(),
                                    entityFactory:
                                    getIt<IEntityFactory>(),
                                    userInputID:
                                    users[index].userID,
                                    billInputID: currentBill
                                        .billID);
                              });
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                            primary: Colors.white),
                        child: Text(
                          'Add item',
                          style: TextStyle(
                              fontSize: Get.width * 0.045,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        visualDensity:
                        const VisualDensity(vertical: -4),
                        alignment: Alignment.topCenter,
                        onPressed: () async {
                          currentBill.users.removeAt(index);
                          await widget.billController
                              .updateBill(currentBill);
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.remove_circle_rounded,
                          color: Colors.red,
                          size: 34,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _displayBillValues(Bill currentBill, List<double> billTotals) {
    return Column(
      children: [
      Container(height: 18),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          _currentBill != null
              ? 'Subtotal: \$' + billTotals[0].toStringAsFixed(2)
              : "ERROR PROCESSING DATA",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: Get.width * 0.055),
        ),
      ),
      Container(height: 10),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          _currentBill != null
              ? 'Tip: \$${currentBill.extraFees.tip.toStringAsFixed(2)}'
              : "ERROR PROCESSING DATA",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: Get.width * 0.055),
        ),
      ),
      Container(height: 10),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          currentBill != null
              ? 'Tax:  ${currentBill.tax.tax}%'
              : "ERROR PROCESSING DATA",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: Get.width * 0.055),
        ),
      ),
      Container(height: 20),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          currentBill != null
              ?  'Total: \$${billTotals[1].toStringAsFixed(2)}'       //'Total:  ${((billSubtotal * (1 + (_currentBill.tax.tax / 100))) + _currentBill.extraFees.dollarValue).toStringAsFixed(2)}'
              : "ERROR PROCESSING DATA",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: Get.width * 0.055),
        ),
      ),
      Container(height: 15),
    ],);
  }

  _deleteItem(int index, Bill currentBill, List<Item> items) async {
    await widget.billItemController
        .deleteItemFromBill(currentBill, items[index].itemID);
    await widget.itemController.deleteItem(items[index]);
    setState(() {
      items.removeAt(index);
      //initState();
    });
  }
}
