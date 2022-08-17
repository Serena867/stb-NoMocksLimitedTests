import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation_layer/controllers/user/user_controller.dart';
import '../screens/users_screen.dart';

class DeleteUserDialog extends StatefulWidget {
  const DeleteUserDialog({Key? key, required this.userID, required this.userController}) : super(key: key);

  final String userID;
  final UserController userController;

  @override
  State<DeleteUserDialog> createState() => _DeleteUserDialogState();
}

class _DeleteUserDialogState extends State<DeleteUserDialog> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF08d108), primary: Colors.white),
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Colors.red, primary: Colors.white),
          onPressed: () async {
            await widget.userController.deleteUser(widget.userID);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => UsersScreen(userController: widget.userController,)));
            setState(() {
              //_getUsers();
            });
            //_showSuccessfulDelete();
          },
          child: const Text('Delete'),
        ),
      ],
      title: const Text('Are you sure you want to delete this?'),
    );
  }
}
