import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:split_the_bill/presentation_layer/controllers/bill/bill_controller.dart';
import 'package:split_the_bill/presentation_layer/controllers/user/user_controller.dart';
import 'package:split_the_bill/presentation_layer/user_interface/screens/test_home_screen.dart';
import '../../../dependency_injection/injection.dart';
import '../../controllers/user/user_search_delegate.dart';
import '../screens/home_screen.dart';

PreferredSizeWidget userAppBar(BuildContext context, bool isLeading) {
  return AppBar(
    automaticallyImplyLeading: false,
    systemOverlayStyle:
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    backgroundColor: const Color(0xFF6EC6CA),
    elevation: 4,
    centerTitle: true,
    title: const Text(
      'Split the bill',
      style: TextStyle(
          color: Colors.black,
          fontSize: 45,
          fontFamily: 'OoohBaby',
          fontWeight: FontWeight.bold),
    ),
    actions: [
      IconButton(
        onPressed: () async {
          final searchResult = await showSearch(
            context: context,
            delegate: UserSearchDelegate(allUsers: await getIt<UserController>().getAllUsers()),
          );
        },
        icon: const Icon(Icons.person_search, color: Colors.black,),
        tooltip: 'Search',
        splashColor: Colors.blue,
      ),
    ],
    leading: isLeading
        ? ElevatedButton(
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              TestHomeScreen(screenIndex: 0))),
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        elevation: 0.0,
      ),
      child: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    )
        : null,
  );
}
