import 'package:flutter/material.dart';

import '../screens/test_home_screen.dart';


//TODO: Fix alignment as icons are not properly aligned.

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState((){_selectedIndex = index;});
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            TestHomeScreen(screenIndex: _selectedIndex)));
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.pink,
      onTap: _onItemTapped,
    );
  }
}

/*
BottomNavigationBar bottomNavBar(BuildContext context, bool isHomeScreen) {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState((){_selectedIndex = index;});
  }

  return BottomNavigationBar(
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
    currentIndex: _selectedIndex,
    selectedItemColor: Colors.pink,
    onTap: null,
  );
}

    color: const Color(0xFF149cc9),
    shape: const CircularNotchedRectangle(),
    items: [ Container(
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
                          Icons.settings,
                          size: 30,
                        ),
                        Text(
                          'Settings',
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


 */
