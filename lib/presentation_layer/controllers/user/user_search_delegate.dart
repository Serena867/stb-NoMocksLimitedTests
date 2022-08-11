import 'package:flutter/material.dart';
import '../../../domain_layer/entities/user.dart';

class UserSearchDelegate extends SearchDelegate<String> {
  UserSearchDelegate({required this.allUsers});

  final List<User> allUsers;

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        if (query.isEmpty) {
          close(context, '');
        } else {
          query = '';
        }
      },
    )
  ];

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, query),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<User> users = allUsers
        .where((data) => data.firstName.firstName.toLowerCase().contains(
      query.toLowerCase(),
    ))
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.all(0.0),
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${users[index].firstName.firstName} ${users[index].lastName.lastName}'),
          subtitle: Text(users[index].email.email),
          onTap: () {
            query = users[index].firstName.firstName;
            close(context, query);
            /*
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SplitTheBillUnequallyScreen(
                        billInputID: users[index].userID)));
             */
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<User> userSuggestions = allUsers
        .where((data) => data.firstName.firstName.toLowerCase().contains(
      query.toLowerCase(),
    ))
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.all(0.0),
      itemCount: userSuggestions.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: Card(
            elevation: 8,
            child: ListTile(
              title: Text(userSuggestions.isNotEmpty
                  ? '${userSuggestions[index].firstName.firstName} ${userSuggestions[index].lastName.lastName}'
                  : 'ERROR LOADING DATA'),
              subtitle: Text(userSuggestions[index].email.email),
              onTap: () {
                query = userSuggestions[index].email.email;
                close(context, query);
                /*
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SplitTheBillUnequallyScreen(
                            billInputID: userSuggestions[index].userID)));
                 */
              },
            ),
          ),
        );
      },
    );
  }
}
