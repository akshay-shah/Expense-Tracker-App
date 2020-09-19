import 'package:expense_tracker/widgets/chartbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactionModel.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get getGroupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].dateTime.day == weekDay.day &&
            recentTransactions[i].dateTime.month == weekDay.month &&
            recentTransactions[i].dateTime.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {"day": DateFormat.E().format(weekDay), "amount": totalSum};
    }).reversed.toList();
  }

  double get maxSpending {
    return getGroupedTransactions.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(getGroupedTransactions);
    return Card(
      elevation: 4,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ...getGroupedTransactions.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    data['day'],
                    data['amount'],
                    maxSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / maxSpending),
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}
