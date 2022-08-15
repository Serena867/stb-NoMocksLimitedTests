import 'package:flutter/material.dart';
import 'package:split_the_bill/domain_layer/factories/IEntityFactory.dart';
import 'package:split_the_bill/domain_layer/value_objects/user/user_last_name.dart';
import 'package:split_the_bill/presentation_layer/controllers/bill/bill_controller.dart';
import 'package:split_the_bill/presentation_layer/controllers/user/user_controller.dart';
import 'package:split_the_bill/presentation_layer/user_interface/constants.dart';
import 'package:uuid/uuid.dart';
import '../../../dependency_injection/injection.dart';
import '../../../domain_layer/entities/user.dart';
import '../../../domain_layer/value_objects/user/user_email.dart';
import '../../../domain_layer/value_objects/user/user_first_name.dart';
import '../../paint/borders.dart';
import 'home_screen.dart';

class NewUserScreen extends StatefulWidget {
  const NewUserScreen({Key? key, required this.entityFactory, required this.userController})
      : super(key: key);

  final IEntityFactory entityFactory;
  final UserController userController;

  @override
  State<NewUserScreen> createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  final _userFirstNameController = TextEditingController();
  final _userLastNameController = TextEditingController();
  final _userEmailController = TextEditingController();
  bool _firstNameIsValid = true;

  void initstate() async {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.STB_BLUE,
      extendBodyBehindAppBar: true,
      //appBar: appBar(context, false),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 0),
      child: Column(
        children: [
          Container(
            height: 35,
          ),
          const Text(
            'Split the bill',
            style: TextStyle(
                color: Colors.white,
                fontSize: 45,
                fontFamily: 'OoohBaby',
                fontWeight: FontWeight.bold),
          ),
          Container(height: 35),
          const Text(
            'Please start by filling out the following fields',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Container(height: 45),
          _firstNameTextField(),
          Container(height: 20),
          _lastNameTextField(),
          Container(height: 20),
          _emailTextField(),
          Container(height: 20),
          ElevatedButton(
            onPressed: () async {
              _createUser();
            },
            child: const Text(
              'Create user',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          Container(
            height: 70,
          ),
          const Text(
            'Unlike a lot of other apps we don\'t want you to sign up for anything,'
                ' we don\'t want access to your data or contacts, and you won\'t receive emails'
                ' from us. It\'s that simple.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }

  _firstNameTextField() {
    return TextField(
      controller: _userFirstNameController,
      style: const TextStyle(color: Colors.lightBlueAccent),
      maxLength: 40,
      decoration: InputDecoration(
        counterStyle: const TextStyle(color: Colors.white),
        labelText: 'Please enter your first name',
        labelStyle: const TextStyle(
            color: Colors.lightBlueAccent, fontSize: 18),
        hintText: 'Type your first name here',
        hintStyle: const TextStyle(color: Colors.lightBlueAccent),
        errorText: _firstNameIsValid ? null : 'First name can\'t be empty',
        errorStyle: const TextStyle(fontSize: 18, color: Colors.redAccent),
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.lightBlueAccent,
        ),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: focusBorder,
        errorBorder: errorBorder,
      ),
    );
  }

  _lastNameTextField() {
    return TextField(
      controller: _userLastNameController,
      style: const TextStyle(color: Colors.lightBlueAccent),
      maxLength: 40,
      decoration: InputDecoration(
        counterStyle: const TextStyle(color: Colors.white),
        labelText: 'Please enter your last name',
        labelStyle: const TextStyle(
            color: Colors.lightBlueAccent, fontSize: 18),
        hintText: 'Type your last name here',
        hintStyle: const TextStyle(color: Colors.lightBlueAccent),
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.lightBlueAccent,
        ),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: focusBorder,
      ),
    );
  }

  //TODO: Add regex parameters for validation
  _emailTextField() {
    return TextField(
      controller: _userEmailController,
      style: const TextStyle(color: Colors.lightBlueAccent),
      maxLength: 40,
      decoration: InputDecoration(
        counterStyle: const TextStyle(color: Colors.white),
        labelText: 'Please enter your email',
        labelStyle: const TextStyle(
            color: Colors.lightBlueAccent, fontSize: 18),
        hintText: 'Type your email here',
        hintStyle: const TextStyle(color: Colors.lightBlueAccent),
        prefixIcon: const Icon(
          Icons.mail,
          color: Colors.lightBlueAccent,
        ),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: focusBorder,
      ),
    );
  }

  _createUser() async {
    setState(() {
      _userFirstNameController.text.isEmpty
          ? _firstNameIsValid = false
          : _firstNameIsValid = true;
    });

    User user = widget.entityFactory.newUser(userID: const Uuid().v1(),
        firstName: FirstName.create(_userFirstNameController.text),
        lastName: LastName.create(_userLastNameController.text),
        email: Email.create(_userEmailController.text));
    if (_firstNameIsValid == true) {
      var result = await widget.userController.addUser(user);
      if (result > 0) {
        _showSuccessfulUserCreation();
        Navigator.of(context) //TODO: Adjust MaterialPageRoute so this isn't at the bottom of the nav stack on initial user creation
            .push(MaterialPageRoute(builder: (context) =>
            HomeScreen(billController: getIt<BillController>(),)));
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
