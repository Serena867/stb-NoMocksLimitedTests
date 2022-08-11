import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation_layer/controllers/user/user_controller.dart';
import '../../../domain_layer/entities/bill.dart';
import '../../../domain_layer/entities/user.dart';
import '../../controllers/bill/bill_controller.dart';
import '../screens/split_the_bill_equally_screen.dart';
import '../screens/split_the_bill_unequally_screen.dart';

class UserSelectionDialog extends StatefulWidget {
  const UserSelectionDialog({Key? key, required this.billInputID, required this.billController, required this.userController}) : super(key: key);

  final String billInputID;
  final BillController billController;
  final UserController userController;

  @override
  State<UserSelectionDialog> createState() => _UserSelectionDialogState();
}

class _UserSelectionDialogState extends State<UserSelectionDialog> {
  late Future<Bill> _currentBill;
  late Future<List<User>> _users;
  User? _selectedUser;
  User? _userChoice;
  int numberOfUsersOnBill = 0;

  @override
  void initState() {
    super.initState();
    _currentBill = widget.billController.getBillById(widget.billInputID);
    _users = widget.userController.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        _currentBill,
        _users,
      ]),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          //snapshot.data[1].removeWhere((element) => snapshot.data[0].users.contains(element)); //TODO: Broken (Convert all of this to StreamBuilder)
          numberOfUsersOnBill = snapshot.data![1].length;
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            actions: <Widget>[
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Select friend',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(padding: const EdgeInsets.all(12), child: _buildDropDownMenu(snapshot.data![1])),
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
                        backgroundColor: Colors.green, primary: Colors.white),
                    onPressed: () async {
                      _selectUser(snapshot.data![0], snapshot.data![1]);
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  _selectUser(Bill currentBill, List<User> users) async {
    currentBill.users.add(_userChoice!);
    var result = await widget.billController.updateBill(currentBill);
    if (result > 0) {
      users.length--;
      currentBill.splitEqually == false
          ? Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => SplitTheBillUnequallyScreen(
                      billInputID: currentBill.billID)))
              .then((value) => setState(() {
                    //_getCurrentBillData();
                  }))
          : Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => SplitTheBillEquallyScreen(
                      billInputID: currentBill.billID)))
              .then((value) => setState(() {
                    //_getCurrentBillData();
                  }));
    } else {
      print(
          'EDIT FAILURE IN USER SELECTION DIALOG'); //TODO: Change to snackbar after testing (unit/manual)
    }
  }

  _buildDropDownMenu(List<User> users) {
    return (DropdownButtonFormField<dynamic>(
      value: _userChoice,
      validator: (value) => value == null ? 'Type is required' : null,
      items: users
          .map((range) => DropdownMenuItem(
                value: range,
                child: Text(
                  '${range.firstName.firstName} ${range.lastName.lastName}',
                  style: const TextStyle(fontSize: 20),
                ),
              ))
          .toList(),
      onChanged: (value) {
        _selectedUser = value;
        setState(() {
          _userChoice = value;
        });
      },
    ));
  }
}
