import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation_layer/controllers/bill/bill_controller.dart';
import 'package:split_the_bill/presentation_layer/user_interface/screens/home_screen.dart';
import '../../../dependency_injection/injection.dart';

class DeleteBillDialog extends StatefulWidget {
  const DeleteBillDialog({Key? key, required this.billID, required this.billController}) : super(key: key);

  final String billID;
  final BillController billController;

  @override
  State<DeleteBillDialog> createState() => _DeleteBillDialogState();
}

class _DeleteBillDialogState extends State<DeleteBillDialog> {

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
            await widget.billController.deleteBill(widget.billID);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen(billController: getIt<BillController>())));
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
