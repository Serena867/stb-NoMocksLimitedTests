import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../dependency_injection/injection.dart';
import '../../../domain_layer/entities/bill.dart';
import '../../../domain_layer/entities/item.dart';
import '../../../domain_layer/entities/user.dart';
import '../../../domain_layer/factories/IEntityFactory.dart';
import '../../controllers/bill/bill_controller.dart';
import '../../controllers/item/item_controller.dart';
import '../../controllers/user/user_controller.dart';
import '../dialogs/add_item_dialog.dart';
import '../dialogs/user_selection_dialog.dart';
import '../widgets/home_app_bar.dart';

//TODO: This page is currently just a duplicate of split unequally page. Adjust.

class SplitTheBillEquallyScreen extends StatefulWidget {
  const SplitTheBillEquallyScreen({Key? key, required this.billInputID}) : super(key: key);

  final String billInputID;

  @override
  State<SplitTheBillEquallyScreen> createState() =>
      _SplitTheBillEquallyScreenState();
}

class _SplitTheBillEquallyScreenState extends State<SplitTheBillEquallyScreen> {
  double billSubtotal = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context, true, null),
      body: _BuildBody(
          billID: widget.billInputID,
          billController: getIt<BillController>(),
          itemController: getIt<ItemController>(),
          userController: getIt<UserController>()),
    );
  }
}

class _BuildBody extends StatefulWidget {
  const _BuildBody(
      {required this.billID,
        required this.billController,
        required this.itemController,
        required this.userController});

  final String billID;
  final BillController billController;
  final ItemController itemController;
  final UserController userController;

  @override
  State<_BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<_BuildBody> {
  Bill? _currentBill;
  List<User> _users = [];
  List<User> _selectedUsers = [];
  List<Item> _items = [];
  double billSubtotal = 0;
  double total = 0;


  final AsyncMemoizer _billMemoizer = AsyncMemoizer();
  final AsyncMemoizer _userListMemoizer = AsyncMemoizer();
  final AsyncMemoizer _itemMemoizer = AsyncMemoizer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        widget.billController.memoizeGetBillById(_billMemoizer, widget.billID),
        widget.itemController.memoizeGetAllItemsByBillId(_itemMemoizer, widget.billID),
        widget.userController.memoizeGetAllUsers(_userListMemoizer)
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          _currentBill = snapshot.data![0];
          _items = snapshot.data![1];
          _users = snapshot.data![2];
          _selectedUsers = _currentBill!.users;
          return Column(
            children: [
              Container(height: 10),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  _currentBill != null
                      ? '${_currentBill!.billType.billType.substring(
                      0, _currentBill!.billType.billType.indexOf(' '))} ${_currentBill!.billName.billName}'
                      : "ERROR PROCESSING DATA",
                  style: TextStyle(fontSize: Get.width * 0.085),
                ),
              ),
              Container(height: 15),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return UserSelectionDialog(
                            billInputID: widget.billID, billController: getIt<BillController>(), userController: getIt<UserController>(),);
                        });
                  },
                  child: Text(
                    'Add friend to bill',
                    style: TextStyle(fontSize: Get.width * 0.050),
                  )),
              Container(height: 10),
              Expanded(
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
                                itemCount: _items.length,
                                itemBuilder: (context, index2) {
                                  return Padding(
                                      padding: const EdgeInsets.only(),
                                      child: _selectedUsers[index].userID ==
                                          _items[index2].userID
                                          ? Card(
                                        elevation: 0,
                                        child: ListTile(
                                          title: Text(
                                              'Item: ${_items[index2].itemName
                                                  .itemName}',
                                              style: TextStyle(
                                                  fontSize:
                                                  Get.width * 0.042,
                                                  fontWeight:
                                                  FontWeight.w600)),
                                          subtitle: Text(
                                              'Price: \$${_items[index2].price}',
                                              style: TextStyle(
                                                  fontSize:
                                                  Get.width * 0.042,
                                                  fontWeight:
                                                  FontWeight.w600)),
                                          contentPadding:
                                          const EdgeInsets.only(
                                              top: 2, bottom: 0),
                                          visualDensity:
                                          const VisualDensity(
                                              vertical: -4),
                                          trailing: IconButton(
                                            onPressed: () {},
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
                                SizedBox(
                                  width: 95,
                                  height: 35,
                                  child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return AddItemDialog(
                                                itemController:
                                                getIt<ItemController>(),
                                                userController:
                                                getIt<UserController>(),
                                                entityFactory: getIt<IEntityFactory>(),
                                                userInputID: _users[index].userID,
                                                billInputID:
                                                _currentBill!.billID); //TODO: Fix null values
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
                                ),
                                IconButton(
                                  padding: const EdgeInsets.all(0),
                                  visualDensity: const VisualDensity(vertical: -4),
                                  alignment: Alignment.topCenter,
                                  onPressed: () async {
                                    _currentBill!.users.removeAt(index);
                                    await widget.billController.updateBill(_currentBill!);
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
              ),
              Container(height: 18),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _currentBill != null
                      ? 'Subtotal:  $billSubtotal'
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
                      ? 'Tip:  ${_currentBill!.extraFees.dollarValue}'
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
                      ? 'Tax:  ${_currentBill!.tax}%'
                      : "ERROR PROCESSING DATA",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: Get.width * 0.055),
                ),
              ),
              Container(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _currentBill != null
                      ? 'Total:  ${((billSubtotal * (1 + (_currentBill!.tax.tax / 100))) + _currentBill!.extraFees.dollarValue).toStringAsFixed(2)}'
                      : "ERROR PROCESSING DATA",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: Get.width * 0.055),
                ),
              ),
              Container(height: 15),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
