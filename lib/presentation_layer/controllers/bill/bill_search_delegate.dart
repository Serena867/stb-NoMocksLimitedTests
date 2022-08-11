import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation_layer/user_interface/screens/split_the_bill_unequally_screen.dart';
import '../../../domain_layer/entities/bill.dart';

class BillSearchDelegate extends SearchDelegate<String> {
  BillSearchDelegate({required this.allBills});

  final List<Bill> allBills;

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
    final List<Bill> bills = allBills
        .where((data) => data.billName.billName.toLowerCase().contains(
              query.toLowerCase(),
            ))
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.all(0.0),
      itemCount: bills.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(bills[index].billName.billName),
          subtitle: Text(bills[index].billType.billType),
          onTap: () {
            query = bills[index].billName.billName;
            close(context, query);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SplitTheBillUnequallyScreen(
                        billInputID: bills[index].billID)));
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Bill> suggestions = allBills
        .where((data) => data.billName.billName.toLowerCase().contains(
              query.toLowerCase(),
            ))
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.all(0.0),
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: Card(
            elevation: 8,
            child: ListTile(
              title: Text(suggestions.isNotEmpty
                  ? suggestions[index].billName.billName +
                      ':  ' +
                      suggestions[index].date.billDate
                  : 'ERROR LOADING DATA'),
              subtitle: Text(suggestions[index].billType.billType),
              onTap: () {
                query = suggestions[index].billName.billName;
                close(context, query);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SplitTheBillUnequallyScreen(
                            billInputID: suggestions[index].billID)));
              },
            ),
          ),
        );
      },
    );
  }
}
