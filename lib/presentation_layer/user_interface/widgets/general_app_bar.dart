import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:split_the_bill/presentation_layer/controllers/bill/bill_controller.dart';
import '../../../dependency_injection/injection.dart';
import '../../controllers/bill/bill_search_delegate.dart';
import '../screens/home_screen.dart';

//TODO: Adjust back button so it goes back and not to home.
// Can use Navigator.pop(context) for this but needs a solution for all screens

PreferredSizeWidget generalAppBar(BuildContext context, bool isLeading) {
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
            delegate: BillSearchDelegate(allBills: await getIt<BillController>().getAllBills()),
          );
        },
        icon: const Icon(Icons.search, color: Colors.black,),
        tooltip: 'Search',
        splashColor: Colors.blue,
      ),
    ],
    leading: isLeading
        ? ElevatedButton( //TODO: Adjust navigation (probably with pushReplacement)
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    HomeScreen(billController: getIt<BillController>()))),
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
