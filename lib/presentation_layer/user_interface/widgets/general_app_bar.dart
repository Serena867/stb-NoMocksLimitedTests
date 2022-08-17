import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:split_the_bill/presentation_layer/controllers/bill/bill_controller.dart';
import 'package:split_the_bill/presentation_layer/user_interface/constants.dart';
import 'package:split_the_bill/presentation_layer/user_interface/screens/test_home_screen.dart';
import '../../../dependency_injection/injection.dart';
import '../../controllers/bill/bill_search_delegate.dart';
import '../screens/home_screen.dart';

//TODO: Adjust back button so it goes back and not home. Adjust navigator routing

PreferredSizeWidget generalAppBar(BuildContext context, {bool jumpToHome = false}) {
  return AppBar(
    automaticallyImplyLeading: false,
    systemOverlayStyle:
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    backgroundColor: AppColours.STB_BLUE,
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
    /*
    actions: [
      IconButton(
        //TODO: This should be conditional (listview screens), aligned differently, etc. Doesn't look good atm.
        onPressed: () {},
        icon: const Icon(
          Icons.list,
          color: Colors.black,
        ),
        tooltip: 'Search',
        splashColor: Colors.blue,
      ),
      IconButton(
        onPressed: () async {
          final searchResult = await showSearch(
            context: context,
            delegate: BillSearchDelegate(
                allBills: await getIt<BillController>().getAllBills()),
          );
        },
        icon: const Icon(
          Icons.search,
          color: Colors.black,
        ),
        tooltip: 'Search',
        splashColor: Colors.blue,
      ),
    ],
     */
    leading: jumpToHome ? ElevatedButton(
      //TODO: Adjust navigation (probably with pushReplacement)
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
    ) : ElevatedButton(
      //TODO: Adjust navigation (probably with pushReplacement)
      onPressed: () => Navigator.of(context).maybePop(),
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        elevation: 0.0,
      ),
      child: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    ),
  );
}
