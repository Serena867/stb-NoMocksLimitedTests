import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:split_the_bill/presentation_layer/user_interface/screens/split_the_bill_unequally_screen.dart';

import '../../../dependency_injection/injection.dart';
import '../../../domain_layer/entities/bill.dart';
import '../../controllers/bill/bill_controller.dart';
import '../dialogs/delete_bill_dialog.dart';


class IndividualBillLayout extends StatefulWidget {
  const IndividualBillLayout({Key? key, required this.billController}) : super(key: key);

  final BillController billController;

  @override
  State<IndividualBillLayout> createState() => _IndividualBillLayoutState();
}

class _IndividualBillLayoutState extends State<IndividualBillLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 400) {
        return WideLayout(billController: widget.billController);
      } else {
        return NarrowLayout(
          billController: widget.billController,
        );
      }
    },);
  }
}

class WideLayout extends StatefulWidget {
  const WideLayout({Key? key, required this.billController}) : super(key: key);

  final BillController billController;

  @override
  State<WideLayout> createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  List<Bill> _bills = [];
  final AsyncMemoizer _billMemoizer = AsyncMemoizer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: widget.billController.memoizeGetAllBills(_billMemoizer),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          _bills = snapshot.data;
          return Center(
            child: ListView.builder(
              itemCount: _bills.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
                  child: Card(
                    elevation: 8,
                    child: ListTile(
                      onTap: () => Navigator.of(context)
                          .push(MaterialPageRoute(
                          builder: (context) =>
                              SplitTheBillUnequallyScreen(
                                  billInputID: _bills[index].billID)))
                          .then((value) => setState(() {})),
                      leading: Text(
                        _bills[index].billType.billType.substring(
                            0, _bills[index].billType.billType.indexOf(' ')),
                        style: TextStyle(fontSize: Get.width * 0.045),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              _bills[index].billName.billName.toString(),
                              style: TextStyle(fontSize: Get.width * 0.0375),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        'Date: ${_bills[index].date.billDate}',
                        style: TextStyle(fontSize: Get.width * 0.018),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class NarrowLayout extends StatefulWidget {
  const NarrowLayout({Key? key, required this.billController})
      : super(key: key);

  final BillController billController;

  @override
  State<NarrowLayout> createState() => _NarrowLayoutState();
}

class _NarrowLayoutState extends State<NarrowLayout> {
  late Future<List<Bill>> _bills;

  @override
  void initState() {
    super.initState();
    _bills = widget.billController.getAllBills();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _bills,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasData) {
            return Center(
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
                    child: Card(
                      elevation: 8,
                      child: ListTile(
                        onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(
                            builder: (context) =>
                                SplitTheBillUnequallyScreen(
                                    billInputID: snapshot.data[index].billID)))
                            .then((value) => setState(() {})),
                        leading: Text(
                          snapshot.data[index].billType.billType.substring(
                              0, snapshot.data[index].billType.billType.indexOf(' ')),
                          style: TextStyle(fontSize: Get.width * 0.045),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                snapshot.data[index].billName.billName.toString(),
                                style: TextStyle(fontSize: Get.width * 0.0375),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          'Date: ${snapshot.data[index].date}',
                          style: TextStyle(fontSize: Get.width * 0.028),
                        ),
                        trailing: IconButton(
                            splashColor: Colors.red,
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return DeleteBillDialog(
                                      billID: snapshot.data[index].billID,
                                      billController: getIt<BillController>(),
                                    );
                                  });
                            }),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        }
      },
    );
  }
}