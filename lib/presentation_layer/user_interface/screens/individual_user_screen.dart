import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:split_the_bill/presentation_layer/controllers/user/user_controller.dart';
import 'package:split_the_bill/presentation_layer/user_interface/screens/split_the_bill_unequally_screen.dart';
import 'package:split_the_bill/presentation_layer/user_interface/widgets/bottom_app_bar.dart';
import 'package:split_the_bill/presentation_layer/user_interface/widgets/users_app_bar.dart';
import '../../../dependency_injection/injection.dart';
import '../../../domain_layer/entities/bill.dart';
import '../../../domain_layer/entities/user.dart';
import '../../controllers/bill/bill_user_controller.dart';

class IndividualUserScreen extends StatefulWidget {
  const IndividualUserScreen({Key? key, required this.inputUser})
      : super(key: key);

  final User inputUser;

  @override
  State<IndividualUserScreen> createState() => _IndividualUserScreenState();
}

class _IndividualUserScreenState extends State<IndividualUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userAppBar(context, true),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 400) {
          return WideLayout(
              inputUser: widget.inputUser,
              userController: getIt<UserController>(),
              billUserController: getIt<BillUserController>());
        } else {
          return NarrowLayout(
              inputUser: widget.inputUser,
              userController: getIt<UserController>(),
              billUserController: getIt<BillUserController>());
        }
      }),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class WideLayout extends StatefulWidget {
  const WideLayout(
      {Key? key,
      required this.userController,
      required this.inputUser,
      required this.billUserController})
      : super(key: key);

  final UserController userController;
  final BillUserController billUserController;
  final User inputUser;

  @override
  State<WideLayout> createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  late Future<User> _currentUser;
  late Future<List<Bill>> _allBillsWithUser;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.userController.getUserById(widget.inputUser.userID);
    _allBillsWithUser =
        widget.billUserController.getAllBillsWithUser(widget.inputUser);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        _currentUser,
        _allBillsWithUser,
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          _currentUser = snapshot.data![0];
          return Column(
            children: [
              Container(height: 10),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  '',
                  style: TextStyle(fontSize: Get.width * 0.085),
                ),
              ),
              Center(
                child: ListView.builder(
                  itemCount: snapshot.data![1].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Card(
                        elevation: 8,
                        child: ListTile(
                          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) =>
                                      SplitTheBillUnequallyScreen(
                                          billInputID:
                                              snapshot.data![1][index].billID)))
                              .then((value) => setState(() {})),
                          leading: Text(
                            snapshot.data![1][index].billType.billType
                                .substring(
                                    0,
                                    snapshot.data![1][index].billType.billType
                                        .indexOf(' ')),
                            style: TextStyle(fontSize: Get.width * 0.045),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  snapshot.data![1][index].billName.billName
                                      .toString(),
                                  style:
                                      TextStyle(fontSize: Get.width * 0.0375),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            'Date: ${snapshot.data![1][index].date.billDate}',
                            style: TextStyle(fontSize: Get.width * 0.018),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class NarrowLayout extends StatefulWidget {
  const NarrowLayout(
      {Key? key,
      required this.userController,
      required this.inputUser,
      required this.billUserController})
      : super(key: key);

  final UserController userController;
  final BillUserController billUserController;
  final User inputUser;

  @override
  State<NarrowLayout> createState() => _NarrowLayoutState();
}

class _NarrowLayoutState extends State<NarrowLayout> {
  late Future<User> _currentUser;
  late Future<List<Bill>> _allBillsWithUser;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.userController.getUserById(widget.inputUser.userID);
    _allBillsWithUser =
        widget.billUserController.getAllBillsWithUser(widget.inputUser);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        _currentUser,
        _allBillsWithUser,
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              Container(height: 8),
              Text(
                'Bills with ' +
                    snapshot.data![0].firstName.firstName +
                    ' ' +
                    snapshot.data![0].lastName.lastName,
                style: TextStyle(fontSize: 20),
              ),
              Container(height: 8),
              Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data![1].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Card(
                        elevation: 8,
                        child: ListTile(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SplitTheBillUnequallyScreen(
                                          billInputID: snapshot
                                              .data![1][index].billID))),
                          leading: Text(
                            snapshot.data![1][index].billType.billType
                                .substring(
                                    0,
                                    snapshot.data![1][index].billType.billType
                                        .indexOf(' ')),
                            style: TextStyle(fontSize: Get.width * 0.045),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  snapshot.data![1][index].billName.billName
                                      .toString(),
                                  style:
                                      TextStyle(fontSize: Get.width * 0.0375),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            'Date: ${snapshot.data![1][index].date.billDate}',
                            style: TextStyle(fontSize: Get.width * 0.018),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
