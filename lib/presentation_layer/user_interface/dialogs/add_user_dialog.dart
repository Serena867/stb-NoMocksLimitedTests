import 'package:flutter/material.dart';
import 'package:split_the_bill/domain_layer/factories/IEntityFactory.dart';
import 'package:split_the_bill/domain_layer/value_objects/user/user_email.dart';
import 'package:split_the_bill/domain_layer/value_objects/user/user_first_name.dart';
import 'package:split_the_bill/presentation_layer/controllers/user/user_controller.dart';
import 'package:uuid/uuid.dart';
import '../../../domain_layer/entities/user.dart';
import '../../../domain_layer/value_objects/user/user_last_name.dart';
import '../../paint/borders.dart';
import '../screens/users_screen.dart';

class AddUserDialog extends StatefulWidget {
  const AddUserDialog(
      {Key? key, required this.userController, required this.entityFactory})
      : super(key: key);

  final UserController userController;
  final IEntityFactory entityFactory;

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final _userFirstNameController = TextEditingController();
  final _userLastNameController = TextEditingController();
  final _userEmailController = TextEditingController();

  bool _firstNameIsValid = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      backgroundColor: const Color(0xFF6EC6CA), //TODO: Update this colour
      actions: <Widget>[
        TextField(
          controller: _userFirstNameController,
          style: const TextStyle(color: Colors.black),
          maxLength: 30,
          decoration: InputDecoration(
            labelText: 'Please enter a name',
            labelStyle: const TextStyle(color: Colors.black, fontSize: 18),
            hintText: 'Type first name here',
            hintStyle: const TextStyle(color: Colors.black),
            errorText: _firstNameIsValid ? null : 'First name can\'t be empty',
            errorStyle: const TextStyle(fontSize: 18, color: Colors.redAccent),
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
          controller: _userLastNameController,
          style: const TextStyle(color: Colors.black),
          maxLength: 40,
          decoration: InputDecoration(
            labelText: 'Please enter a last name',
            labelStyle: const TextStyle(color: Colors.black, fontSize: 18),
            hintText: 'Type last name here',
            hintStyle: const TextStyle(color: Colors.black),
            prefixIcon: const Icon(
              Icons.person,
              color: Colors.black,
            ),
            border: inputBorder,
            enabledBorder: inputBorder,
            focusedBorder: focusBorder,
          ),
        ),
        Container(
          height: 10,
        ),
        TextField(
          controller: _userEmailController,
          style: const TextStyle(color: Colors.black),
          maxLength: 40,
          decoration: InputDecoration(
            labelText: 'Please enter a  valid email',
            labelStyle: const TextStyle(color: Colors.black, fontSize: 18),
            hintText: 'Type email here',
            hintStyle: const TextStyle(color: Colors.black),
            prefixIcon: const Icon(
              Icons.mail,
              color: Colors.black,
            ),
            border: inputBorder,
            enabledBorder: inputBorder,
            focusedBorder: focusBorder,
          ),
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
                addUser();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ],
      title: const Text(
        'Add new person or group',
        textAlign: TextAlign.center,
      ),
    );
  }

  addUser() async {
    setState(() {
      _userFirstNameController.text.isEmpty
          ? _firstNameIsValid = false
          : _firstNameIsValid = true;
    });

    String newUuid = const Uuid().v1();

    User user = widget.entityFactory.newUser(
        userID: newUuid,
        firstName: FirstName.create(_userFirstNameController.text),
        lastName: LastName.create(_userLastNameController.text),
        email: Email.create(_userEmailController.text));

    if (_firstNameIsValid == true) {
      var result = await widget.userController.addUser(user);
      if (result > 0) {
        _showSuccessfulUserCreation();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const UsersScreen()));
      }
    } else {
      _showFailedUserCreation();
    }
  }

  _showSuccessfulUserCreation() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text('User successfully created', textAlign: TextAlign.center)));
  }

  _showFailedUserCreation() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('New entry failed', textAlign: TextAlign.center)));
  }
}
