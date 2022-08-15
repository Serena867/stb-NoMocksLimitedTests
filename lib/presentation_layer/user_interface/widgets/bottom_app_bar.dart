import 'package:flutter/material.dart';
import 'package:split_the_bill/domain_layer/factories/IEntityFactory.dart';
import 'package:split_the_bill/presentation_layer/controllers/bill/bill_controller.dart';
import 'package:split_the_bill/presentation_layer/controllers/user/user_controller.dart';
import 'package:split_the_bill/presentation_layer/user_interface/constants.dart';
import 'package:split_the_bill/presentation_layer/user_interface/screens/home_screen.dart';
import '../../../dependency_injection/injection.dart';
import '../dialogs/add_user_dialog.dart';
import '../screens/users_screen.dart';
import '../screens/new_bill_screen.dart';

//TODO: Fix alignment as icons are not properly aligned.

BottomAppBar bottomAppBar(BuildContext context, bool isHomeScreen) {
  return BottomAppBar(
    color: const Color(0xFF149cc9),
    shape: const CircularNotchedRectangle(),
    child: Container(
      padding: const EdgeInsets.only(right: 50),
      height: 65,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox.fromSize( //TODO: Set this to not display on homescreen. Can't be null
            size: const Size(80, 65),
            child: ClipRect(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: AppColours.TAP_BUTTON_GREEN,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomeScreen(billController: getIt<BillController>()))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(
                          Icons.home,
                          size: 30,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        )
                      ],
                    ),
                  )),
            ),
          ),
          SizedBox.fromSize(
            size: const Size(80, 65),
            child: ClipRect(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: AppColours.TAP_BUTTON_GREEN,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const UsersScreen())),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(
                          Icons.people_alt_outlined,
                          size: 30,
                        ),
                        Text(
                          'Friends',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        )
                      ],
                    ),
                  )),
            ),
          ),
          SizedBox.fromSize(
            size: const Size(80, 65),
            child: ClipRect(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: AppColours.TAP_BUTTON_GREEN,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UsersScreen()));
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AddUserDialog(userController: getIt<UserController>(), entityFactory: getIt<IEntityFactory>());
                          });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(
                          Icons.person_add,
                          size: 30,
                        ),
                        Text(
                          'Add user',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        )
                      ],
                    ),
                  )),
            ),
          ),
          SizedBox.fromSize(
            size: const Size(80, 65),
            child: ClipRect(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: AppColours.TAP_BUTTON_GREEN,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NewBillScreen(billController: getIt<BillController>(), entityFactory: getIt<IEntityFactory>()))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(
                          Icons.currency_exchange,
                          size: 30,
                        ),
                        Text(
                          'New bill',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    ),
  );
}
