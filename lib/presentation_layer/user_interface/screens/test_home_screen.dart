import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation_layer/user_interface/screens/settings.dart';
import 'package:split_the_bill/presentation_layer/user_interface/screens/users_screen.dart';

import '../../../dependency_injection/injection.dart';
import '../../../domain_layer/factories/IEntityFactory.dart';
import '../../controllers/bill/bill_controller.dart';
import 'groups_screen.dart';
import 'home_screen.dart';
import 'new_bill_screen.dart';

class TestHomeScreen extends StatefulWidget {
  const TestHomeScreen({Key? key, required this.screenIndex}) : super(key: key);

  final int screenIndex;

  @override
  State<TestHomeScreen> createState() => _TestHomeScreenState();
}

class _TestHomeScreenState extends State<TestHomeScreen> {
  int _selectedScreen = 0;


  final _screenOptions = [
    HomeScreen(billController: getIt<BillController>()),
    UsersScreen(),
    GroupsScreen(),
    NewBillScreen(
        billController: getIt<BillController>(),
        entityFactory: getIt<IEntityFactory>()),
    Settings(),
  ];

  void initState() {
    _selectedScreen = widget.screenIndex;
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
