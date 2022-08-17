import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation_layer/controllers/bill/bill_controller.dart';
import 'package:split_the_bill/presentation_layer/controllers/groups/group_controller.dart';
import '../../../dependency_injection/injection.dart';
import '../widgets/home_app_bar.dart';
import 'individual_bill_layout.dart';
import 'groups_all_layout.dart';

//TODO: Adjust layouts for mobile, tablet, and monitors (Microsoft standards for responsive design???)

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key, this.defaultTab = 0
  }) : super(key: key);

  final int defaultTab;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: widget.defaultTab);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context, tabController),
      body: TabBarView(
        controller: tabController,
        children: [
          IndividualBillLayout(billController: getIt<BillController>()),
          GroupLayout(groupController: getIt<GroupController>()),
        ],
      ),
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        //TODO: Decide whether or not to allow pictures for bills (receipts for ex).
        child: const Icon(Icons.add_a_photo),
      ),
      */
      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

