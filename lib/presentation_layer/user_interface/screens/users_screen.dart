import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation_layer/controllers/user/user_controller.dart';
import 'package:split_the_bill/presentation_layer/user_interface/screens/individual_user_screen.dart';
import 'package:split_the_bill/presentation_layer/user_interface/widgets/users_app_bar.dart';
import '../../../dependency_injection/injection.dart';
import '../../../domain_layer/entities/user.dart';
import '../dialogs/delete_user_dialog.dart';
import '../widgets/bottom_app_bar.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  @override
  void initState() {
    super.initState();
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6EC6CA),
      appBar: userAppBar(context, true),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 400) {
          return WideLayout(userController: getIt<UserController>());
        } else {
          return NarrowLayout(userController: getIt<UserController>());
        }
      }),
    );
  }
}

class WideLayout extends StatefulWidget {
  const WideLayout({Key? key, required this.userController}) : super(key: key);

  final UserController userController;

  @override
  State<WideLayout> createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  List<User> _users = [];
  final AsyncMemoizer _userMemoizer = AsyncMemoizer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: widget.userController.memoizeGetAllUsers(_userMemoizer),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              _users = snapshot.data;
              return Center(
                child: ListView.builder(
                    itemCount: _users.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 0, right: 0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 8.0,
                          child: Ink(
                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              gradient: LinearGradient(
                                  colors: [Colors.blue, Color(0xFF00e7f7)]),
                            ),
                            child: ListTile(
                              onTap: () => Navigator.of(context)
                                  .push(MaterialPageRoute(
                                  builder: (context) =>
                                      IndividualUserScreen(inputUser: _users[index],
                                          )))
                                  .then((value) => setState(() {})),
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
                                          return DeleteUserDialog(
                                            userID: _users[index].userID,
                                            userController:
                                                getIt<UserController>(),
                                          );
                                        });
                                  }),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${_users[index].firstName.firstName} ${_users[index].lastName.lastName}',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }
        });
  }
}

class NarrowLayout extends StatefulWidget {
  const NarrowLayout({Key? key, required this.userController})
      : super(key: key);

  final UserController userController;

  @override
  State<NarrowLayout> createState() => _NarrowLayoutState();
}

class _NarrowLayoutState extends State<NarrowLayout> {
  late Future<List<User>> _users;

  @override
  void initState() {
    super.initState();
    _users = widget.userController.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: _users,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8, left: 0, right: 0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 8.0,
                        child: Ink(
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            gradient: LinearGradient(
                                colors: [Colors.blue, Color(0xFF00e7f7)]),
                          ),
                          child: ListTile(
                            onTap: () => Navigator.of(context)
                                .push(MaterialPageRoute(
                                builder: (context) =>
                                    IndividualUserScreen(inputUser: snapshot.data[index],
                                    )))
                                .then((value) => setState(() {})),
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
                                        return DeleteUserDialog(
                                          userID: snapshot.data[index].userID,
                                          userController:
                                              getIt<UserController>(),
                                        );
                                      });
                                }),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    '${snapshot.data[index].firstName.firstName} ${snapshot.data[index].lastName.lastName}',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
