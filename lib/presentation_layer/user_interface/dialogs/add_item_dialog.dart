import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:split_the_bill/domain_layer/factories/IEntityFactory.dart';
import 'package:split_the_bill/domain_layer/value_objects/item/item_name.dart';
import 'package:split_the_bill/presentation_layer/controllers/item/item_controller.dart';
import 'package:split_the_bill/presentation_layer/controllers/user/user_controller.dart';
import 'package:uuid/uuid.dart';
import '../../../domain_layer/entities/item.dart';
import '../../../domain_layer/entities/user.dart';
import '../../paint/borders.dart';
import '../screens/split_the_bill_unequally_screen.dart';

//TODO: The entirety of the split equally pages and functionally needs to be redone.

class AddItemDialog extends StatefulWidget {
  const AddItemDialog(
      {Key? key,
      required this.userInputID,
      required this.billInputID,
      required this.entityFactory,
      required this.itemController,
      required this.userController})
      : super(key: key);

  final IEntityFactory entityFactory;
  final ItemController itemController;
  final UserController userController;
  final String billInputID;
  final String userInputID;

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final _itemNameController = TextEditingController();
  final _itemPriceController = TextEditingController();
  late Future<User> _user;
  bool _itemNameIsValid = true;

  @override
  void initState() {
    super.initState();
    _user = widget.userController.getUserById(widget.userInputID);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          _user,
        ]),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22)),
              backgroundColor: const Color(0xFF6EC6CA),
              //TODO: Update this colour
              actions: <Widget>[
                TextField(
                  controller: _itemNameController,
                  style: const TextStyle(color: Colors.black),
                  maxLength: 50,
                  decoration: InputDecoration(
                    labelText: 'Please enter a name',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 18),
                    hintText: 'Type item name here',
                    hintStyle: const TextStyle(color: Colors.black),
                    errorText:
                        _itemNameIsValid ? null : 'Item name can\'t be empty',
                    errorStyle:
                        const TextStyle(fontSize: 18, color: Colors.redAccent),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    border: inputBorder,
                    enabledBorder: inputBorder,
                    focusedBorder: focusBorder,
                    errorBorder: errorBorder,
                  ),
                ),
                Container(
                  height: 10,
                ),
                TextField(
                  controller: _itemPriceController,
                  style: const TextStyle(color: Colors.black),
                  maxLength: 40,
                  decoration: InputDecoration(
                    labelText: 'Item price',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 18),
                    hintText: 'Enter item price',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: inputBorder,
                    enabledBorder: inputBorder,
                    focusedBorder: focusBorder,
                    prefixIcon: const Icon(
                      Icons.monetization_on,
                      color: Colors.black,
                    ),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.red, primary: Colors.white),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF08d108),
                          primary: Colors.white),
                      onPressed: () async {
                        addItem();
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
              title: const Text(
                'Add new item',
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  addItem() async {
    setState(() {
      _itemNameController.text.isEmpty
          ? _itemNameIsValid = false
          : _itemNameIsValid = true;
    });

    Item item = widget.entityFactory.newItem(
        itemID: const Uuid().v1(),//ItemID.create(const Uuid().v1()),
        itemName: ItemName.create(_itemNameController.text),
        price: double.parse(_itemPriceController.text),
        userID: widget.userInputID,
        billID: widget.billInputID);
    if (_itemNameIsValid == true) {
      var firstResult = await widget.itemController.addItem(item);
      if (firstResult > 0) {
        _showSuccessfulItemCreation();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SplitTheBillUnequallyScreen(
                  billInputID: widget.billInputID,
                )));
      }
    } else {
      _showFailedItemCreation();
    }
  }

  _showSuccessfulItemCreation() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text('Successfully added new item', textAlign: TextAlign.center)));
  }

  _showFailedItemCreation() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Item creation failed', textAlign: TextAlign.center)));
  }
}
