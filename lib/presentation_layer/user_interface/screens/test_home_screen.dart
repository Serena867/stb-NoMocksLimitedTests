import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation_layer/controllers/groups/group_controller.dart';
import 'package:split_the_bill/presentation_layer/controllers/user/user_controller.dart';
import 'package:split_the_bill/presentation_layer/user_interface/screens/settings.dart';
import 'package:split_the_bill/presentation_layer/user_interface/screens/users_screen.dart';

import '../../../dependency_injection/injection.dart';
import '../../../domain_layer/factories/IEntityFactory.dart';
import '../../controllers/bill/bill_controller.dart';
import 'groups_screen.dart';
import 'home_screen.dart';
import 'new_bill_screen.dart';

class TestHomeScreen extends StatefulWidget {
  const TestHomeScreen({Key? key, required this.screenIndex, this.tabIndex = 0}) : super(key: key);

  final int screenIndex;
  final int tabIndex;

  @override
  State<TestHomeScreen> createState() => _TestHomeScreenState();
}

class _TestHomeScreenState extends State<TestHomeScreen> {
  int _selectedScreen = 0;
  var _screenOptions = [];

  @override
  void initState() {
    _selectedScreen = widget.screenIndex;
    _screenOptions = [
      HomeScreen(defaultTab: widget.tabIndex),
      UsersScreen(userController: getIt<UserController>()),
      GroupsScreen(groupController: getIt<GroupController>()),
      NewBillScreen(
          billController: getIt<BillController>(),
          entityFactory: getIt<IEntityFactory>()),
      const Settings(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screenOptions[_selectedScreen],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 16,
        unselectedFontSize: 16,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 28),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_people, size: 28),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group, size: 28),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange, size: 28),
            label: 'New bill',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 28),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedScreen,
        selectedItemColor: Colors.pink,
        onTap: (index) {
          setState(() {
            _selectedScreen = index;
          });
        },
      ),
    );
  }
}
