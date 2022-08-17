import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation_layer/controllers/groups/group_controller.dart';
import 'package:split_the_bill/presentation_layer/user_interface/screens/test_home_screen.dart';

class DeleteGroupDialog extends StatefulWidget {
  const DeleteGroupDialog(
      {Key? key, required this.groupID, required this.groupController})
      : super(key: key);

  final String groupID;
  final GroupController groupController;

  @override
  State<DeleteGroupDialog> createState() => _DeleteGroupDialogState();
}

class _DeleteGroupDialogState extends State<DeleteGroupDialog> {
  @override
  void initState() {
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
            await widget.groupController.deleteGroup(widget.groupID);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const TestHomeScreen(screenIndex: 0, tabIndex: 1,)));
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
