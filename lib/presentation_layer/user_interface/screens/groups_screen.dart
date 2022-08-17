import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation_layer/controllers/groups/group_controller.dart';
import 'package:split_the_bill/presentation_layer/user_interface/widgets/general_app_bar.dart';

import '../../../dependency_injection/injection.dart';
import '../../../domain_layer/entities/bill_group.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({Key? key}) : super(key: key);

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: generalAppBar(context),
        body: LayoutBuilder(builder: (context, constraints) {
          return OnlyLayoutSoFar(groupController: getIt<GroupController>());
        }));
  }
}

class OnlyLayoutSoFar extends StatefulWidget {
  const OnlyLayoutSoFar({Key? key, required this.groupController})
      : super(key: key);

  final GroupController groupController;

  @override
  State<OnlyLayoutSoFar> createState() => _OnlyLayoutSoFarState();
}

class _OnlyLayoutSoFarState extends State<OnlyLayoutSoFar> {
  late Future<List<BillGroup>> _groups;

  @override
  void initState() {
    super.initState();
    _groups = widget.groupController.getAllGroups();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: _groups,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Card(
                        child: Ink(
                          child: ListTile(
                            onTap: () {},
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: Text(snapshot.data[index].groupName))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
